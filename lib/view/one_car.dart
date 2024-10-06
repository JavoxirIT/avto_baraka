import 'package:avto_baraka/api/models/listing_get_models.dart';
import 'package:avto_baraka/api/service/listing_service.dart';
import 'package:avto_baraka/http_config/config.dart';
import 'package:avto_baraka/observer/launch_map.dart';
import 'package:avto_baraka/observer/share_route_observer.dart';
import 'package:avto_baraka/provider/token_provider/token_provider.dart';
import 'package:avto_baraka/screen/imports/imports_listing.dart';
import 'package:avto_baraka/style/announcement_input_decoration.dart';
import 'package:avto_baraka/style/box_decoration.dart';
import 'package:avto_baraka/style/colors.dart';
import 'package:avto_baraka/style/one_car_outline_button.dart';
import 'package:avto_baraka/style/sized_box_20.dart';
import 'package:avto_baraka/utill/call.dart';
import 'package:avto_baraka/widgets/icon_button_circle_vatar.dart';
import 'package:avto_baraka/widgets/car_card/one_card_data_title.dart';
import 'package:avto_baraka/widgets/car_card/one_card_table_row.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:intl/intl.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:latlong2/latlong.dart' as latLang;
import 'dart:io';


class OneCarView extends StatefulWidget {
  const OneCarView({Key? key}) : super(key: key);

  @override
  OneCarViewState createState() => OneCarViewState();
}

class OneCarViewState extends State<OneCarView> {
  final ShareRouteObserver shareRouteObserver = ShareRouteObserver();
  ListingGetModels? _carData;
  final List carImageList = [];
  final List carChipTagList = [];
  final _complaint = TextEditingController();

  @override
  void dispose() {
    _complaint.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    RouteSettings setting = ModalRoute.of(context)!.settings;

    if (setting.arguments != null) {
      _carData = setting.arguments as ListingGetModels;
      for (var i = 0; i < _carData!.carImage.length; i++) {
        carImageList.add({"image": _carData!.carImage[i]});
      }
    }

// viewed
    ListingService.servive.viewed(_carData!.id);
    // debugPrint('_carData: $_carData');

    super.didChangeDependencies();
  }

  void onPress(context) {}

