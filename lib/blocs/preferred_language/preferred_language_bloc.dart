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
    if (event is MutatePreferredLang) {
      await repository.setPreferredLangSlug(event.preferredLang);
      yield LanguageChanged(preferredLang: event.preferredLang);
    } else if (event is PreferredLanguageRequested || state is Initial) {
      var res = await repository.getPreferredLangSlug();
      yield LanguageChanged(preferredLang: res);
    }
  }
}
