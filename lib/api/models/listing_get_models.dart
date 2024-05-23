// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'dart:convert';

class ListingGetModals {
  ListingGetModals({
    required this.id,
    required this.activeStatus,
    required this.brand,
    required this.carImage,
    required this.car_body,
    required this.car_position,
    required this.car_type,
    required this.credit,
    required this.description,
    required this.discount,
    required this.district,
    required this.engine,
    required this.expire_date,
    required this.lat,
    required this.long,
    required this.mileage,
    required this.model,
    required this.posted_date,
    required this.price,
    required this.pulling_side,
    required this.region,
    required this.transmission,
    required this.type_of_fuel,
    required this.valyuta_kurs,
    required this.valyuta_name,
    required this.valyuta_short,
    required this.viewed,
    required this.year,
    required this.phone,
    required this.liked,
    // required this.paint_condition,
  });

  late List<String> carImage;
  late num engine;
  late int? liked;
  late int discount;
  late int id;
  late int activeStatus;
  late int viewed;
  late int year;
  late int price;
  late int posted_date;
  late int mileage;
  late int expire_date;
  late int credit;
  // late String paint_condition;
  late String car_position;
  late String car_body;
  late String car_type;
  late String description;
  late String district;
  late String lat;
  late String long;
  late String model;
  late String brand;
  late String pulling_side;
  late String region;
  late String transmission;
  late String type_of_fuel;
  late String valyuta_kurs;
  late String valyuta_name;
  late String valyuta_short;
  late String phone;

  ListingGetModals.fromMap(Map<String, dynamic> map) {
    carImage = jsonDecode(map['carImage']).cast<String>();
    engine = map['engine'];
    discount = map['discount'];
    id = map['id'];
    activeStatus = map['activeStatus'];
    viewed = map['viewed'];
    year = map['year'];
    price = map['price'];
    posted_date = map['posted_date'];
    mileage = map['mileage'];
    expire_date = map['expire_date'];
    credit = map['credit'];
    car_position = map['car_position'];
    car_body = map['car_body'];
    car_type = map['car_type'];
    description = map['description'];
    district = map['district'];
    lat = map['lat'];
    long = map['long'];
    model = map['model'];
    brand = map['brand'];
    pulling_side = map['pulling_side'];
    region = map['region'];
    transmission = map['transmission'];
    type_of_fuel = map['type_of_fuel'];
    valyuta_kurs = map['valyuta_kurs'];
    valyuta_name = map['valyuta_name'];
    valyuta_short = map['valyuta_short'];
    phone = map['phone'];
    liked = map['liked'];
    // paint_condition = map['paint_condition'];
  }

  @override
  String toString() {
    return 'ListingGetModals(id: $id, activeStatus: $activeStatus, brand: $brand, carImage: $carImage, car_body: $car_body, car_position: $car_position, car_type: $car_type, credit: $credit, description: $description, discount: $discount, district: $district, engine: $engine, expire_date: $expire_date, lat: $lat, long: $long, mileage: $mileage, model: $model, posted_date: $posted_date, price: $price, pulling_side: $pulling_side, region: $region, transmission: $transmission, type_of_fuel: $type_of_fuel, valyuta_kurs: $valyuta_kurs, valyuta_name: $valyuta_name, valyuta_short: $valyuta_short, viewed: $viewed, year: $year, phone: $phone, liked: $liked )';
  }
}
