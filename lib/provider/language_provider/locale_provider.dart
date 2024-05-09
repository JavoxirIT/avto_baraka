import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalProvider extends ChangeNotifier {
  Locale _local = const Locale("uz");
  Locale get locale => _local;

  LocalProvider() {
    fetchLocale();
  }

  set locale(Locale locale) {
    _local = locale;
    notifyListeners();
  }

  Future<void> fetchLocale() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedLangCode = prefs.getString('lang');
      if (savedLangCode != null) {
        _local = Locale.fromSubtags(languageCode: savedLangCode);
      }
    } catch (e) {
      debugPrint("Ошибка при выборе локали: $e");
    } finally {
      notifyListeners();
    }
  }

  Future<void> persistLocale(languageCode) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('lang', languageCode);
    } catch (e) {
      debugPrint("Ошибка сохранения локали: $e");
    }
  }
}



// WidgetsBinding.instance?.addPostFrameCallback((_) => runApp(MyApp()));