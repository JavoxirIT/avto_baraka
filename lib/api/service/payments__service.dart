import 'package:avto_baraka/api/models/rates_models.dart';
import 'package:avto_baraka/api/service/local_memory.dart';
import 'package:avto_baraka/screen/imports/imports_announcement.dart';
import 'package:dio/dio.dart';
// import 'package:avto_baraka/http_config/config.dart';

class PaymentsService {
  static final PaymentsService ps = PaymentsService();
  final _dio = Config.dio;
  final _url = Config.dbMobile;

  Map listPayCardStatus = {};
  Map smsStatus = {};
  Map payStatus = {};

  List<RatesModels> listRates = [];

  String description = "";
  Future<String> paymentDesc() async {
    final lang = await LocalMemory.service.getLanguageCode();
    try {
      final response = await _dio.get('${_url}user-active-desc/$lang');
      if (response.statusCode == 200) {
        description = response.data;
      }
    } catch (e) {
      debugPrint('debugPrint: $e');
    }
    return description;
  }

  // SEND CARD DATA
  Future<Map> sendCardData(
    String cardNumber,
    String expireDate,
    String token,
  ) async {
    // listPayCardStatus.clear();
    try {
      final response = await _dio.post(
        '${_url}click',
        options: Options(
          headers: {"Authorization": token},
        ),
        data: {
          "card_number": cardNumber,
          "expire_date": expireDate,
        },
      );

      listPayCardStatus = response.data as Map<String, dynamic>;
      debugPrint('CLICK SEND CARD RESPONSE: $response');
    } catch (error) {
      debugPrint('CLICK SEND CARD ERROR: $error');
    }

    return listPayCardStatus;
  }

  Future<Map> clickSmscheck(
    String smsCode,
    String token,
  ) async {
    // listPayCardStatus.clear();
    try {
      final response = await _dio.post(
        '${_url}click-smscheck',
        options: Options(
          headers: {"Authorization": token},
        ),
        data: {
          "sms_code": smsCode,
        },
      );

      if (response.statusCode == 200) {
        // debugPrint('CLICK SEND SMS CODE: $response');
        smsStatus = {"status": response.data['status']};
      } else {
        debugPrint('CLICK SEND SMS CODE ERROR: ${response.statusCode}');
      }
    } catch (error) {
      debugPrint('CLICK SEND SMS CODE ERROR: $error');
    }

    return smsStatus;
  }

  Future<Map> clickPay(String token, int ratesId, int listingId) async {
    // ignore: prefer_typing_uninitialized_variables
    var response;
    try {
      if (ratesId != -1 && listingId != -1) {
        response = await _dio.post(
          '${_url}click-pay/$ratesId/$listingId',
          options: Options(
            headers: {"Authorization": token},
          ),
        );
      } else {
        response = await _dio.post(
          '${_url}click-pay',
          options: Options(
            headers: {"Authorization": token},
          ),
        );
      }

      if (response.statusCode == 200) {
        // debugPrint('click-pay: $response');

        payStatus = {"status": response.data['status']};
      } else {
        debugPrint('click-pay ERROR: ${response.statusCode}');
      }
    } catch (error) {
      debugPrint('CLICK SEND SMS CODE ERROR: $error');
    }

    return payStatus;
  }
  // 9860020143046512
  // 09/28

  // GET DATA RATES
  Future<List<RatesModels>> getRates() async {
    var lang = await LocalMemory.service.getLanguageCode();
    listRates.clear();
    try {
      final response = await _dio.get(
        '${_url}tarif/$lang',
        options: Options(
          headers: {"Authorization": await LocalMemory.service.getLocolToken()},
        ),
      );

      if (response.statusCode == 200) {
        for (var obj in response.data) {
          listRates.add(RatesModels.fromMap(obj));
        }
      } else {
        debugPrint('rates response error: ${response.statusCode}');
      }
    } catch (error) {
      debugPrint('TARIF ERROR: $error');
    }
    return listRates;
  }
}
// 9860020143046512
// 09/28