class CarPaintConditionModel {
  CarPaintConditionModel({
    required this.id,
    required this.name,
  });

  late int id;
  late String name;

  CarPaintConditionModel.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
  }
}
