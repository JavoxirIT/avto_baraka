import 'package:flutter/foundation.dart';

class SendListingProvider extends ChangeNotifier {
  bool dataSendingStatusIndicator = false;

  // SendListingProvider() {
  //   fetchLocale();
  // }

  set setDataSendingStatusIndicator(bool value) {
    dataSendingStatusIndicator = value;

    notifyListeners();
  }

  bool broadcastValue() {
    debugPrint('SendListingProvider: $dataSendingStatusIndicator');
    return dataSendingStatusIndicator;
  }

  bool get getDataSendingStatusIndicator => dataSendingStatusIndicator;
}
