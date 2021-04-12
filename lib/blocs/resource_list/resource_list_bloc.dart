import 'dart:developer';
import 'package:bro/blocs/resource_list/resource_list_bucket.dart';
import 'package:bro/data/resource_repository.dart';
import 'package:bro/models/resource.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class ResourceListBloc extends Bloc<ResourceListEvent, ResourceListState> {
  ResourceRepository repository;

  ResourceListBloc({required this.repository}) : super(Loading());

  @override
  Stream<ResourceListState> mapEventToState(ResourceListEvent event) async* {
    if (event is ResourceListRequested) {
      try {
        yield await _retrieveResources(event, 'NO');
      } catch (e, stackTrace) {
        log(e.toString());
        log(stackTrace.toString());

        yield Failed(err: 'Error, bad request.');
      }
    }
  }

  Future<ResourceListState> _retrieveResources(
      ResourceListRequested event, String pref_lang_slug) async {
    try {
      return await repository.getResource(pref_lang_slug).then((res) async {
        if (res.data!.isEmpty) {
          final fallbackCourseResult = await repository.getResource('NO');

          final fallbackResource =
              Data.fromJson(fallbackCourseResult.data!['resources']);

          return Success(resources: fallbackResource);
        } else if (res.data!.isNotEmpty) {
          try {
            final returnResource = Data.fromJson(res.data!['resources']);

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
