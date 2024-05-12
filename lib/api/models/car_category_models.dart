class CarCategoryModels {
  late int id;
  late String nameUZ;
  late String nameRu;
  late String icon;
  CarCategoryModels({
    required this.id,
    required this.nameUZ,
    required this.nameRu,
    required this.icon,
  });

  CarCategoryModels.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    nameUZ = map['nameuz'];
    nameRu = map['nameuz'];
    icon =  map['icon'];
  }

  @override
  String toString() {
    return 'CarCategoryModels(id: $id, nameUZ: $nameUZ, nameRu: $nameRu, icon: $icon)';
  }
}
