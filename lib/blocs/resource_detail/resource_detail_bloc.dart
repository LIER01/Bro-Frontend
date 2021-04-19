import 'dart:developer';

import 'package:bro/blocs/resource_detail/resource_detail_bucket.dart';
import 'package:bro/data/resource_repository.dart';
import 'package:bro/models/resource.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class ResourceDetailBloc
    extends Bloc<ResourceDetailEvent, ResourceDetailState> {
  ResourceRepository repository;

  ResourceDetailBloc({required this.repository}) : super(Loading());

  @override
  Stream<ResourceDetailState> mapEventToState(
      ResourceDetailEvent event) async* {
    if (event is ResourceDetailRequested) {
      try {
        yield await _retrieveResource(event, 'NO');
      } catch (e, stackTrace) {
        log(e.toString());
        log(stackTrace.toString());

        yield Failed(err: 'Error, bad request.');
      }
    }
  }

  Future<ResourceDetailState> _retrieveResource(
      ResourceDetailRequested event, String pref_lang_slug) async {
    try {
      return await repository
          .getResource(pref_lang_slug, event.group)
          .then((res) async {
        if (res.data!.isEmpty) {
          final fallbackResourseResult =
              await repository.getResource('NO', event.group);

          final fallbackResource =
              Resources.fromJson(fallbackResourseResult.data!['resources'][0]);

          return Success(resource: fallbackResource);
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
