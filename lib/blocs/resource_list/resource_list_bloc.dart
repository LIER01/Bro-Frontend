import 'dart:async';
import 'dart:developer';
import 'package:bro/blocs/preferred_language/preferred_language_bucket.dart';
import 'package:bro/blocs/resource_list/resource_list_bucket.dart';
import 'package:bro/data/preferred_language_repository.dart';
import 'package:bro/data/resource_repository.dart';
import 'package:bro/models/resource.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class ResourceListBloc extends Bloc<ResourceListEvent, ResourceListState> {
  ResourceRepository repository;
  late String previousCategoryId;
  PreferredLanguageBloc preferredLanguageBloc;
  late StreamSubscription preferredLanguageSubscription;
  late PreferredLanguageRepository preferredLanguageRepository;

  ResourceListBloc(
      {required this.repository, required this.preferredLanguageBloc})
      : super(Loading()) {
    // Uses the preferredLanguageBloc, and listens for states.
    // If the state in the preferredLanguageRepository is set to "LanguageChanged",
    // then it needs to refetch a version of the resourceList which is in the correct language.
    // Upon a "LanguageChanged"-event in the preferrredLanguageBloc,
    // it triggers a ResourceListRequested-event, which retrieves a new version of
    // the current resourceList with the correct language.
    preferredLanguageRepository = preferredLanguageBloc.repository;
    preferredLanguageSubscription =
        preferredLanguageBloc.stream.listen((state) {
      if (state is LanguageChanged) {
        add(ResourceListRequested(
            lang: state.preferredLang, category_id: previousCategoryId));
      }
    });
  }

  @override
  Stream<ResourceListState> mapEventToState(ResourceListEvent event) async* {
    // If the event is ResourceListRequested, then it re-requests the resources to fetch the list with the corrent language.
    if (event is ResourceListRequested) {
      try {
        previousCategoryId = event.category_id;
        yield await _retrieveResources(event, 0);
      } catch (e, stackTrace) {
        log(e.toString());
        log(stackTrace.toString());

        yield ResourceListFailed(err: 'Error, bad request.');
      }
    }
  }

  Future<ResourceListState> _retrieveResources(
    ResourceListRequested event,
    int curr_len,
  ) async {
    var langSlug = event.lang;
    try {
      // Sends the request, deserializes into models and returns a state of ResourceListSuccess
      return await repository
          .getLangResources(langSlug, event.category_id)
          .then((res) async {
        var resourceList = ResourceList.takeList(
                List<Map<String, dynamic>>.from(res.data!['resources']))
            .resources
            //Checks that all relations not used in the query are included
            .where((element) {
          return (element.publisher != null && element.resourceGroup != null);
        }).toList();

        return ResourceListSuccess(resources: resourceList);
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
