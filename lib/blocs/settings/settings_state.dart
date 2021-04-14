import 'package:bro/blocs/settings/settings_bucket.dart';
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
}

class getLangSuccess extends SettingsState {
  final String lang;
  getLangSuccess({required this.lang});
  getLangSuccess copyWith({required String lang}){
    return getLangSuccess(lang: lang);
  }
}

class Failed extends SettingsState {}
