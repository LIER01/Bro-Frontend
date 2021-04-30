import 'package:equatable/equatable.dart';

abstract class ResourceListEvent extends Equatable {
  ResourceListEvent();

  @override
  List get props => [];
}

class ResourceListRequested extends ResourceListEvent {
  final String category_id;

  ResourceListRequested({required this.category_id});

  @override
  List get props => [category_id];
}

class ResourceListRefresh extends ResourceListEvent {
  final String preferredLang;

  ResourceListRefresh({required this.preferredLang});

  @override
  List get props => [preferredLang];
}
