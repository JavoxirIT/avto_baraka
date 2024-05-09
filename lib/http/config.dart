import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Config {
  static final dbUrl = dotenv.env['DB_URL'];
  static final dbMobile = dotenv.env['DB_URL_MOBILE'];
  static final dio = Dio();
}
