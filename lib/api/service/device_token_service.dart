import 'dart:developer';

import 'package:avto_baraka/api/service/local_memory.dart';
import 'package:avto_baraka/http_config/config.dart';
import 'package:dio/dio.dart';

class DeviseTokenService {
  // ignore: non_constant_identifier_names
  static DeviseTokenService DTS = DeviseTokenService();

  Future<void> sendDeviceToken(token) async {
    final authToken = await LocalMemory.service.getLocolToken();
    try {
      if (authToken != "") {
        final response = await Config.dio.post(
          '${Config.dbMobile}tokenUser',
          options: Options(
            headers: {
              'Authorization': await LocalMemory.service.getLocolToken(),
            },
          ),
          data: {"mobile_token": token},
        );
        // log('sendDeviceToken: $response');

        if (response.statusCode == 200) {
          // log("${response.data}");
        }
      }
    } catch (e) {
      log('error sendDeviceToken:  $e');
    }
  }
}
