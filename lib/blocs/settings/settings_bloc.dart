import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:bro/blocs/settings/settings_event.dart';
import 'package:bro/blocs/settings/settings_state.dart';
import 'package:bro/data/settings_repository.dart';
import 'package:bro/models/languages.dart';
import 'package:flutter/cupertino.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsRepository repository;
  SettingsBloc({required this.repository}) : super(Loading());

  @override
  Stream<SettingsState> mapEventToState(SettingsEvent event) async* {
    // TODO: implement mapEventToState
    final currentState = state;

    final res = await _retrieve_languages(event);
    yield res;
  }

  Future<SettingsState> _retrieve_languages(event) async {
    try {
      if(event is LanguagesRequested)
      return await repository.getLanguages().then((res) {
        final languages = Languages.fromJson(res.data!);
        debugPrint("kom hit");
        return Success(languages: languages);
      });
      else if (event is CurrentLanguageRequested)
        {
          return await repository.getSelectedLang().then((lang){
          return getLangSuccess(lang:lang);
          });
        }
       return Failed();
    } on NetworkException catch (e, stackTrace) {
      log(e.toString());
      log(stackTrace.toString());
      return Failed();
    } catch (e, stackTrace) {
      log(e.toString());
      log(stackTrace.toString());

      return Failed();
    }
  }
}
