class ValyutaModels {
  ValyutaModels({
    required this.id,
    required this.name,
    required this.shortitem,
    required this.kurs,
  });
  late int id;
  late String name;
  late String shortitem;
  late String kurs;

  ValyutaModels.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    shortitem = map['shortitem'];
    kurs = map['kurs'];
  }
}
