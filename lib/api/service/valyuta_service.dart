import 'package:avto_baraka/api/models/valyuta_model.dart';
import 'package:avto_baraka/api/service/token_service.dart';
import 'package:avto_baraka/http/config.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ValyutaService {
  static final _dio = Config.dio;
  static final _url = Config.dbMobile;

  List<ValyutaModels> valyutaList = [];

  Future<List<ValyutaModels>> getValyuta() async {
    valyutaList.clear();

    try {
      final response = await _dio.post(
        '${_url}getValyuta',
        options: Options(
          headers: {
            'Authorization': TokenService.service.token,
          },
        ),
      );

      if (response.statusCode == 200) {
        for (var element in response.data) {
          valyutaList.add(ValyutaModels.fromMap(element));
        }
      } else {
        debugPrint(
            'Ошибка при получение данных валюты: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Какая-то ошибка,  при получение данных валюты: $e');
    }
    return valyutaList;
  }
}
