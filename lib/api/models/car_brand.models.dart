// ignore_for_file: public_member_api_docs, sort_constructors_first
class CarBrandsModels {
  CarBrandsModels({
    required this.id,
    required this.nameUz,
    required this.nameRu,
    required this.logo,
  });
  late int id;
  late String nameUz;
  late String nameRu;
  late String logo;

  CarBrandsModels.fromMap(Map<String, dynamic> map) {
    id = map["id"];
    nameUz = map["nameuz"];
    nameRu = map["nameru"];
    logo = map["logo"];
  }
}
