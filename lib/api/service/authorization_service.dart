// import 'package:avto_baraka/api/models/send_phone_models.dart';
import 'package:avto_baraka/http_config/config.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class Authorization {
  final Dio _dio = Config.dio;
  Map dataList = {};
  Future<String> postNumber(String number, String appSignature) async {
    try {
      final response = await _dio.post('${Config.dbMobile}get-code',
          data: {"phone": number, "code": appSignature});
// debugPrint('debugPrint: ${response}');

      if (response.statusCode == 200) {
        final responseData = response.data;
        final message = responseData['message'];

        // final responseModel = SendPhoneModels.fromJson(responseData);
        return message;
      } else {
        return "error";
        // throw Exception('Не удалось загрузить данные: ${response.statusCode}');
      }
    } catch (error) {
      return "error";
      // throw Exception('Не удалось загрузить данные: $error');
    }
  }

  Future<Map> sendphoneAndCode(String phone, String code) async {
    var map = {};
    try {
      if (phone.isNotEmpty && code.isNotEmpty) {
        final response = await _dio.post('${Config.dbMobile}login',
            data: {"phone": phone, "code": code});
        if (response.statusCode == 200) {
          map = response.data;
        }
      }
    } catch (error) {
      debugPrint('Error response status code:  $error');
    }
    return map;
  }
}
