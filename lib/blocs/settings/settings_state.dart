import 'package:bro/models/languages.dart';
import 'package:equatable/equatable.dart';

abstract class SettingsState extends Equatable {
  SettingsState();

  @override
  List<Object> get props => [];
}

class Initial extends SettingsState {}

class Loading extends SettingsState {}

class Success extends SettingsState {
  final Languages languages;
  Success({required this.languages});
  Success copyWith({required Languages languages}) {
    return Success(languages: languages);
  }

  @override
  List<Object> get props => [languages];
}

class Failed extends SettingsState {}
