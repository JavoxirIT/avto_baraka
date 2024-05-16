class ValyutaModels {
  ValyutaModels({
    required this.id,
    required this.nameuz,
    required this.nameru,
    required this.shortitem,
    required this.kurs,
  });
  late int id;
  late String nameuz;
  late String nameru;
  late String shortitem;
  late String kurs;

  ValyutaModels.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    nameuz = map['nameuz'];
    nameru = map['nameru'];
    shortitem = map['shortitem'];
    kurs = map['kurs'];
  }
}
