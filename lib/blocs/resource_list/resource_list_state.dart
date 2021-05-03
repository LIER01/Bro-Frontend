import 'package:bro/models/resource.dart';
import 'package:equatable/equatable.dart';

abstract class ResourceListState extends Equatable {
  ResourceListState();

  @override
  List<Object> get props => [];
}

class InitialResourceList extends ResourceListState {}

class ResourceListLoading extends ResourceListState {}

class ResourceListSuccess extends ResourceListState {
  final List<Resources> resources;

  ResourceListSuccess({required this.resources});

  @override
  List<Object> get props => [resources];

  @override
  String toString() => 'Success { data: $resources }';
}

class ResourceListFailed extends ResourceListState {
  final String err;
  ResourceListFailed({required this.err});

  @override
  List<Object> get props => [err];
}
