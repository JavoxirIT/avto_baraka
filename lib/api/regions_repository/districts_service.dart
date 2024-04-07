import 'package:avto_baraka/api/models/districs_model.dart';
import 'package:avto_baraka/http/config.dart';

class DistrictsService {
  final List<DistrictsModel> list = [];
 

  Future<List<DistrictsModel>> getDistricts() async {
    list.clear();
    final response = await Config.dio.get('${Config.dbUrl}districts');
    final data = response.data;
    for (var elements in data) {
      list.add(DistrictsModel.fromMap(elements));
    }

    return list;
  }
}
