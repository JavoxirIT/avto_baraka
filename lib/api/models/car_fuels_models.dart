class CarFuelsModels {
  CarFuelsModels({
    required this.id,
    required this.name,
  });

  late int id;
  late String name;

  CarFuelsModels.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
  }
}
