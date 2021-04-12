import 'package:bro/models/resource.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class ResourceListState extends Equatable {
  ResourceListState();

  @override
  List<Object> get props => [];
}

class Initial extends ResourceListState {}

class Loading extends ResourceListState {}

class Success extends ResourceListState {
  final List<Resource> resources;
  final bool hasReachedMax;

  Success({@required this.resources, @required this.hasReachedMax})
      : assert(resources != null && hasReachedMax != null);

  Success copyWith({
    List<Resource> resources,
    bool hasReachedMax,
  }) {
    return Success(
        resources: resources ?? this.resources,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax);
  }

  @override
  List<Object> get props => [resources, hasReachedMax];

  @override
  String toString() =>
      'Success { resources: $resources, hasReachedMax: $hasReachedMax }';
}

class Failed extends ResourceListState {}
