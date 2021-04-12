import 'package:equatable/equatable.dart';

abstract class ResourceListEvent extends Equatable {
  ResourceListEvent();

  @override
  List get props => [];
}

class ResourceListRequested extends ResourceListEvent {}
