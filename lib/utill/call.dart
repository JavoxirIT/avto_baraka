import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

void call(phone) async {
  await FlutterPhoneDirectCaller.callNumber(phone);
}
