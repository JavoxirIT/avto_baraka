import 'package:avto_baraka/api/models/listing_get_models.dart';
import 'package:avto_baraka/generated/l10n.dart';
import 'package:avto_baraka/http_config/config.dart';
import 'package:avto_baraka/observer/launch_map.dart';
import 'package:avto_baraka/observer/share_route_observer.dart';
import 'package:avto_baraka/router/route_name.dart';
import 'package:avto_baraka/style/box_decoration.dart';
import 'package:avto_baraka/style/colors.dart';
import 'package:avto_baraka/style/one_car_outline_button.dart';
import 'package:avto_baraka/style/sized_box_20.dart';
import 'package:avto_baraka/utill/call.dart';
import 'package:avto_baraka/widgets/icon_button_circle_vatar.dart';
import 'package:avto_baraka/widgets/one_card_data_title.dart';
import 'package:avto_baraka/widgets/one_card_table_row.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:share_plus/share_plus.dart';
// ignore: depend_on_referenced_packages
import 'package:latlong2/latlong.dart';

class OneCarView extends StatefulWidget {
  const OneCarView({Key? key}) : super(key: key);

  @override
  OneCarViewState createState() => OneCarViewState();
}

class OneCarViewState extends State<OneCarView> {
  final ShareRouteObserver shareRouteObserver = ShareRouteObserver();
  ListingGetModals? _carData;
  final List carImageList = [];
  final List carChipTagList = [];

  @override
  void didChangeDependencies() {
    RouteSettings setting = ModalRoute.of(context)!.settings;

    if (setting.arguments != null) {
      _carData = setting.arguments as ListingGetModals;
      // carImageList = _carData.carImage;

      for (var i = 0; i < _carData!.carImage.length; i++) {
        carImageList.add({"image": _carData!.carImage[i]});
      }
      // for (var i = 0; i < _carData.additionalOption.length; i++) {
      //   carChipTagList.add({"tag": _carData.additionalOption[i]});
      // }
    }

    super.didChangeDependencies();
  }

  void onPress(context) {}
  // @override
  // void initState() {
  //   super.initState();
  //   WidgetsBinding.instance!.addPostFrameCallback((_) {
  //     Navigator.of(context).addObserver(shareRouteObserver);
  //   });
  // }

  // @override
  // void dispose() {
  //   Navigator.of(context).removeObserver(shareRouteObserver);
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height / 3;
    final double heightImage = MediaQuery.of(context).size.height;

    final carTitle =
        "${_carData!.brand} ${_carData!.model} ${_carData!.car_position}";
    final city = "${_carData!.region} ${_carData!.district}";

