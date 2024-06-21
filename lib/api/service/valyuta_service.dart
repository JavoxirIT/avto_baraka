import 'package:avto_baraka/api/models/credit_models.dart';
import 'package:avto_baraka/api/models/valyuta_model.dart';
import 'package:avto_baraka/api/service/local_memory.dart';
import 'package:avto_baraka/http_config/config.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ValyutaService {
  static final _dio = Config.dio;
  static final _url = Config.dbMobile;

  List<CreditData> list = [];
  List<ValyutaModels> valyutaList = [];

  Future<List<ValyutaModels>> getValyuta() async {
    final lang = await LocalMemory.service.getLanguageCode();
    valyutaList.clear();
    try {
      final response = await _dio.post(
        '${_url}getValyuta/$lang',
        options: Options(
          headers: {
            'Authorization': LocalMemory.service.token,
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

  Future<List<CreditData>> getCreditData(
    String currency,
    int type,
    int bsumma,
  ) async {
    list.clear();

    final response = await _dio.get('${_url}kridet/$currency/$type/$bsumma',
        options: Options(headers: {
          "Authorization": await LocalMemory.service.getLocolToken()
        }));

    if (response.statusCode == 200) {
      for (var element in response.data) {
        list.add(CreditData.fromJson(element));
      }
    }

    return list;
  }
}
