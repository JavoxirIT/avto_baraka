// ignore_for_file: public_member_api_docs, sort_constructors_first
class CarModels {
  CarModels({
    required this.id,
    required this.name,
    required this.img,
    required this.listingTypeId,
    required this.brandId,
  });

  late int id;
  late String name;
  late String img;
  late int listingTypeId;
  late int brandId;

  CarModels.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    img = map['img'];
    listingTypeId = map['lt_id'];
    brandId = map['brand_id'];
  }
}
