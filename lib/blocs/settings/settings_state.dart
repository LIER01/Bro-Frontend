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
  String lang;
  Success({required this.languages, required this.lang});
  Success copyWith({required Languages languages, required String lang}) {
    return Success(languages: languages, lang: lang);
  }
}

class Failed extends SettingsState{}