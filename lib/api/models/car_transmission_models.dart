class CarTransmissionModels {
  CarTransmissionModels({
    required this.id,
    required this.name,
  });

  late int id;
  late String name;

  CarTransmissionModels.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
  }
}
