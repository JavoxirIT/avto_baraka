class CarPullingSideModels {
  CarPullingSideModels({
    required this.id,
    required this.name,
  });

  late int id;
  late String name;

  CarPullingSideModels.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
  }
}
