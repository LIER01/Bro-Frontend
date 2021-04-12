import 'package:bro/models/resource.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class ResourceDetailState extends Equatable {
  ResourceDetailState();

  @override
  List<Object> get props => [];
}

class Loading extends ResourceDetailState {}

class Success extends ResourceDetailState {
  final Resource resource;

  Success({@required this.resource}) : assert(resource != null);

  @override
  List<Resource> get props => [resource];

  @override
  String toString() => 'Success { resource: $resource }';
}

class Failed extends ResourceDetailState {}
