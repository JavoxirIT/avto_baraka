// ignore_for_file: non_constant_identifier_names

import 'package:avto_baraka/api/models/listing_get_models.dart';
import 'package:avto_baraka/api/service/token_service.dart';
import 'package:avto_baraka/http/config.dart';
import 'package:avto_baraka/provider/token_provider/token_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListingService {
  static final ListingService servive = ListingService();
  final _dio = Config.dio;
  final _url = Config.dbMobile;
  final String tokenKey = 'access_token';

  List<ListingGetModals> listingDataList = [];
  List<ListingGetModals> listingActiveDataList = [];
  List<ListingGetModals> listingBlockedDataList = [];
  List<MultipartFile> filePaths = [];
  String statusText = "";

  Future<String> postAutoData(Map<String, dynamic> listing, imageFile) async {
    filePaths.clear();
    try {
      FormData formData = FormData();

      // Добавляем изображения в FormData
      for (int i = 0; i < imageFile.length; i++) {
        String imageName = 'image_$i.jpg';
        formData.files.add(MapEntry(
          "imageFileList[]",
          await MultipartFile.fromFile(
            imageFile[i].path,
            filename: imageName,
          ),
        ));
      }

      // Преобразуем значения в listing к строковому типу
      Map<String, String> stringListing = Map.fromEntries(
          listing.entries.map((e) => MapEntry(e.key, e.value.toString())));

      // Добавляем данные JSON в FormData
      formData.fields.addAll(stringListing.entries);

      final response = await _dio.post(
        '${_url}add-listing',
        options: Options(
          headers: {
            'Authorization': TokenService.service.token,
          },
        ),
        data: formData,
      );
      if (response.statusCode == 200) {
        statusText = response.data['status'];
      } else {
        debugPrint('rsponse daq request: ${response.statusMessage}');
      }
    } catch (e) {
      debugPrint('Ошибка при отправки данных: ${e.toString()}');
    }
    return statusText;
  }

  // GET LISTING
  Future<List<ListingGetModals>> getDataListing(lang, token) async {
    listingDataList.clear();
    try {
      final response = await _dio.post(
        '${_url}get-listing/$lang',
        options: Options(
          headers: {'Authorization': token},
        ),
      );
      if (response.statusCode == 200) {
        for (var element in response.data) {
          listingDataList.add(ListingGetModals.fromMap(element));
        }
      } else {
        debugPrint('LISTING ERROR: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('LISTING ERROR : ${e}');
      if (e is DioException) {
        if (e.response!.statusCode == 401) {
          debugPrint('debugPrint: ${401}');
          TokenProvider().removeTokenPreferences(tokenKey);
        }
      }
    }

    return listingDataList;
  }

  // GET ACTIVE LISTING
  Future<List<ListingGetModals>> getActiveDataListing(lang, token) async {
    listingActiveDataList.clear();
    try {
      final response = await _dio.post(
        '${_url}get-active/$lang',
        options: Options(
          headers: {'Authorization': token},
        ),
      );
      if (response.statusCode == 200) {
        for (var element in response.data) {
          listingActiveDataList.add(ListingGetModals.fromMap(element));
        }
      } else {
        debugPrint('LISTING ACTIVE ERROR: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('CATCH LISTING ACTIVE ERROR : ${e}');
      if (e is DioException) {
        if (e.response!.statusCode == 401) {
          TokenProvider().removeTokenPreferences(tokenKey);
        }
      }
    }
    return listingActiveDataList;
  }

  // GET BLOCKED LISTING
  Future<List<ListingGetModals>> getBlockedDataListing(lang, token) async {
    listingBlockedDataList.clear();
    try {
      final response = await _dio.post(
        '${_url}get-deactive/$lang',
        options: Options(
          headers: {'Authorization': token},
        ),
      );
      if (response.statusCode == 200) {
        for (var element in response.data) {
          listingBlockedDataList.add(ListingGetModals.fromMap(element));
        }
      } else {
        debugPrint('LISTING BLOCKED ERROR: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('CATCH LISTING BLOCKED ERROR : ${e}');
      if (e is DioException) {
        if (e.response!.statusCode == 401) {
          TokenProvider().removeTokenPreferences(tokenKey);
        }
      }
    }
    return listingBlockedDataList;
  }

  Future<List<ListingGetModals>> getSearchListing(
    lang,
    token, [
    int? brand_id,
    int? car_type,
    int? end_price,
    int? end_year,
    int? model_id,
    int? region_id,
    int? start_price,
    int? start_year,
    int? valyuta,
  ]) async {
    listingDataList.clear();
    var data = {
      "brand_id": '${brand_id ?? ""}',
      "car_type": '${car_type ?? ""}',
      "end_price": '${end_price ?? ""}',
      "end_year": '${end_year ?? ""}',
      "model_id": '${model_id ?? ""}',
      "region_id": '${region_id ?? ""}',
      "start_price": '${start_price ?? ""}',
      "start_year": '${start_year ?? ""}',
      "valyuta": '${valyuta ?? ""}'
    };

    try {
      final response = await _dio.post(
        '${_url}get-listing/$lang',
        options: Options(
          headers: {'Authorization': token},
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        for (var element in response.data) {
          listingDataList.add(ListingGetModals.fromMap(element));
        }
      } else {
        debugPrint('ОШИБКА ПРИ ПОИСКЕ : ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('CATCH ERROR SEARCH : ${e}');
      if (e is DioException) {
        if (e.response!.statusCode == 401) {
          TokenProvider().removeTokenPreferences(tokenKey);
        }
      }
    }
    return listingDataList;
  }
}
