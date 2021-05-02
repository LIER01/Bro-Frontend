import 'package:bro/models/resource.dart';
import 'package:equatable/equatable.dart';

abstract class ResourceDetailState extends Equatable {
  ResourceDetailState();

  @override
  List<Object> get props => [];
}

class ResourceDetailLoading extends ResourceDetailState {}

class InitialDetailList extends ResourceDetailState {}

class ResourceDetailSuccess extends ResourceDetailState {
  final Resources resource;

  ResourceDetailSuccess({required this.resource});

  @override
  List<Object> get props => [resource];

  @override
  String toString() => 'Success { resource: $resource }';
}

class ResourceDetailFailed extends ResourceDetailState {
  final String err;
  ResourceDetailFailed({required this.err});

  @override
  List<Object> get props => [err];
}
