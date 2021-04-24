import 'package:shared_preferences/shared_preferences.dart';

/// Sets and gets the preferred language slug from SharedPreferences.
/// Default select language is 'NO'
class PreferredLanguageRepository {
  /// The default preferred language is 'NO'
  Future<String> getPreferredLangSlug() {
    return SharedPreferences.getInstance()
        .then((value) => value.getString('lang') ?? 'NO');
  }

  Future<bool> setPreferredLangSlug(String lang) {
    return SharedPreferences.getInstance()
        .then((prefs) => prefs.setString('lang', lang));
  }
}
