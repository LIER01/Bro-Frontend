import 'package:bro/models/languages.dart';
import 'package:equatable/equatable.dart';

abstract class SettingsState extends Equatable {
  SettingsState();

  @override
  List<Object> get props => [];
}

class Initial extends SettingsState {}

class SettingsLoading extends SettingsState {}

class SettingsSuccess extends SettingsState {
  final Languages languages;
  SettingsSuccess({required this.languages});
  SettingsSuccess copyWith({required Languages languages}) {
    return SettingsSuccess(languages: languages);
  }

  @override
  List<Object> get props => [languages];
}

class SettingsFailed extends SettingsState {}
