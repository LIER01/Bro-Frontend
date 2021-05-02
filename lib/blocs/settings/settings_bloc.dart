import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:bro/blocs/settings/settings_event.dart';
import 'package:bro/blocs/settings/settings_state.dart';
import 'package:bro/data/settings_repository.dart';
import 'package:bro/models/languages.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final SettingsRepository repository;

  SettingsBloc({required this.repository}) : super(SettingsLoading());

  @override
  Stream<SettingsState> mapEventToState(SettingsEvent event) async* {
    if (event is LanguagesRequested) {
      yield await _retrieve_languages(event);
    }
  }

  Future<SettingsState> _retrieve_languages(event) async {
    try {
      if (event is LanguagesRequested) {
        final res = await repository.getLanguages();
        final languages = Languages.fromJson(res.data!);
        return SettingsSuccess(languages: languages);
      }
      return SettingsFailed();
    } on NetworkException catch (e, stackTrace) {
      log(e.toString());
      log(stackTrace.toString());
      return SettingsFailed();
    } catch (e, stackTrace) {
      log(e.toString());
      log(stackTrace.toString());
      return SettingsFailed();
    }
  }
}
