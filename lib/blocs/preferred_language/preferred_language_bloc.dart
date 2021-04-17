import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:bro/blocs/preferred_language/preferred_language_bucket.dart';
import 'package:bro/data/preferred_language_repository.dart';

class PreferredLanguageBloc extends Bloc<PreferredLanguageEvent, PreferredLanguageState> {
  PreferredLanguageRepository repository;

  PreferredLanguageBloc({required this.repository}) : super(Initial());

  @override
  Stream<PreferredLanguageState> mapEventToState(
      PreferredLanguageEvent event) async* {
    if(event is MutatePreferredLanguage){
      String prefLang = event.preferredLanguage;
      await repository.setSelectedLang(prefLang);
      yield LanguageChanged(newLang: event.preferredLanguage);
    }
    else if (event is PreferredLanguageRequested){
      String res = await repository.getSelectedLang();
      yield LanguageChanged(newLang: res);
    }
  }

}
