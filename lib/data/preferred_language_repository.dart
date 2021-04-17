import 'package:shared_preferences/shared_preferences.dart';

class PreferredLanguageRepository {
  static Future<String> getSelectedLang() {
    return SharedPreferences.getInstance()
        .then((value) => value.getString('lang') ?? 'NO');
  }

  void setSelectedLang(String lang) {
    SharedPreferences.getInstance()
        .then((prefs) => prefs.setString('lang', lang));
  }

}
