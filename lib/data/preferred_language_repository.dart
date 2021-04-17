import 'package:shared_preferences/shared_preferences.dart';

class PreferredLanguageRepository {
   Future<String> getSelectedLang() {
    return SharedPreferences.getInstance()
        .then((value) => value.getString('lang') ?? 'NO');
  }

  Future<bool> setSelectedLang(String lang) {
     return SharedPreferences.getInstance()
        .then((prefs) => prefs.setString('lang', lang));
  }
}
