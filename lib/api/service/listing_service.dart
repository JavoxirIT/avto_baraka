import 'package:avto_baraka/api/models/listing_get_models.dart';
import 'package:avto_baraka/api/service/token_service.dart';
import 'package:avto_baraka/http/config.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class ListingService {
  static ListingService ls = ListingService();

  List<ListingGetModals> listingDataList = [];
  List<MultipartFile> filePaths = [];

  static final ListingService servive = ListingService();

  final _dio = Config.dio;
  final _url = Config.dbMobile;

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
      debugPrint('LISTING ERROR: $e');
    }
    return listingDataList;
  }
}
