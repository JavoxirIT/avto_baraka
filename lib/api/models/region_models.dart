class RegionModel {
  RegionModel({
    required this.id,
    required this.nameUz,
    required this.nameRu,
    required this.nameEn,
  });

  late int id;
  late String nameUz;
  late String nameRu;
  late String nameEn;
  late bool check;

  RegionModel.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    nameUz = map['nameuz'];
    nameRu = map['nameru'];
    nameEn = map['nameen'];
    check = false;
  }
}
