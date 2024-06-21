class CarBodyModels {
  CarBodyModels({
    required this.id,
    required this.name,
  });
  late int id;
  late String name;

  CarBodyModels.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
  }
}
