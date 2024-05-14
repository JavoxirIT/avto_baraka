import 'package:avto_baraka/api/models/car_body_models.dart';
import 'package:avto_baraka/api/models/car_brand.models.dart';
import 'package:avto_baraka/api/models/car_category_models.dart';
import 'package:avto_baraka/api/models/car_fuels_models.dart';
import 'package:avto_baraka/api/models/car_models.dart';
import 'package:avto_baraka/api/models/car_transmission_models.dart';
import 'package:avto_baraka/http/config.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CarService {
  final _dio = Config.dio;
  final _url = Config.dbMobile;
  String key = 'access_token';
  List<CarCategoryModels> categoryList = [];
  List<CarBrandsModels> categoryBrandList = [];
  List<CarModels> carModelList = [];
  List<CarBodyModels> carBodyList = [];
  List<CarTransmissionModels> carTransmissonList = [];
  List<CarFuelsModels> carFuelsList = [];

  Future<String> getLocolToken() async {
    final prefs = await SharedPreferences.getInstance();
    final saveData = prefs.getString(key) ?? '';

    if (saveData.isEmpty) {
      debugPrint('Токен не найден');
      return "";
    } else {
      debugPrint('CarCategoryService ${saveData}');
      return saveData;
    }
  }

  Future<List<CarCategoryModels>> carCategoryLoad() async {
    categoryList.clear();
    try {
      final response = await _dio.get(
        '${_url}ltypes',
        options: Options(
          headers: {
            'Authorization': await getLocolToken(),
          },
        ),
      );
      if (response.statusCode == 200) {
        for (var element in response.data) {
          categoryList.add(CarCategoryModels.fromMap(element));
        }
      } else {
        debugPrint('Ошибка при получение данных: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Ошибка при загрузке категорий автомобилей: $e');
    }
    return categoryList;
  }

  // card brands

  Future<List<CarBrandsModels>> getBrands(int id) async {
    categoryBrandList.clear();
    try {
      final response = await _dio.post(
        '${_url}brand/$id',
        options: Options(
          headers: {
            'Authorization': await getLocolToken(),
          },
        ),
      );
      if (response.statusCode == 200) {
        for (var element in response.data) {
          categoryBrandList.add(CarBrandsModels.fromMap(element));
        }
      } else {
        debugPrint(
            'Ошибка при получение бранда автомашин: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Ошибка при получение бранда автомашин: $e');
    }

    return categoryBrandList;
  }

  Future getCarModel(int carTypeId, int id) async {
    carModelList.clear();
    try {
      final response = await _dio.post(
        '${_url}model/$carTypeId/$id',
        options: Options(
          headers: {
            'Authorization': await getLocolToken(),
          },
        ),
      );

      if (response.statusCode == 200) {
        debugPrint('response Model: ${response.data}');
        for (var element in response.data) {
          carModelList.add(CarModels.fromMap(element));
        }
      } else {
        debugPrint(
            'Ошибка при получение моделе определенного бренда: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Ошибка при получение моделе определенного бренда: $e');
    }

    return carModelList;
  }

  Future<List<CarBodyModels>> getCarBody() async {
    carBodyList.clear();
    try {
      final response = await _dio.post(
        '${_url}car-body',
        options: Options(
          headers: {
            'Authorization': await getLocolToken(),
          },
        ),
      );
      if (response.statusCode == 200) {
        for (var element in response.data) {
          carBodyList.add(CarBodyModels.fromMap(element));
        }
      } else {
        debugPrint(
          'Ошибка при получение данных кузова: ${response.statusCode}',
        );
      }
    } catch (e) {
      debugPrint('Какая-то ошибка: $e');
    }
    return carBodyList;
  }

  Future<List<CarTransmissionModels>> getCarTransmision() async {
    carTransmissonList.clear();
    try {
      final response = await _dio.post(
        '${_url}transmission',
        options: Options(
          headers: {
            'Authorization': await getLocolToken(),
          },
        ),
      );
      if (response.statusCode == 200) {
        for (var element in response.data) {
          carTransmissonList.add(CarTransmissionModels.fromMap(element));
        }
      } else {
        debugPrint(
          'Ошибка при получение данных каробки передачи: ${response.statusCode}',
        );
      }
    } catch (e) {
      debugPrint('Какая-то ошибка: $e');
    }
    return carTransmissonList;
  }

  Future<List<CarFuelsModels>> getCarTypeFuels() async {
    carFuelsList.clear();

    try {
      final response = await _dio.post(
        '${_url}fuels',
        options: Options(
          headers: {
            'Authorization': await getLocolToken(),
          },
        ),
      );
      if (response.statusCode == 200) {
        for (var element in response.data) {
          carFuelsList.add(CarFuelsModels.fromMap(element));
        }
      } else {
        debugPrint(
            'Ошибка при получения  вида топлива: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Ошибка Fuels....: $e');
    }

    return carFuelsList;
  }
}
