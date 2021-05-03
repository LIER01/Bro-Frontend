import 'package:equatable/equatable.dart';

abstract class ResourceDetailEvent extends Equatable {
  ResourceDetailEvent();

  @override
  List get props => [];
}

class ResourceDetailRefresh extends ResourceDetailEvent {
  ResourceDetailRefresh();

  @override
  List get props => [];
}

class ResourceDetailRequested extends ResourceDetailEvent {
  final String group;

  ResourceDetailRequested({required this.group});

  @override
  List get props => [group];
}
