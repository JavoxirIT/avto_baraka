class CarBodyModels {
  CarBodyModels({required this.id, required this.nameRu, required this.nameUz});
  late int id;
  late String nameUz;
  late String nameRu;

  CarBodyModels.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    nameUz = map['nameuz'];
    nameRu = map['nameru'];
  }
}