  @override
  Widget build(BuildContext context) {
    final tokenProvider = Provider.of<TokenProvider>(context);
    // final languageProvider = Provider.of<LocalProvider>(context);
    final double height = MediaQuery.of(context).size.height / 3;
    final double heightImage = MediaQuery.of(context).size.height;
    Color likeColor = _carData!.liked != 1 ? colorWhite : colorRed;
    final carTitle =
        "${_carData!.brand} ${_carData!.model} ${_carData!.car_position}";
    final city = "${_carData!.region} ${_carData!.district}";

    return Scaffold(
      backgroundColor: cardBlackColor,
      appBar: AppBar(
        title: Text(
          carTitle,
          style: Theme.of(context).textTheme.bodyLarge,
          // style: TextStyle(color: textColorViolet),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(left: 5.0, right: 10.0),
            child: CircleAvatar(
              backgroundColor: colorEmber,
              radius: 16.0,
              child: IconButton(
                onPressed: () async {
                  if (_carData != null &&
                      // ignore: unnecessary_null_comparison
                      carImageList != null &&
                      carImageList.isNotEmpty) {
                    shareRouteObserver.share(context, _carData, carImageList);
                  } else {
                    debugPrint('Нет изображения');
                  }
                },
                icon: Icon(
                  Symbols.share,
                  color: colorWhite,
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
                      semanticLabel: "image auto",
                      Config.imageUrl! + item['image'].substring(1),
                      fit: BoxFit.cover,
                      height: heightImage,
                      width: MediaQuery.of(context).size.width,
                    ),
                  ),
                )
                .toList(),
            options: FlutterCarouselOptions(
              autoPlay: true,
              showIndicator: false,
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
            // width: 192,
            child: Card(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text.rich(
                      TextSpan(
                        children: [
                          WidgetSpan(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                right: 8.0,
                              ),
                              child: Icon(
                                FontAwesomeIcons.eye,
                                size: 14.0,
                                color: colorRed,
                              ),
                            ),
                          ),
                          TextSpan(
                            text: _carData!.viewed != 0
                                ? _carData!.viewed.toString()
                                : "0",
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    Text(
                      NumberFormat.currency(
                        locale: "uz-UZ",
                        symbol: _carData!.valyutaShort,
                        decimalDigits: 0,
                      ).format(_carData!.price),
                      style: TextStyle(
                        color: colorEmber,
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
                  color: cardBlackColor,
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
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          iconButton(
                              Icon(
                                FontAwesomeIcons.locationDot,
                                color: colorWhite,
                                size: 18.0,
                              ),
                              18.0,
                              colorRed,
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
                          color: colorEmber,
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
                              '${_carData!.mileage.toString()} km.'),
                          tableRow(S.of(context).uzatishQutisi,
                              _carData!.transmission),
                          tableRow(S.of(context).kuzovTuri, _carData!.car_body),
                          tableRow(S.of(context).tortuvchiTomon,
                              _carData!.pulling_side),
                          tableRow(S.of(context).yoqilgiTuri,
                              _carData!.type_of_fuel),
                          tableRow(S.of(context).boyoqHolati,
                              _carData!.paint_condition),
                          tableRow(
                              S.of(context).kreditga,
                              _carData!.credit != 1
                                  ? S.of(context).yoq
                                  : S.of(context).ilojiBor),
                        ],
                      ),
                      sizedBoxH20,
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Text(
                          S
                              .of(context)
                              .boshqaNameAvtomobillariOrasidaNarxDarajasi(
                                  _carData!.model),
                        ),
                      ),
                      sizedBoxH20,
                      PriceIndicator(
                        currentPercent: double.parse(_carData!.price_foiz),
                        image: _carData!.modelImg,
                        maxPrice: _carData!.max_price,
                        minPrice: _carData!.min_price,
                        price: _carData!.price,
                      ),
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
                      onaCardDataTitle(
                          context, S.of(context).xaritadagiJoylashuvi),
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
                                initialCenter: latLang.LatLng(
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
                                      point: latLang.LatLng(
                                          double.parse(_carData!.lat),
                                          double.parse(_carData!.long)),
                                      child: Icon(
                                        Icons.location_pin,
                                        color: colorEmber,
                                        size: 46.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
      bottomSheet: BottomAppBar(
        color: colorEmber,
        elevation: 0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleAvatar(
              backgroundColor: cardBlackColor,
              radius: 16.0,
              child: IconButton(
                onPressed: () {
                  complaint(context);
                },
                icon: Icon(
                  FontAwesomeIcons.triangleExclamation,
                  color: colorWhite,
                  size: 15.0,
                ),
              ),
            ),
            CircleAvatar(
              backgroundColor: cardBlackColor,
              radius: 16.0,
              child: IconButton(
                onPressed: () {
                  BlocProvider.of<ListingBloc>(context).add(
                    LikeEvendSend(
                      id: _carData!.id,
                      token: tokenProvider.token!,
                    ),
                  );
                  BlocProvider.of<ListingBloc>(context).add(
                    const ListingEventLoad(),
                  );

                  setState(() {
                    _carData!.liked = _carData!.liked != 1 ? 1 : 0;
                  });
                },
                icon: Icon(
                  FontAwesomeIcons.heartCircleCheck,
                  color: likeColor,
                  size: 15.0,
                ),
              ),
            ),
            CircleAvatar(
              backgroundColor: cardBlackColor,
              radius: 16.0,
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    RouteName.firstChat,
                    arguments: {
                      "userId": _carData!.userId,
                    },
                  );
                },
                icon: Icon(
                  Symbols.message_rounded,
                  color: colorWhite,
                  size: 15.0,
                ),
              ),
            ),
            OutlinedButton(
              onPressed: () {
                
                if (Platform.isAndroid) {
    // Код для Android
                  call(_carData!.phone);
                } else if (Platform.isIOS) {
    // Код для iOS
                  callIos(_carData!.phone);
                }
              },
              style: oneCaroutlineButton.copyWith(
                  backgroundColor: WidgetStatePropertyAll(cardBlackColor)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Icon(
                    Symbols.phone,
                    size: 16.0,
                    color: colorWhite,
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    S.of(context).sotuvchigaQongiroqQilish,
                    style: Theme.of(context)
                        .textTheme
                        .displaySmall
                        ?.copyWith(color: colorWhite),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<dynamic> complaint(BuildContext context) {
    return showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return Dialog.fullscreen(
          backgroundColor: cardBlackColor,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                maxLines: 5,
                keyboardType: TextInputType.multiline,
                minLines: 5,
                decoration: announcementInputDecoration(
                    S.of(context).shikoyatingizniKiriting),
                maxLength: 100,
                controller: _complaint,
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        if (_complaint.text.trim() == "") {
                          return;
                        } else {
                          sendComplaint(_complaint.text, _carData!.id);
                        }
                      },
                      style: elevatedButton.copyWith(
                        backgroundColor: WidgetStatePropertyAll(colorEmber),
                      ),
                      child: Text(S.of(context).yuborish),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }

  void sendComplaint(String complaint, int id) async {
    final result = await ListingService.servive.complaint(complaint, id);
    if (mounted) {
      if (result['status'] == "success") {
        _complaint.text = "";
        showDialog(
          context: context,
          builder: (context) {
            return Dialog(
              insetAnimationDuration: const Duration(seconds: 2),
              backgroundColor: cardBlackColor,
              child: Container(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  S.of(context).shikoyatYuborildi,
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge!
                      .copyWith(color: colorWhite),
                ),
              ),
            );
          },
        );
      }
      setState(() {});
    }
  }

  // ignore: unused_element
  void _onShareXFileFromAssets(
      BuildContext context, ListingGetModels? carData) async {
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

class PriceIndicator extends StatelessWidget {
  const PriceIndicator({
    super.key,
    required this.minPrice,
    required this.maxPrice,
    required this.currentPercent,
    required this.image,
    required this.price,
  });

  final int minPrice;
  final int maxPrice;
  final double currentPercent;
  final String image;
  final int price;

  @override
  Widget build(BuildContext context) {
    // double percent = (currentPercent - 100) / 100;
    double percent = (300 / 100) * currentPercent;
    // print('currentPercent: $currentPercent');
    // print('WIDTH: ${MediaQuery.of(context).size.width}');
    // print('data: $percent');

    return Container(
      width: MediaQuery.of(context).size.width,
      height: 150,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: 5.0,
            width: 300.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              gradient: const LinearGradient(
                colors: [Colors.green, Colors.yellow, Colors.red],
              ),
            ),
          ),
          Positioned(
            right: percent,
            top: 0.0,
            child: Column(
              children: [
                Image.network(
                  semanticLabel: "image auto",
                  Config.imageUrl! + image,
                  fit: BoxFit.cover,
                  width: 60.0,
                ),
                Text(
                  '$price',
                  style: TextStyle(
                    color: colorEmber,
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Icon(
                  Icons.arrow_drop_down,
                  size: 20,
                  color: colorEmber,
                ),
              ],
            ),
          ),
          Positioned(
            left: 0,
            top: 67.0,
            child: Text(
              '$minPrice',
              style: const TextStyle(color: Colors.green, fontSize: 10),
            ),
          ),
          Positioned(
            right: 0,
            top: 66.0,
            child: Text(
              '$maxPrice',
              style: const TextStyle(color: Colors.red, fontSize: 10),
            ),
          ),
        ],
      ),
    );
  }
}
