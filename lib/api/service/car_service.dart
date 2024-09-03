import 'package:avto_baraka/api/models/car_body_models.dart';
import 'package:avto_baraka/api/models/car_brand.models.dart';
import 'package:avto_baraka/api/models/car_category_models.dart';
import 'package:avto_baraka/api/models/car_fuels_models.dart';
import 'package:avto_baraka/api/models/car_models.dart';
import 'package:avto_baraka/api/models/car_paint_condition_models.dart';
import 'package:avto_baraka/api/models/car_pulling_side_models.dart';
import 'package:avto_baraka/api/models/car_transmission_models.dart';
import 'package:avto_baraka/api/service/local_memory.dart';
import 'package:avto_baraka/http_config/config.dart';
import 'package:avto_baraka/provider/token_provider/token_provider.dart';
import 'package:avto_baraka/router/redirect_to_login.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class CarService {
  final _dio = Config.dio;
  final _url = Config.dbMobile;
  List<CarCategoryModels> categoryList = [];
  List<CarBrandsModels> categoryBrandList = [];
  List<CarModels> carModelList = [];
  List<CarBodyModels> carBodyList = [];
  List<CarTransmissionModels> carTransmissonList = [];
  List<CarFuelsModels> carFuelsList = [];
  List<CarPullingSideModels> carPullingSideList = [];
  List<CarPaintConditionModel> carPaintConditionList = [];

  final String tokenKey = 'access_token';

  Future<List<CarCategoryModels>> carCategoryLoad() async {
    var lang = await LocalMemory.service.getLanguageCode();
    
    categoryList.clear();
    try {
      final response = await _dio.get(
        '${_url}ltypes/$lang',
        options: Options(
          headers: {
            'Authorization': await LocalMemory.service.getLocolToken(),
          },
        ),
      );
      if (response.statusCode == 200) {
        for (var element in response.data) {
          categoryList.add(CarCategoryModels.fromMap(element));
        }
        // debugPrint('categoryList: ${categoryList.toString()}');
      } else {
        debugPrint('Ошибка при получение данных: ${response.statusCode}');
        if (response.statusCode == 401) {
          TokenProvider().removeTokenPreferences(tokenKey);
          redirectToLogin();
        }
      }
    } catch (e) {
      debugPrint('Ошибка при загрузке категорий автомобилей: $e');
      if (e is DioException) {
        if (e.response!.statusCode == 401) {
          TokenProvider().removeTokenPreferences(tokenKey);
          redirectToLogin();
        }
      }
    }
    return categoryList;
  }

  Future<List<CarBrandsModels>> getBrands(int id) async {
    debugPrint('getBrands: $id');

    var lang = await LocalMemory.service.getLanguageCode();
    categoryBrandList.clear();
    try {
      final response = await _dio.post(
        '${_url}brand/$id/$lang',
        options: Options(
          headers: {
            'Authorization': await LocalMemory.service.getLocolToken(),
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
        if (response.statusCode == 401) {
          TokenProvider().removeTokenPreferences(tokenKey);
        }
      }
    } catch (e) {
      debugPrint('Ошибка при получение бранда автомашин: $e');
      if (e is DioException) {
        if (e.response!.statusCode == 401) {
          TokenProvider().removeTokenPreferences(tokenKey);
        }
      }
    }

    return categoryBrandList;
  }

  Future<List<CarModels>> getCarModel(int carTypeId, int id) async {
    final lang = await LocalMemory.service.getLanguageCode();
    carModelList.clear();
    try {
      final response = await _dio.post(
        '${_url}model/$carTypeId/$id/$lang',
        options: Options(
          headers: {
            'Authorization': await LocalMemory.service.getLocolToken(),
          },
        ),
      );

      if (response.statusCode == 200) {
        for (var element in response.data) {
          carModelList.add(CarModels.fromMap(element));
        }
      } else {
        debugPrint(
            'Ошибка при получение моделе определенного бренда: ${response.statusCode}');
        if (response.statusCode == 401) {
          TokenProvider().removeTokenPreferences(tokenKey);
        }
      }
    } catch (e) {
      debugPrint('Ошибка при получение моделе определенного бренда: $e');
      if (e is DioException) {
        if (e.response!.statusCode == 401) {
          TokenProvider().removeTokenPreferences(tokenKey);
        }
      }
    }

    return carModelList;
  }

  Future<List<CarBodyModels>> getCarBody() async {
    final lang = await LocalMemory.service.getLanguageCode();
    carBodyList.clear();
    try {
      final response = await _dio.post(
        '${_url}car-body/$lang',
        options: Options(
          headers: {
            'Authorization': await LocalMemory.service.getLocolToken(),
          },
        ),
      );
      if (response.statusCode == 200) {
        for (var element in response.data) {
          carBodyList.add(CarBodyModels.fromMap(element));
        }
      } else {
        debugPrint(
            'Ошибка при получение данных кузова: ${response.statusCode}');
        if (response.statusCode == 401) {
          TokenProvider().removeTokenPreferences(tokenKey);
        }
      }
    } catch (e) {
      debugPrint('Какая-то ошибка: $e');
      if (e is DioException) {
        if (e.response!.statusCode == 401) {
          TokenProvider().removeTokenPreferences(tokenKey);
        }
      }
    }
    return carBodyList;
  }

  Future<List<CarTransmissionModels>> getCarTransmision() async {
    final lang = await LocalMemory.service.getLanguageCode();
    carTransmissonList.clear();
    try {
      final response = await _dio.post(
        '${_url}transmission/$lang',
        options: Options(
          headers: {
            'Authorization': await LocalMemory.service.getLocolToken(),
          },
        ),
      );
      if (response.statusCode == 200) {
        for (var element in response.data) {
          carTransmissonList.add(CarTransmissionModels.fromMap(element));
        }
      } else {
        debugPrint(
            'Ошибка при получение данных каробки передачи: ${response.statusCode}');
        if (response.statusCode == 401) {
          TokenProvider().removeTokenPreferences(tokenKey);
        }
      }
    } catch (e) {
      debugPrint('Какая-то ошибка: $e');
      if (e is DioException) {
        if (e.response!.statusCode == 401) {
          TokenProvider().removeTokenPreferences(tokenKey);
        }
      }
    }
    return carTransmissonList;
  }

  Future<List<CarFuelsModels>> getCarTypeFuels() async {
    final lang = await LocalMemory.service.getLanguageCode();
    carFuelsList.clear();
    try {
      final response = await _dio.post(
        '${_url}fuels/$lang',
        options: Options(
          headers: {
            'Authorization': await LocalMemory.service.getLocolToken(),
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
        if (response.statusCode == 401) {
          TokenProvider().removeTokenPreferences(tokenKey);
        }
      }
    } catch (e) {
      debugPrint('Ошибка Fuels....: $e');
      if (e is DioException) {
        if (e.response!.statusCode == 401) {
          TokenProvider().removeTokenPreferences(tokenKey);
        }
      }
    }

    return carFuelsList;
  }

  Future<List<CarPullingSideModels>> getCarPullingSide() async {
    final lang = await LocalMemory.service.getLanguageCode();
    carPullingSideList.clear();
    try {
      final response = await _dio.post(
        '${_url}pulling/$lang',
        options: Options(
          headers: {
            'Authorization': await LocalMemory.service.getLocolToken(),
          },
        ),
      );
      if (response.statusCode == 200) {
        for (var element in response.data) {
          carPullingSideList.add(CarPullingSideModels.fromMap(element));
        }
      } else {
        debugPrint(
            'Ошибка при получение состояние окраски: ${response.statusCode}');
        if (response.statusCode == 401) {
          TokenProvider().removeTokenPreferences(tokenKey);
        }
      }
    } catch (e) {
      debugPrint('Не предвиденная ошибка: $e');
      if (e is DioException) {
        if (e.response!.statusCode == 401) {
          TokenProvider().removeTokenPreferences(tokenKey);
        }
      }
    }
    return carPullingSideList;
  }

  Future<List<CarPaintConditionModel>> getCarPointCondition() async {
    final lang = await LocalMemory.service.getLanguageCode();
    carPaintConditionList.clear();
    try {
      final response = await _dio.post(
        '${_url}paint-condition/$lang',
        options: Options(
          headers: {
            'Authorization': await LocalMemory.service.getLocolToken(),
          },
        ),
      );
      if (response.statusCode == 200) {
        for (var element in response.data) {
          carPaintConditionList.add(CarPaintConditionModel.fromMap(element));
        }
      } else {
        debugPrint(
            'Ошибка при получение состояние окраски: ${response.statusCode}');
        if (response.statusCode == 401) {
          TokenProvider().removeTokenPreferences(tokenKey);
        }
      }
    } catch (e) {
      debugPrint('Что-то не так, ошибка при получение состояния окраски: $e');
      if (e is DioException) {
        if (e.response!.statusCode == 401) {
          TokenProvider().removeTokenPreferences(tokenKey);
        }
      }
    }
    return carPaintConditionList;
  }
}
