import 'package:avto_baraka/api/models/listing_get_models.dart';
import 'package:avto_baraka/generated/l10n.dart';
import 'package:avto_baraka/http/config.dart';
import 'package:avto_baraka/router/route_name.dart';
import 'package:avto_baraka/style/colors.dart';
import 'package:avto_baraka/style/one_car_outline_button.dart';
import 'package:avto_baraka/utill/call.dart';
import 'package:avto_baraka/view/full_screen_image.dart';
import 'package:avto_baraka/widgets/icon_button_circle_vatar.dart';
import 'package:avto_baraka/widgets/one_card_chip_tag.dart';
import 'package:avto_baraka/widgets/one_card_data_title.dart';
import 'package:avto_baraka/widgets/one_card_table_row.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:share_plus/share_plus.dart';

class OneCarView extends StatefulWidget {
  const OneCarView({Key? key}) : super(key: key);

  @override
  OneCarViewState createState() => OneCarViewState();
}

class OneCarViewState extends State<OneCarView> {
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
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        actions: [
          iconButton(
              Icon(FontAwesomeIcons.triangleExclamation,
                  color: iconSelectedColor, size: 15.0),
              16.0,
              backgrounColor,
              onPress,
              context),
          Padding(
            padding: const EdgeInsets.only(left: 5.0, right: 10.0),
            child: iconButton(
                Icon(
                  Symbols.share,
                  color: iconSelectedColor,
                  size: 15.0,
                ),
                16.0,
                backgrounColor,
                onPress,
                context),
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
                      style: const TextStyle(
                        color: Color(0xFF1D00CE),
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
                            onPress,
                            context,
                          )
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
                          tableRow("Kuzov:", _carData!.car_body),
                          // tableRow(
                          //     S.of(context).boyoqHolati, _carData.paintCondition),
                          tableRow(S.of(context).tortuvchiTomon,
                              _carData!.pulling_side),
                          tableRow(S.of(context).yoqilgiTuri,
                              _carData!.type_of_fuel),
                          tableRow(
                              S.of(context).kreditga,
                              _carData!.credit != 1
                                  ? S.of(context).yoq
                                  : S.of(context).ilojiBor),
                        ],
                      ),
                      const SizedBox(
                        height: 23.0,
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
                      const SizedBox(
                        height: 23.0,
                      ),
                      onaCardDataTitle(context, S.of(context).qoshimchaMalumot),
                      Text(
                        _carData!.description,
                        style: const TextStyle(fontSize: 12.0),
                        textAlign: TextAlign.justify,
                        overflow: TextOverflow.visible,
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
        color: const Color.fromARGB(255, 247, 247, 247),
        elevation: 0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            iconButton(
              const Icon(
                Symbols.share,
                color: Color.fromARGB(255, 51, 51, 51),
                size: 15.0,
              ),
              16.0,
              const Color(0x264E4E4E),
              _onShareXFileFromAssets,
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
            iconButton(
              const Icon(
                Symbols.message_rounded,
                color: Color(0XFF008080),
                size: 15.0,
              ),
              16.0,
              // ignore: prefer_const_constructors
              Color.fromARGB(22, 0, 128, 128),
              onPress,
              context,
            ),
            OutlinedButton(
              onPressed: () {
                call("+998901005588");
              },
              style: oneCaroutlineButton,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Icon(
                    Symbols.phone,
                    size: 20.0,
                    // color: Color(0xFF001BAB),
                  ),
                  Text(
                    S.of(context).sotuvchigaQongiroqQilish,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _onShareXFileFromAssets(BuildContext context) async {
    final box = context.findRenderObject() as RenderBox?;
    final data = await rootBundle.load('assets/car/choko.jpg');
    final buffer = data.buffer;
    await Share.shareXFiles(
      [
        XFile.fromData(
          buffer.asUint8List(data.offsetInBytes, data.lengthInBytes),
          name: 'car',
          mimeType: 'image/png',
        ),
      ],
      text: "salom",
      sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
    );
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
