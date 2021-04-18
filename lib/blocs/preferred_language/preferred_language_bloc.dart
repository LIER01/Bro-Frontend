import 'package:bloc/bloc.dart';
import 'package:bro/blocs/preferred_language/preferred_language_bucket.dart';
import 'package:bro/data/preferred_language_repository.dart';

/// Handles setting and getting the preferredLanguageSlug.
/// All blocs that need preferredLanguageSlug has to subscribe to this bloc.
class PreferredLanguageBloc
    extends Bloc<PreferredLanguageEvent, PreferredLanguageState> {
  PreferredLanguageRepository repository;

  PreferredLanguageBloc({required this.repository}) : super(Initial());

  @override
  Stream<PreferredLanguageState> mapEventToState(
      PreferredLanguageEvent event) async* {
    if (event is MutatePreferredLanguage) {
      await repository.setPreferredLangSlug(event.preferredLanguage);
      yield LanguageChanged(newLang: event.preferredLanguage);
    } else if (event is PreferredLanguageRequested) {
      var res = await repository.getPreferredLangSlug();
      yield LanguageChanged(newLang: res);
    }
  }
}
