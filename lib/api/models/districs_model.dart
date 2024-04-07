// ignore_for_file: public_member_api_docs, sort_constructors_first
class DistrictsModel {
  DistrictsModel({
    required this.id,
    required this.nameUz,
    required this.nameRu,
    required this.nameEn,
    required this.regionId,
  });

  late int id;
  late String nameUz;
  late String nameRu;
  late String nameEn;
  late int regionId;

  DistrictsModel.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    nameUz = map['nameuz'];
    nameRu = map['nameru'];
    nameEn = map['nameen'];
    regionId = map['region_id'];
  }
}
