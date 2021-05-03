import 'dart:async';
import 'dart:developer';
import 'package:bro/blocs/preferred_language/preferred_language_bucket.dart';
import 'package:bro/blocs/resource_list/resource_list_bucket.dart';
import 'package:bro/data/preferred_language_repository.dart';
import 'package:bro/data/resource_repository.dart';
import 'package:bro/models/resource.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class ResourceListBloc extends Bloc<ResourceListEvent, ResourceListState> {
  ResourceRepository repository;
  late String previousCategoryId;
  PreferredLanguageBloc preferredLanguageBloc;
  late StreamSubscription preferredLanguageSubscription;
  late PreferredLanguageRepository preferredLanguageRepository;
  late bool recommended;
  ResourceListBloc(
      {required this.repository,
      required this.preferredLanguageBloc,
      recommended})
      : super(InitialResourceList()) {
    // Uses the preferredLanguageBloc, and listens for states.
    // If the state in the preferredLanguageRepository is set to "LanguageChanged",
    // then it needs to refetch a version of the resourceList which is in the correct language.
    // Upon a "LanguageChanged"-event in the preferrredLanguageBloc,
    // it triggers a ResourceListRequested-event, which retrieves a new version of
    // the current resourceList with the correct language.
    preferredLanguageRepository = preferredLanguageBloc.repository;
    this.recommended = recommended ?? false;
    preferredLanguageSubscription =
        preferredLanguageBloc.stream.listen((state) {
      if (state is LanguageChanged) {
        add(ResourceListRefresh(preferredLang: state.preferredLang));
      }
    });
  }

  @override
  Stream<ResourceListState> mapEventToState(ResourceListEvent event) async* {
    yield ResourceListLoading();
    // If the event is ResourceListRequested, then it re-requests the resources to fetch the list with the corrent language.
    if (event is ResourceListRequested) {
      try {
        previousCategoryId = event.category_id;
        yield await _retrieveResources(event, 0);
      } catch (e, stackTrace) {
        log(e.toString());
        log(stackTrace.toString());

        yield ResourceListFailed(err: 'Error, bad request');
      }
    }
    if (event is ResourceListRefresh) {
      try {
        yield await _retrieveResourcesOnRefresh(event);
      } catch (e) {
        log(e.toString());
        yield ResourceListFailed(err: 'Error refresh failed, bad request');
      }
    }
  }

  Future<ResourceListState> _retrieveResourcesOnRefresh(
      ResourceListRefresh event) async {
    var langSlug = event.preferredLang;
    var categoryId;
    recommended ? categoryId = '' : categoryId = previousCategoryId;
    var resourcesQueryResult =
        await repository.getLangResources(langSlug, categoryId, recommended);
    var resourcesJson = List<Map<String, dynamic>>.from(
        resourcesQueryResult.data!['LangResource']);
    var resources = ResourceList.takeList(resourcesJson).resources;
    return ResourceListSuccess(resources: resources);
  }

  Future<ResourceListState> _retrieveResources(
    ResourceListRequested event,
    int curr_len,
  ) async {
    var langSlug = await preferredLanguageRepository.getPreferredLangSlug();
    try {
      // Sends the request, deserializes into models and returns a state of ResourceListSuccess
      return await repository
          .getFalseLangResources(langSlug, event.category_id, recommended)
          .then((res) async {
        if (res.data!.isEmpty) {
          return ResourceListFailed(err: 'Error, bad request');
        }

        return ResourceListSuccess(
            resources: ResourceList.takeList(
                    List<Map<String, dynamic>>.from(res.data!['resources']))
                .resources
                .where((element) {
          return (element.publisher != null && element.resourceGroup != null);
        }).toList());
      });
    } on NetworkException catch (e, stackTrace) {
      log(e.toString());
      log(stackTrace.toString());
      return ResourceListFailed(err: 'Error, failed to contact server');
    } catch (e, stackTrace) {
      log(e.toString());
      log(stackTrace.toString());

      return ResourceListFailed(err: 'Error, bad request');
    }
  }
}
