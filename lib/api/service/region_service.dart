// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:avto_baraka/api/models/region_models.dart';
import 'package:avto_baraka/api/service/local_memory.dart';
import 'package:avto_baraka/http_config/config.dart';
import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';

class RegionService {
  final dio = Config.dio;
  final List<RegionModel> regionList = [];

  Future<List<RegionModel>> getRegions() async {
    final lang = await LocalMemory.service.getLanguageCode();
    regionList.clear();
    final response = await Config.dio.post(
      '${Config.dbMobile}region/$lang',
      options: Options(
        headers: {"Authorization": await LocalMemory.service.getLocolToken()},
      ),
    );
    final data = response.data;
    // final dataRegion = data.map(
    //   (e) => RegionModel(
    //       id: e['id'],
    //       nameUz: e['nameuz'],
    //       nameRu: e['nameru'],
    //       nameEn: e["nameen"]),
    // ).toList();

    for (var element in data) {
      regionList.add(RegionModel.fromMap(element));
    }

    return regionList;
  }
}
