import 'package:avto_baraka/api/service/local_memory.dart';
import 'package:avto_baraka/screen/imports/imports_announcement.dart';
import 'package:dio/dio.dart';

class DistrictsService {
  final List<DistrictsModel> list = [];

  Future<List<DistrictsModel>> getDistricts(int id) async {
    debugPrint('widget.regionGroupValue: $id');
    final lang = await LocalMemory.service.getLanguageCode();
    list.clear();
    final response = await Config.dio.post(
      '${Config.dbMobile}district/$id/$lang',
      options: Options(
        headers: {"Authorization": await LocalMemory.service.getLocolToken()},
      ),
    );
    final data = response.data;
    for (var elements in data) {
      list.add(DistrictsModel.fromMap(elements));
    }

    return list;
  }
}
