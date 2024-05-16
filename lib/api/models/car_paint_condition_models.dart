class CarPaintConditionModel {
  CarPaintConditionModel({
    required this.id,
    required this.nameUZ,
    required this.nameRu,
  });

  late int id;
  late String nameUZ;
  late String nameRu;

  CarPaintConditionModel.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    nameUZ = map['nameuz'];
    nameRu = map['nameru'];
  }
}
