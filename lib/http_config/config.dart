import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Config {
  static final dio = Dio();
  static final ws = dotenv.env['WS_URL'];
  static final dbUrl = dotenv.env['DB_URL'];
  static final imageUrl = dotenv.env['DB_IMAGE_URL'];
  static final dbMobile = dotenv.env['DB_URL_MOBILE'];
}
