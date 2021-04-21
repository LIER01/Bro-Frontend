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
  final String preferredLang;

  LanguageChanged({required this.preferredLang}) : super();

  @override
  List<Object> get props => [preferredLang];

  @override
  String toString() => 'Success { newLang: $preferredLang}';
}
