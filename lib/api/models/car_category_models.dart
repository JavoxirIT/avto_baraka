class CarCategoryModels {
  late int id;
  late String name;
  late String icon;
  CarCategoryModels({
    required this.id,
    required this.name,
    required this.icon,
  });

  CarCategoryModels.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    icon = map['icon'];
  }

  @override
  String toString() {
    return 'CarCategoryModels(id: $id, name: $name, icon: $icon)';
  }
}
