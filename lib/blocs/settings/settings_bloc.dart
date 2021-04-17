import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:bro/blocs/settings/settings_event.dart';
import 'package:bro/blocs/settings/settings_state.dart';
import 'package:bro/data/settings_repository.dart';
import 'package:bro/models/languages.dart';
import 'package:flutter/cupertino.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final SettingsRepository repository;

  late List<String> githubRepositories;

  SettingsBloc({required this.repository}) : super(Loading());

  @override
  Stream<SettingsState> mapEventToState(SettingsEvent event) async* {
    // TODO: implement mapEventToState
    //final currentState = state;
    final res = await _retrieve_languages(event);
    yield res;
    /*
    if (event is LanguagesRequested) {
      final res = await _retrieve_languages(event);
      yield res;
    }
    if (event is CurrentLanguageRequested){
      final res = await repository.getSelectedLang();
      yield getLangSuccess(lang: res);
    }
     */
  }

  Future<SettingsState> _retrieve_languages(event) async {
    try {
      if (event is LanguagesRequested) {
        final res = await repository.getLanguages();
        final languages = Languages.fromJson(res.data!);
        final lang = await repository.getSelectedLang();
        return Success(languages: languages, lang: lang);
        /*return await repository.getLanguages().then((res) {
          final languages = Languages.fromJson(res.data!);
          debugPrint("kom hit");
          return Success(languages: languages);
        });*/
      } else if (event is MutateCurrentLanguage) {
        repository.setSelectedLang(event.lang!);
        final res = await repository.getLanguages();
        final languages = Languages.fromJson(res.data!);
        return Success(languages: languages, lang: event.lang!);
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
