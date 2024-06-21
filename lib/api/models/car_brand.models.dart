// ignore_for_file: public_member_api_docs, sort_constructors_first
class CarBrandsModels {
  CarBrandsModels({
    required this.id,
    required this.name,
    required this.logo,
  });
  late int id;
  late String name;
  late String logo;

  CarBrandsModels.fromMap(Map<String, dynamic> map) {
    id = map["id"];
    name = map["name"];
    logo = map["logo"];
  }
}
