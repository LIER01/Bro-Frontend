import 'dart:developer';

import 'package:bro/blocs/resource_list/resource_list_bucket.dart';
import 'package:bro/data/resource_repository.dart';
import 'package:bro/models/resource.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

class ResourceListBloc extends Bloc<ResourceListEvent, ResourceListState> {
  ResourceRepository repository;

  ResourceListBloc({@required this.repository})
      : assert(repository != null),
        super(Loading());

  @override
  Stream<ResourceListState> mapEventToState(ResourceListEvent event) async* {
    // Not able to access state methods without this. Do not know why.
    final currentState = state;
    if (event is ResourceListRequested && !_hasReachedMax(currentState)) {
      try {
        if (currentState is Loading) {
          final result = await repository.getResources(0, 10);

          final resources = result.data['resources'] as List<dynamic>;

          final listOfResources = resources
              .map((dynamic e) => Resource(
                    title: e['title'],
                    description: e['description'],
                    lang: e['lang'],
                    group: e['group'],
                    publisher: e['publisher'],
                    category: e['category'],
                    isRecommended: e['isRecommended'],
                    references: e['references'],
                  ))
              .toList();

          yield Success(resources: listOfResources, hasReachedMax: false);
          return;
        }

        if (currentState is Success) {
          final result =
              await repository.getResources(currentState.resources.length, 10);
          final resources = result.data['resources'];
          yield resources.length == 0
              ? currentState.copyWith(hasReachedMax: true)
              : Success(
                  resources: currentState.resources + resources,
                  hasReachedMax: false,
                );
        }
      } catch (e, stackTrace) {
        log(e.toString());
        log(stackTrace.toString());

        yield Failed();
      }
    }
  }
}

bool _hasReachedMax(ResourceListState state) =>
    state is Success && state.hasReachedMax;
