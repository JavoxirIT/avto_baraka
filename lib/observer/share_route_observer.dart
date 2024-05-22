import 'package:avto_baraka/api/models/listing_get_models.dart';
import 'package:avto_baraka/http/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';

class ShareRouteObserver extends NavigatorObserver {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  void share(BuildContext context, ListingGetModals? _carData,
      List<dynamic> carImageList) async {
    // Ваш код для операции шаринга
    final imageUrl = Config.imageUrl! + carImageList[0]['image'].substring(1);
    final box = context.findRenderObject() as RenderBox?;
    final data = await NetworkAssetBundle(Uri.parse(imageUrl)).load('');
    final buffer = data.buffer;
    await Share.shareXFiles(
      [
        XFile.fromData(
          buffer.asUint8List(data.offsetInBytes, data.lengthInBytes),
          name: _carData!.model,
          mimeType: 'image/png',
        ),
      ],
      text:
          'Bu rasim Auto Baraka dasturidan yuborilgan\n ${_carData.brand} ${_carData.model} ${_carData.car_position} \n ${_carData.description}',
      sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
    );

    // После операции шаринга возвращаемся к предыдущему маршруту
    navigatorKey.currentState!
        .popUntil((route) => route.settings.name == '/oneCarView');
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
  }
}
