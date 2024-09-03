import 'package:avto_baraka/api/service/local_memory.dart';
import 'package:avto_baraka/http_config/config.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class UserService {
  static final UserService userService = UserService();
  final _dio = Config.dio;
  final _url = Config.dbMobile;

  Future<void> deleteAccount() async {
    final response = await _dio.post(
      '${_url}deleteUser',
      options: Options(headers: {
        'Authorization': await LocalMemory.service.getLocolToken(),
      }),
    );

    if (response.statusCode == 200) {
      debugPrint('debugPrint: ${response.data}');
    }
  }
}
