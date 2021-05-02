import 'dart:async';
import 'dart:developer';

import 'package:bro/blocs/preferred_language/preferred_language_bucket.dart';
import 'package:bro/blocs/resource_detail/resource_detail_bucket.dart';
import 'package:bro/data/preferred_language_repository.dart';
import 'package:bro/data/resource_repository.dart';
import 'package:bro/models/resource.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class ResourceDetailBloc
    extends Bloc<ResourceDetailEvent, ResourceDetailState> {
  ResourceRepository repository;
  PreferredLanguageBloc preferredLanguageBloc;
  late StreamSubscription preferredLanguageSubscription;
  late PreferredLanguageRepository preferredLanguageRepository;

  ResourceDetailBloc(
      {required this.repository, required this.preferredLanguageBloc})
      : super(InitialDetailList()) {
    // Uses the preferredLanguageBloc, and listens for states.
    // If the state in the preferredLanguageRepository is set to "LanguageChanged",
    // then it needs to refetch a version of the resourceDetail which is in the correct language.
    // Upon a "LanguageChanged"-event in the preferrredLanguageBloc,
    // it triggers a ResourceDetailRefresh-event, which retrieves a new version of
    // the current resourceDetail with the correct language.
    preferredLanguageRepository = preferredLanguageBloc.repository;
    preferredLanguageSubscription =
        preferredLanguageBloc.stream.listen((state) {
      if (state is LanguageChanged) {
        add(ResourceDetailRefresh(preferredLang: state.preferredLang));
      }
    });
  }

  @override
  Stream<ResourceDetailState> mapEventToState(
      ResourceDetailEvent event) async* {
    if (event is ResourceDetailRequested) {
      try {
        yield await _retrieveResource(event, event.lang);
      } catch (e, stackTrace) {
        log(e.toString());
        log(stackTrace.toString());

        yield Failed(err: 'Error, bad request.');
      }
    }
    // If the event is an instance of ResourceDetailreresh, then we need to refetch the ResourceDetail with the correct language
    if (event is ResourceDetailRefresh) {
      // We need to make a snapshot of the state, as the state may change during the execution.
      var currentState = state;

      // If the currentState is success, then we refetch a new resourceDetail by adding a new event of type ResourceDetailRequested into the stream.
      if (currentState is Success) {
        add(ResourceDetailRequested(
            group: currentState.resource.resourceGroup.toString(),
            lang: event.preferredLang));
      } else {
        yield Failed(err: 'Failed to refresh list with languages');
        return;
      }
    }
  }

  //

  Future<ResourceDetailState> _retrieveResource(
      ResourceDetailRequested event, String pref_lang_slug) async {
    try {
      return await repository
          .getResource(pref_lang_slug, event.group)
          .then((res) async {
        if (res.data!.isEmpty) {
          return Failed(err: 'Article does not exist in requested langauge');
        } else if (res.data!.isNotEmpty) {
          try {
            final returnResource =
                Resources.fromJson(res.data!['resources'][0]);

            return Success(resource: returnResource);
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
