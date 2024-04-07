import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Config {
  static final dbUrl = dotenv.env['DB_URL'];
  static final dio = Dio();
}
