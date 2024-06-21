class RegionModel {
  RegionModel({
    required this.id,
    required this.name,
  });

  late int id;
  late String name;
  late bool check;

  RegionModel.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    check = false;
  }
}