    return Scaffold(
      appBar: AppBar(
        title: Text(
          carTitle,
          // style: Theme.of(context).textTheme.bodyLarge,
          // style: TextStyle(color: textColorViolet),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(left: 5.0, right: 10.0),
            child: CircleAvatar(
              backgroundColor: backgrounColor,
              radius: 16.0,
              child: IconButton(
                onPressed: () async {
                  if (_carData != null &&
                      carImageList != null &&
                      carImageList.isNotEmpty) {
                    shareRouteObserver.share(context, _carData, carImageList);
                  } else {
                    debugPrint('Нет изображения');
                  }
                },
                icon: Icon(
                  Symbols.share,
                  color: iconSelectedColor,
                  size: 15.0,
                ),
              ),
            ),
          )
        ],
      ),
      body: Stack(
        children: [
          FlutterCarousel(
            items: carImageList
                .map(
                  (item) => GestureDetector(
                    onTap: () => Navigator.of(context).pushNamed(
                        RouteName.fullScreenImage,
                        arguments: carImageList),
                    child: Image.network(
                      Config.imageUrl! + item['image'].substring(1),
                      fit: BoxFit.cover,
                      height: heightImage,
                      width: MediaQuery.of(context).size.width,
                    ),
                  ),
                )
                .toList(),
            options: CarouselOptions(
              autoPlay: false,
              // controller: buttonCarouselController,
              enlargeCenterPage: true,
              viewportFraction: 1,
              aspectRatio: 1,
              initialPage: 0,
              height: height,
              // onPageChanged: (index, reason) {
              //   setState(() {
              //     _currentPosition = index;
              //   });
              // },
            ),
          ),
          Positioned(
            top: 0,
            right: 5.0,
            width: 192,
            child: Card(
              color: cardFixCardColor,
              child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text.rich(
                      TextSpan(
                        children: [
                          const WidgetSpan(
                            child: Padding(
                              padding: EdgeInsets.only(right: 8.0),
                              child: Icon(FontAwesomeIcons.eye, size: 14.0),
                            ),
                          ),
                          TextSpan(
                            text: _carData!.viewed != 0
                                ? _carData!.viewed.toString()
                                : "0",
                            style: const TextStyle(
                                fontSize: 12.0, fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      '${_carData!.price.toString()} y.e',
                      style: TextStyle(
                        color: iconSelectedColor,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.7,
            minChildSize: 0.66,
            maxChildSize: 0.96,
            snap: true,
            snapAnimationDuration: const Duration(milliseconds: 150),
            builder: (BuildContext context, ScrollController scrollController) {
              return Container(
                padding: const EdgeInsets.only(
                    left: 25.0, right: 25.0, top: 10.0, bottom: 100),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.white,
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  controller: scrollController,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            city,
                            style: TextStyle(
                              color: textColorViolet,
                              fontSize: 14.0,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          iconButton(
                              Icon(
                                FontAwesomeIcons.locationDot,
                                color: colorRed,
                                size: 18.0,
                              ),
                              18.0,
                              backgrounColor,
                              launchMap,
                              context,
                              [
                                double.parse(_carData!.lat),
                                double.parse(_carData!.long)
                              ])
                        ],
                      ),
                      onaCardDataTitle(context, S.of(context).parametrlar),
                      Table(
                        border: TableBorder.all(
                          color: backgrounColor,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(5.0),
                          ),
                        ),
                        children: [
                          tableRow(S.of(context).chiqarilganYili,
                              _carData!.year.toString()),
                          tableRow(S.of(context).dvigatelHajmi,
                              _carData!.engine.toString()),
                          tableRow(S.of(context).yurganMasofasi,
                              _carData!.mileage.toString()),
                          tableRow(S.of(context).uzatishQutisi,
                              _carData!.transmission),
                          tableRow(S.of(context).kuzovTuri, _carData!.car_body),
                          // tableRow(
                          //     S.of(context).boyoqHolati, _carData.paintCondition),
                          tableRow(S.of(context).tortuvchiTomon,
                              _carData!.pulling_side),
                          tableRow(S.of(context).yoqilgiTuri,
                              _carData!.type_of_fuel),
                          // tableRow(S.of(context).boyoqHolati,
                          //     _carData!.paint_condition),
                          tableRow(
                              S.of(context).kreditga,
                              _carData!.credit != 1
                                  ? S.of(context).yoq
                                  : S.of(context).ilojiBor),
                        ],
                      ),

                      // onaCardDataTitle(context, 'Qo’shimcha qulayliklar'),
                      // SizedBox(
                      //   width: MediaQuery.of(context).size.width,
                      //   child: Wrap(
                      //     direction: Axis.horizontal,
                      //     alignment: WrapAlignment.start,
                      //     children: carChipTagList
                      //         .map(
                      //           (el) => oneCardChipTag(el.tag),
                      //         )
                      //         .toList(),
                      //   ),
                      // ),
                      sizedBoxH20,
                      onaCardDataTitle(context, S.of(context).qoshimchaMalumot),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Text(
                          _carData!.description,
                          style: const TextStyle(fontSize: 12.0),
                          textAlign: TextAlign.justify,
                          overflow: TextOverflow.visible,
                        ),
                      ),
                      sizedBoxH20,
                      onaCardDataTitle(context, "Xaritadagi joylashuvi"),
                      SizedBox(
                        height: 200.0,
                        width: MediaQuery.of(context).size.width,
                        child: Container(
                          decoration: boxDecoration(),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15.0),
                            child: FlutterMap(
                              // mapController: _mapController,
                              options: MapOptions(
                                initialCenter: LatLng(
                                    double.parse(_carData!.lat),
                                    double.parse(_carData!.long)),
                                initialZoom: 16.0,
                              ),
                              children: [
                                TileLayer(
                                  urlTemplate:
                                      'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                                  userAgentPackageName: 'com.example.app',
                                ),
                                MarkerLayer(
                                  markers: [
                                    Marker(
                                      width: 80.0,
                                      height: 80.0,
                                      point: LatLng(double.parse(_carData!.lat),
                                          double.parse(_carData!.long)),
                                      child: Icon(
                                        Icons.location_pin,
                                        color: iconSelectedColor,
                                        size: 46.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
      bottomSheet: BottomAppBar(
        color: const Color.fromARGB(255, 247, 247, 247),
        elevation: 0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            iconButton(
              const Icon(
                FontAwesomeIcons.triangleExclamation,
                color: Color(0xFFFFC400),
                size: 15.0,
              ),
              16.0,
              const Color(0x2EFFC400),
              onPress,
              context,
            ),
            iconButton(
              const Icon(
                FontAwesomeIcons.heartCircleCheck,
                color: Color.fromARGB(218, 255, 0, 0),
                size: 15.0,
              ),
              16.0,
              const Color.fromARGB(31, 255, 0, 0),
              onPress,
              context,
            ),
            CircleAvatar(
              backgroundColor: const Color.fromARGB(22, 0, 128, 128),
              radius: 16.0,
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    RouteName.chatTwo,
                    arguments: {
                      "userId": _carData!.userId,
                    },
                  );
                },
                icon: const Icon(
                  Symbols.message_rounded,
                  color: Color(0XFF008080),
                  size: 15.0,
                ),
              ),
            ),
            OutlinedButton(
              onPressed: () {
                call(_carData!.phone);
              },
              style: oneCaroutlineButton,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Icon(
                    Symbols.phone,
                    size: 16.0,
                    // color: Color(0xFF001BAB),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    S.of(context).sotuvchigaQongiroqQilish,
                    style: Theme.of(context)
                        .textTheme
                        .displaySmall
                        ?.copyWith(color: iconSelectedColor),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  // ignore: unused_element
  void _onShareXFileFromAssets(
      BuildContext context, ListingGetModals? carData) async {
    final imageUrl = Config.imageUrl! + carImageList[0]['image'].substring(1);
    final box = context.findRenderObject() as RenderBox?;
    final data = await NetworkAssetBundle(Uri.parse(imageUrl)).load('');

    final buffer = data.buffer;
    await Share.shareXFiles(
      [
        XFile.fromData(
          buffer.asUint8List(data.offsetInBytes, data.lengthInBytes),
          name: carData!.model,
          mimeType: 'image/png',
        ),
      ],
      text:
          'Bu rasim Auto Baraka dasturidan yuborilgan\n ${carData.brand} ${carData.model} ${carData.car_position} \n ${carData.description}',
      sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
    );

    // Вернуться на предыдущий маршрут
    // ignore: use_build_context_synchronously
    Navigator.of(context).pop();
  }

  bool get isOnDesktopAndWeb {
    if (kIsWeb) {
      return true;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
      case TargetPlatform.iOS:
        return true;
      case TargetPlatform.macOS:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
      case TargetPlatform.fuchsia:
        return false;
    }
  }
}
