import 'package:equatable/equatable.dart';

abstract class PreferredLanguageState extends Equatable {
  PreferredLanguageState();
  @override
  List<Object> get props => [];
}

class Initial extends PreferredLanguageState {}

class PreferredLanguageLoading extends PreferredLanguageState {
  PreferredLanguageLoading();
}

class LanguageChanged extends PreferredLanguageState {
  final String newLang;

  LanguageChanged({required this.newLang}) : super();

  @override
  List<Object> get props => [newLang];

  @override
  String toString() => 'Success { newLang: $newLang}';
}
