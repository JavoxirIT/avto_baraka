import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalMemory {
  static final LocalMemory service = LocalMemory();
  String key = 'access_token';

  String token = "";
  String userId = "";
  String languageCode = "";

  Future<String> getLocolToken() async {
    final prefs = await SharedPreferences.getInstance();
    final saveData = prefs.getString(key) ?? '';

    if (saveData.isEmpty) {
      debugPrint('Токен не найден');
    } else {
       debugPrint('TokenService saveData: $saveData');
      token = saveData;
    }
    return saveData;
  }

  Future<String> getLocolUserId() async {
    final prefs = await SharedPreferences.getInstance();
    final saveuSerId = prefs.getString("userId") ?? '';

    if (saveuSerId.isEmpty) {
      debugPrint('ID не найден');
    } else {
      // debugPrint('TokenService saveuSerId: $saveuSerId');
      userId = saveuSerId;
    }
    return userId;
  }

  Future<String> getLanguageCode() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedLangCode = prefs.getString('lang') ?? "uz";
      if (savedLangCode.isEmpty) {
        debugPrint('TokenService ERROR');
      } else {
        // debugPrint('TokenService savedLangCode: $savedLangCode');
        languageCode = savedLangCode;
      }
    } catch (e) {
      debugPrint("Ошибка при выборе локали: $e");
    }

    return languageCode;
  }
}
