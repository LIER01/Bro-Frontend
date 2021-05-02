import 'package:equatable/equatable.dart';

abstract class ResourceDetailEvent extends Equatable {
  ResourceDetailEvent();

  @override
  List get props => [];
}

class ResourceDetailRefresh extends ResourceDetailEvent {
  final String preferredLang;
  ResourceDetailRefresh({required this.preferredLang});

  @override
  List get props => [preferredLang];
}

class ResourceDetailRequested extends ResourceDetailEvent {
  final String lang;
  final String group;

  ResourceDetailRequested({required this.lang, required this.group});

  @override
  List get props => [lang, group];
}
