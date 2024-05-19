class CarFuelsModels {
  CarFuelsModels({
    required this.id,
    required this.nameUz,
    required this.nameRu,
  });

  late int id;
  late String nameUz;
  late String nameRu;

  CarFuelsModels.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    nameUz = map['nameuz'];
    nameRu = map['nameru'];
  }
}
