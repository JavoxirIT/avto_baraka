import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenService {
  static final TokenService service = TokenService();
  String key = 'access_token';

  String token = "";

  Future<void> getLocolToken() async {
    final prefs = await SharedPreferences.getInstance();
    final saveData = prefs.getString(key) ?? '';

    if (saveData.isEmpty) {
      debugPrint('Токен не найден');
    } else {
    debugPrint('$saveData');
      token = saveData;
    }
  }
}
