// ignore_for_file: public_member_api_docs, sort_constructors_first
class CarModels {
  CarModels({
    required this.id,
    required this.nameUz,
    required this.nameRu,
    required this.img,
    required this.listingTypeId,
    required this.brandId,
  });

  late int id;
  late String nameUz;
  late String nameRu;
  late String img;
  late int listingTypeId;
  late int brandId;

  CarModels.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    nameRu = map['nameru'];
    nameUz = map['nameuz'];
    img = map['img'];
    listingTypeId = map['lt_id'];
    brandId = map['brand_id'];
  }
}
