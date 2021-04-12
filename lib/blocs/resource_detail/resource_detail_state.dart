import 'package:bro/models/resource.dart';
import 'package:equatable/equatable.dart';

abstract class ResourceDetailState extends Equatable {
  ResourceDetailState();

  @override
  List<Object> get props => [];
}

class Loading extends ResourceDetailState {}

class Success extends ResourceDetailState {
  final Resources resource;

  Success({required this.resource});

  @override
  List<Object> get props => [resource];

  @override
  String toString() => 'Success { resource: $resource }';
}

class Failed extends ResourceDetailState {
  final String err;
  Failed({required this.err});

  @override
  List<Object> get props => [err];
}
