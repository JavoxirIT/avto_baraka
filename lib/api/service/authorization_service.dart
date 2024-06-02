import 'package:avto_baraka/api/models/send_phone_models.dart';
import 'package:avto_baraka/http_config/config.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class Authorization {
  final Dio _dio = Config.dio;

  Future<SendPhoneModels> postNumber(String number) async {
    try {
      final response = await _dio
          .post('${Config.dbMobile}get-code', data: {"phone": number});

      debugPrint('${Config.dbMobile}get-code');

      if (response.statusCode == 200) {
        final responseData = response.data;
        final message = responseData['message'];
        final code = responseData['code'];
        debugPrint('Message: $message, Code: $code');
        final responseModel = SendPhoneModels.fromJson(responseData);
        return responseModel;
      } else {
        throw Exception('Не удалось загрузить данные: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Не удалось загрузить данные: $error');
    }
  }

  Future<List> sendphoneAndCode(String phone, String code) async {
    try {
      final response = await _dio.post('${Config.dbMobile}login',
          data: {"phone": phone, "code": code});
      if (response.statusCode == 200) {
        final responseData = response.data;
        final accessToken = responseData["access_token"];
        final userId = responseData["user_id"];
        return [accessToken, userId];
      } else {
        throw Exception('Ошибка ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('ERROR $error');
    }
  }
}
