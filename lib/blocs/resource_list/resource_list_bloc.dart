import 'dart:developer';
import 'package:bro/blocs/resource_list/resource_list_bucket.dart';
import 'package:bro/data/resource_repository.dart';
import 'package:bro/models/resource.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class ResourceListBloc extends Bloc<ResourceListEvent, ResourceListState> {
  ResourceRepository repository;

  ResourceListBloc({required this.repository}) : super(Loading());

  @override
  Stream<ResourceListState> mapEventToState(ResourceListEvent event) async* {
    if (event is ResourceListRequested) {
      try {
        yield await _retrieveResources(event, 0);
      } catch (e, stackTrace) {
        log(e.toString());
        log(stackTrace.toString());

        yield Failed(err: 'Error, bad request.');
      }
    }
  }

  Future<ResourceListState> _retrieveResources(
      ResourceListRequested event, int curr_len) async {
    try {
      return await repository
          .getLangResources('NO', 1 /* , curr_len, 10 */)
          .then((res) async {
        if (res.data!.isEmpty) {
          print('WHAT IS HAPPENING' + res.data.toString());
          final fallbackResourceResult = await repository.getResource('NO');

          final fallbackResource = ResourceList.takeList(
                  List<Map<String, dynamic>>.from(
                      fallbackResourceResult.data!['resources']))
              .resources;
          return Success(resources: fallbackResource);
        } else if (res.data!.isNotEmpty) {
          print('WHAT IS HAPPENING' + res.data.toString());
          try {
            final returnResource = ResourceList.takeList(
                    List<Map<String, dynamic>>.from(res.data!['resources']))
                .resources;

            return Success(resources: returnResource);
          } catch (e, stackTrace) {
            log(e.toString());
            log(stackTrace.toString());
            print('why!');
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
