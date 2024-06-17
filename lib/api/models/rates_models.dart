class RatesModels {
  RatesModels({
    required this.id,
    required this.name,
    required this.price,
    required this.topDays,
    this.upto,
    required this.vipDays,
  });

  late int id;
  late String name;
  late int price;
  late int topDays;
  late int? upto;
  late int vipDays;

  RatesModels.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    price = map['price'];
    topDays = map['topdays'];
    upto = map['upto'];
    vipDays = map['vipdays'];
  }

  @override
  String toString() {
    return 'TarifModels(id: $id, name: $name, price: $price, topDays: $topDays, upto: $upto, vipDays: $vipDays)';
  }
}
