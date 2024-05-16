class CarPullingSideModels {
  CarPullingSideModels({
    required this.id,
    required this.nameRu,
    required this.nameUZ,
  });

  late int id;
  late String nameUZ;
  late String nameRu;

  CarPullingSideModels.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    nameUZ = map['nameuz'];
    nameRu = map['nameru'];
  }
}
