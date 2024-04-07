import 'package:avto_baraka/style/elevated_button.dart';
import 'package:avto_baraka/utill/car_list_data.dart';
import 'package:avto_baraka/utill/category_carousel_item.dart';
import 'package:avto_baraka/widgets/car_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Map<String, dynamic>> list =
      carList.where((element) => element['activeStatus'] != false).toList();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      // initialIndex: 1,
      length: 1,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                toolbarHeight: 168.0,
                title: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () {},
                          style: elevatedButton,
                          child: const Text("Kredit Kalkulatori"),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(FontAwesomeIcons.sliders),
                        )
                      ],
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: const Padding(
                        padding: EdgeInsets.only(top: 10.0, bottom: 14.0),
                        child: Text(
                          "KATEGORIYALAR",
                          style: TextStyle(
                              fontSize: 14.0, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    FlutterCarousel(
                      options: CarouselOptions(
                        autoPlay: false,
                        // controller: buttonCarouselController,
                        enlargeCenterPage: false,
                        enableInfiniteScroll: true,
                        // disableCenter: true,
                        viewportFraction: 0.4,
                        aspectRatio: 2.0,
                        initialPage: 1,
                        height: 79.0,
                        showIndicator: false,
                        onPageChanged: (index, reason) {},
                      ),
                      items: categoryCarouselItem
                          .map(
                            (item) => Card(
                              margin: const EdgeInsets.only(right: 16.0),
                              color: const Color(0xFFF0F0F0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    item["image"],
                                    fit: BoxFit.cover,
                                    height: 42.0,
                                    width: 42.0,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 5.0, left: 0.0, right: 0.0),
                                    child: Center(
                                      child: Text(
                                        item['text'],
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          fontSize: 12.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ],
                ),
                pinned: true,
                floating: true,
                bottom: Tab(
                  height: 65.0,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: const Padding(
                      padding:
                          EdgeInsets.only(top: 22.0, bottom: 14.0, left: 15.0),
                      child: Text(
                        "ENG YAXSHI TAKLIFLAR",
                        style: TextStyle(
                            fontSize: 14.0, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
              ),
            ];
          },
          body: Column(
            children: [
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: carCard(list),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
