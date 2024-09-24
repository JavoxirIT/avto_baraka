import 'package:flutter/material.dart' hide CarouselController;
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';

Future<void> call(String number) async {
  var status = await Permission.phone.status;
  if (!status.isGranted) {
    status = await Permission.phone.request();
  }

  if (status.isGranted) {
    const platform = MethodChannel('com.autobaraka.auto_baraka/call_phone');
    try {
      await platform.invokeMethod('callPhone', {"number": number});
    } on PlatformException catch (e) {
      debugPrint("Не удалось совершить телефонный звонок: ${e.message}");
    }
  } else {
    debugPrint("Разрешение на вызов было отклонено.");
  }
}



Future<void> callIos(String number) async {
  const platform = MethodChannel('com.autobaraka.auto_baraka/call_phone');
  try {
    await platform.invokeMethod('callPhone', {"number": number});
  } on PlatformException catch (e) {
    debugPrint("Не удалось совершить телефонный звонок: ${e.message}");
  }
}
