// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: non_constant_identifier_names

class ListingModels {
  ListingModels({
    required this.region_id,
    required this.district_id,
    required this.car_type_id,
    required this.car_brand_id,
    required this.car_model_id,
    required this.body_type_id,
    required this.year,
    required this.engine,
    required this.transmission__id,
    required this.pulling_side_id,
    required this.mileage,
    required this.description,
    required this.type_of_fuel_id,
    required this.car_position,
    required this.lat,
    required this.long,
    required this.price,
    required this.valyuta_id,
    required this.credit,
    required this.imageFileList,
  });
  late int region_id;
  late int district_id;
  late int car_type_id;
  late int car_brand_id;
  late int car_model_id;
  late int body_type_id;
  late int year;
  late int engine;
  late int transmission__id;
  late int pulling_side_id;
  late int mileage;
  late String description;
  late int type_of_fuel_id;
  late String car_position;
  late double lat;
  late double long;
  late String price;
  late int valyuta_id;
  late int credit;
  late List<Map<String, dynamic>> imageFileList;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'region_id': region_id,
      'district_id': district_id,
      'car_type_id': car_type_id,
      'car_brand_id': car_brand_id,
      'car_model_id': car_model_id,
      'body_type_id': body_type_id,
      'year': year,
      'engine': engine,
      'transmission__id': transmission__id,
      'pulling_side_id': pulling_side_id,
      'mileage': mileage,
      'description': description,
      'type_of_fuel_id': type_of_fuel_id,
      'car_position': car_position,
      'lat': lat,
      'long': long,
      'price': price,
      'valyuta_id': valyuta_id,
      'credit': credit,
      'imageFileList': imageFileList,
    };
  }
}
