import 'package:equatable/equatable.dart';

abstract class ResourceListEvent extends Equatable {
  ResourceListEvent();

  @override
  List get props => [];
}

class ResourceListRequested extends ResourceListEvent {
  final String lang;

  ResourceListRequested({required this.lang});

  @override
  List get props => [lang];
}
