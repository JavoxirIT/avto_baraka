import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenProvider extends ChangeNotifier {
  String key = 'access_token';
  String key2 = 'userId';
  String? token;
  String? userId;
  String get accessToken => token!;
  String get accessUserID => userId!;

  TokenProvider() {
    fetchTokenLocale();
  }

  set accessToken(String? t) {
    token = t;
    notifyListeners();
  }

  set accessUserID(String? id) {
    userId = id;
    notifyListeners();
  }

  Future<void> fetchTokenLocale() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedToken = prefs.getString(key);
      final savedUserId = prefs.getString(key2);
      if (savedToken != null) {
        token = savedToken;
      }
      if (savedUserId != null) {
        userId = savedUserId;
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

  Future<void> userIdSetLocale(userId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(key2, userId.toString());
      debugPrint('id zapisan');
    } catch (e) {
      debugPrint("Ошибка сохранения токена: $e");
    }
  }

  void removeTokenPreferences(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
    debugPrint('token removed');

    notifyListeners();
  }
}
