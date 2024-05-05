import 'package:shared_preferences/shared_preferences.dart';

class LanguageSetting {
  static final LanguageSetting ls = LanguageSetting();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  static String lang = "lang";

  Future<void> setLanguage(String data) async {
    final SharedPreferences prefs = await _prefs;
    await prefs.setString(lang, data);
  }

  Future<String> loadLanguage() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getString(lang) ?? "uz";
  }
}
