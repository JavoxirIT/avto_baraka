// ignore_for_file: public_member_api_docs, sort_constructors_first
class DistrictsModel {
  DistrictsModel({
    required this.id,
    required this.name,
    required this.regionId,
  });

  late int id;
  late String name;
  late int regionId;

  DistrictsModel.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    regionId = map['region_id'];
  }
}
// "name": "Bekobod tumani",
//         "id": 113,
//         "region_id": 1