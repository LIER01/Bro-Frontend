import 'package:equatable/equatable.dart';

abstract class ResourceListEvent extends Equatable {
  ResourceListEvent();

  @override
  List get props => [];
}

class ResourceListRequested extends ResourceListEvent {
  final String lang;
  final String category_id;

  ResourceListRequested({required this.lang, required this.category_id});

  @override
  List get props => [lang];
}

class ResourceListRefresh extends ResourceListEvent {
  final String preferredLang;

  ResourceListRefresh({required this.preferredLang});

  @override
  List get props => [preferredLang];
}
