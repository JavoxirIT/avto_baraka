// ignore_for_file: non_constant_identifier_names

import 'package:avto_baraka/api/models/listing_get_models.dart';
import 'package:avto_baraka/api/service/local_memory.dart';
import 'package:avto_baraka/http_config/config.dart';
import 'package:avto_baraka/provider/token_provider/token_provider.dart';
import 'package:avto_baraka/router/redirect_to_login.dart';
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
  List<ListingGetModals> listingNotActivList = [];
  List<ListingGetModals> listingLikeList = [];
  List<MultipartFile> filePaths = [];
  String? likedStatus;
  String statusText = "";
  String activitesStatusText = "";

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
            'Authorization': LocalMemory.service.token,
          },
        ),
        data: formData,
      );
      debugPrint('POST listing: $response');
      if (response.statusCode == 200) {
        debugPrint('pesponse listing: $response');

        statusText = response.data['status'];
      } else {
        debugPrint('response bad request: ${response.statusMessage}');
        if (response.statusCode == 422) {
          statusText = "Unprocessable";
        }
      }
    } catch (e) {
      debugPrint('Ошибка при отправки данных: ${e.toString()}');
      if (e is DioException) {
        if (e.response?.statusCode == 422) {
          statusText = "Unprocessable";
          debugPrint('422: ${e.response?.data}');
        }
        if (e.response?.statusCode == 500) {
          debugPrint('500: ${e.response?.data}');
          statusText = "serverError";
        }
      }
    }
    return statusText;
  }

  // GET LISTING
  Future<List<ListingGetModals>> getDataListing(int page) async {
    var lang = await LocalMemory.service.getLanguageCode();

    // debugPrint('Page: $page');

    listingDataList.clear();
    try {
      final response = await _dio.post(
        '${_url}get-listing/$lang/?page=$page',
        options: Options(
          headers: {'Authorization': await LocalMemory.service.getLocolToken()},
        ),
      );
      if (response.statusCode == 200) {
        for (var element in response.data['data']) {
          // debugPrint('response.data: ${response.data['data']}');

          listingDataList.add(ListingGetModals.fromMap(element));
        }
      } else {
        debugPrint('LISTING ERROR: ${response.statusCode}');
        if (response.statusCode == 401) {
          TokenProvider().removeTokenPreferences(tokenKey);
          redirectToLogin();
        }
      }
    } catch (e) {
      if (e is DioException) {
        if (e.response?.statusCode == 401) {
          TokenProvider().removeTokenPreferences(tokenKey);
          redirectToLogin();
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
      debugPrint('CATCH LISTING ACTIVE ERROR : $e');
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
        '${_url}get-block/$lang',
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
      debugPrint('CATCH LISTING BLOCKED ERROR : $e');
      if (e is DioException) {
        if (e.response!.statusCode == 401) {
          TokenProvider().removeTokenPreferences(tokenKey);
        }
      }
    }
    return listingBlockedDataList;
  }

  // GET DEACTIVE LISTING
  Future<List<ListingGetModals>> getNotActiveListing(lang, token) async {
    listingNotActivList.clear();
    try {
      final response = await _dio.post(
        '${_url}get-deactive/$lang',
        options: Options(
          headers: {'Authorization': token},
        ),
      );
      if (response.statusCode == 200) {
        for (var element in response.data) {
          listingNotActivList.add(ListingGetModals.fromMap(element));
        }
      } else {
        debugPrint('LISTING NOT ACTIVE ERROR: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('CATCH LISTING NOT ACTIVE ERROR : $e');
      if (e is DioException) {
        if (e.response!.statusCode == 401) {
          TokenProvider().removeTokenPreferences(tokenKey);
        }
      }
    }
    return listingNotActivList;
  }

  // POST ACTIVATING
  Future<String> postActivating(int id, String token) async {
    try {
      final response = await _dio.post(
        '${_url}activating/$id',
        options: Options(headers: {"Authorization": token}),
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> map = response.data as Map<String, dynamic>;
        // debugPrint('RESPONSE: $map');
        activitesStatusText = map['status'];
      }
    } catch (e) {
      debugPrint('activating error: $e');
    }
    return activitesStatusText;
  }

  // SEARCH
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
      "brand_id": '${brand_id == -1 ? "" : brand_id}',
      "car_type": '${car_type ?? ""}',
      "end_price": '${end_price ?? ""}',
      "end_year": '${end_year ?? ""}',
      "model_id": '${model_id ?? ""}',
      "region_id": '${region_id ?? ""}',
      "start_price": '${start_price ?? ""}',
      "start_year": '${start_year ?? ""}',
      "valyuta": '${valyuta ?? ""}'
    };
    debugPrint('debugPrint: $data');

    try {
      final response = await _dio.post(
        '${_url}get-listing/$lang',
        options: Options(
          headers: {'Authorization': token},
        ),
        data: data,
      );
      if (response.statusCode == 200) {
        for (var element in response.data['data']) {
          listingDataList.add(ListingGetModals.fromMap(element));
        }
      } else {
        debugPrint('ОШИБКА ПРИ ПОИСКЕ : ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('CATCH ERROR SEARCH : $e');
      if (e is DioException) {
        if (e.response!.statusCode == 401) {
          TokenProvider().removeTokenPreferences(tokenKey);
        }
      }
    }
    return listingDataList;
  }

  // LIKED
  Future<String> onLiked(String token, int listing_id) async {
    try {
      final response = await _dio.post(
        '${_url}liked',
        options: Options(headers: {'Authorization': token}),
        data: {"listing_id": listing_id},
      );
      if (response.statusCode == 200) {
        // debugPrint('LIKED Response: ${response.data}');
        likedStatus = response.data;
      } else {
        debugPrint('LIKED ERORR Response: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('LIKED ERORR: $e');
      if (e is DioException) {
        if (e.response!.statusCode == 401) {
          TokenProvider().removeTokenPreferences(tokenKey);
        }
      }
    }
    return likedStatus!;
  }

  // GET LIKED
  Future<List<ListingGetModals>> getLikeList(String lang, String token) async {
    // debugPrint('RESPONSE DATA');
    try {
      listingLikeList.clear();
      final response = await _dio.get(
        '${_url}favourites/$lang',
        options: Options(
          headers: {'Authorization': token},
        ),
      );

      if (response.statusCode == 200) {
        for (var element in response.data) {
          listingLikeList.add(ListingGetModals.fromMap(element));
        }
      } else {
        debugPrint('Ошибка при получение LIKE LIST: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('ERROR LIKE LIST: $e');
      if (e is DioException) {
        if (e.response!.statusCode == 401) {
          TokenProvider().removeTokenPreferences(tokenKey);
        }
      }
    }

    return listingLikeList;
  }

  // DELETE LISTING
  Future<int> deleteListing(int listingId, String token) async {
    int responseData = 0;
    try {
      final response = await _dio.get('${_url}deletelisting/$listingId',
          options: Options(headers: {'Authorization': token}));

      if (response.statusCode == 200) {
        responseData = int.parse(response.data);
      }
    } catch (e) {
      debugPrint('ERROR LIKE LIST: $e');
      if (e is DioException) {
        if (e.response!.statusCode == 401) {
          TokenProvider().removeTokenPreferences(tokenKey);
        }
      }
    }
    return responseData;
  }

  //COMPLAINT
  Future complaint(String desc, int listingId) async {
    final response = await _dio.post(
      '${_url}report',
      options: Options(
        headers: {
          'Authorization': await LocalMemory.service.getLocolToken(),
        },
      ),
      data: {"listing_id": listingId, "description": desc},
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> data = response.data as Map<String, dynamic>;
      return data;
    }
  }

  // VIEWED
  Future<void> viewed(
    int listingId,
  ) async {
    _dio.post(
      '${_url}viewed/$listingId',
      options: Options(
        headers: {"Authorization": await LocalMemory.service.getLocolToken()},
      ),
    );
  }

  Future<int> changePrice(int id, value) async {
    int resault = 0;
    final response = await _dio.post('${_url}change-price/$id',
        options: Options(
          headers: {"Authorization": await LocalMemory.service.getLocolToken()},
        ),
        data: {"price": value});

    if (response.statusCode == 200) {
      resault = int.parse(response.data);
    }

    return resault;
  }
}
