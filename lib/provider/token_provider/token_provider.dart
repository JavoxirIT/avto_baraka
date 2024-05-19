import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenProvider extends ChangeNotifier {
  String key = 'access_token';
  String? token;
  String get accessToken => token!;

  TokenProvider() {
    fetchTokenLocale();
  }

  set accessToken(String t) {
    token = t;
    notifyListeners();
  }

  Future<void> fetchTokenLocale() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedToken = prefs.getString(key);
      if (savedToken != null) {
        token = savedToken;
      }
    } catch (e) {
      debugPrint("Ошибка при получения токена: $e");
    } finally {
      notifyListeners();
    }
  }

  Future<void> tokenSetLocale(tokens) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(key, tokens);
      debugPrint('token zapisan');
    } catch (e) {
      debugPrint("Ошибка сохранения токена: $e");
    }
  }
}
