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
    preferredLanguageRepository = preferredLanguageBloc.repository;
    preferredLanguageSubscription =
        preferredLanguageBloc.stream.listen((state) {
      if (state is LanguageChanged) {
        add(ResourceListRequested(
            lang: state.newLang, category_id: previousCategoryId));
      }
    });
  }

  @override
  Stream<ResourceListState> mapEventToState(ResourceListEvent event) async* {
    if (event is ResourceListRequested) {
      try {
        previousCategoryId = event.category_id;
        yield await _retrieveResources(event, 0);
      } catch (e, stackTrace) {
        log(e.toString());
        log(stackTrace.toString());

        yield Failed(err: 'Error, bad request.');
      }
    }
  }

  Future<ResourceListState> _retrieveResources(
    ResourceListRequested event,
    int curr_len,
    //Fiks så den loader mer
  ) async {
    var langSlug = await preferredLanguageRepository.getPreferredLangSlug();
    try {
      return await repository
          .getLangResources(langSlug, event.category_id)
          .then((res) async {
        if (res.data!.isEmpty) {
          final fallbackResourceResult =
              await repository.getLangResources(langSlug, event.category_id);

          var fallbackResource = ResourceList.takeList(
                  List<Map<String, dynamic>>.from(
                      fallbackResourceResult.data!['resources']))
              .resources
              //Checks that all relations not used in the query are included
              .where((element) {
            return (element.publisher != null && element.resourceGroup != null);
          }).toList();

          return Success(resources: fallbackResource);
        } else if (res.data!.isNotEmpty) {
          try {
            final returnResource = ResourceList.takeList(
                    List<Map<String, dynamic>>.from(res.data!['resources']))
                .resources
                .where((element) {
              return (element.publisher != null &&
                  element.resourceGroup != null);
            }).toList();

            return Success(resources: returnResource);
          } catch (e, stackTrace) {
            log(e.toString());
            log(stackTrace.toString());
            return Failed(err: 'Error, bad request');
          }
        } else {
          return Failed(err: 'Error, bad request');
        }
      });
    } on NetworkException catch (e, stackTrace) {
      log(e.toString());
      log(stackTrace.toString());
      return Failed(err: 'Error, failed to contact server');
    } catch (e, stackTrace) {
      log(e.toString());
      log(stackTrace.toString());

      return Failed(err: 'Error, bad request');
    }
  }
}
