// ignore_for_file: unnecessary_overrides

import 'package:avto_baraka/api/models/listing_get_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';

import 'package:avto_baraka/http_config/config.dart';

class ShareRouteObserver extends NavigatorObserver {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  void share(BuildContext context, ListingGetModals? carData,
      List<dynamic> carImageList) async {
    if (carData == null ||
        carImageList.isEmpty ||
        carImageList[0]['image'] == null) {
      return;
    }

    try {
      final imageUrl = Config.imageUrl! + carImageList[0]['image'].substring(1);
      final box = context.findRenderObject() as RenderBox?;
      final data = await NetworkAssetBundle(Uri.parse(imageUrl)).load('');
      final buffer = data.buffer;
      await Share.shareXFiles(
        [
          XFile.fromData(
            buffer.asUint8List(data.offsetInBytes, data.lengthInBytes),
            name: carData.model,
            mimeType: 'image/png',
          ),
        ],
        text:
            'Bu rasim Auto Baraka dasturidan yuborilgan\n ${carData.brand} ${carData.model} ${carData.car_position} \n ${carData.description}',
        sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
      );

      // После операции шаринга возвращаемся к предыдущему маршруту
      navigatorKey.currentState!
          .popUntil((route) => route.settings.name == '/oneCarView');
    } catch (e) {
      debugPrint('Error during sharing: $e');
    }
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
  }
}
