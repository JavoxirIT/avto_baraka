import 'package:avto_baraka/api/models/send_phone_models.dart';
import 'package:avto_baraka/http/config.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class SendPhoneService {
  final Dio _dio = Config.dio;

  Future<SendPhoneModels> postNumber(String number) async {
    try {
      final response =
          await _dio.post('${Config.dbMobile}get-code', data: {"phone": number});
          
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
}
