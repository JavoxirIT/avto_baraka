import 'package:avto_baraka/provider/token_provider/token_provider.dart';
import 'package:avto_baraka/router/route_name.dart';
import 'package:avto_baraka/style/colors.dart';
import 'package:avto_baraka/utill/main_carousel_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:provider/provider.dart';

class IntroductionScreen extends StatefulWidget {
  const IntroductionScreen({super.key});
  @override
  State<IntroductionScreen> createState() => _MainPageState();
}

class _MainPageState extends State<IntroductionScreen> {
  CarouselController buttonCarouselController = CarouselController();
  int _currentPosition = 0;

  bool onNextPage = false;

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height / 2;
    final double heightImage = MediaQuery.of(context).size.height / 5;
    return Scaffold(
      body: SafeArea(
        child: Consumer<TokenProvider>(
          builder: (context, tokenProvider, _) {
            return Column(
              children: [
                Expanded(
                  child: FlutterCarousel(
                    items: mainCarouselItem
                        .map(
                          (item) => Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(
                                child: item["image"] is int
                                    ? fourthcard(context, item)
                                    : item["image"] is Widget
                                        ? item["image"]
                                        : Image.asset(
                                            item["image"],
                                            fit: BoxFit.contain,
                                            height: heightImage,
                                          ),
                              ),
                              const SizedBox(
                                height: 30.0,
                              ),
                              textcard(item),
                            ],
                          ),
                        )
                        .toList(),
                    options: CarouselOptions(
                      autoPlay: false,
                      controller: buttonCarouselController,
                      enlargeCenterPage: true,
                      viewportFraction: 1,
                      aspectRatio: 2.0,
                      initialPage: 0,
                      height: height,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _currentPosition = index;
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 200,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _currentPosition == 0
                          ? ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shape: const CircleBorder(),
                                  backgroundColor: const Color(0xffd9d9d9),
                                  padding: const EdgeInsets.all(15.0)),
                              onPressed: () {},
                              child:
                                  const Icon(Icons.circle, color: Colors.black),
                            )
                          : ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shape: const CircleBorder(),
                                  backgroundColor: const Color(0xff008080),
                                  padding: const EdgeInsets.all(15.0)),
                              onPressed: () {
                                buttonCarouselController.previousPage(
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.linear);
                              },
                              child: const Icon(Icons.arrow_back_ios_new,
                                  color: Colors.white),
                            ),
                      DotsIndicator(
                        dotsCount: mainCarouselItem.length,
                        position: _currentPosition,
                        decorator: const DotsDecorator(
                          activeColor: Color(0xFF008080),
                          color: Color(0XFFd9d9d9),
                          size: Size(15.0, 15.0),
                          activeSize: Size(15.0, 15.0),
                        ),
                      ),
                      _currentPosition == 3
                          ? ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: const CircleBorder(),
                                backgroundColor: _currentPosition == 3 &&
                                        tokenProvider.token == ""
                                    ? unselectedItemColor
                                    : iconSelectedColor,
                                padding: const EdgeInsets.all(15.0),
                              ),
                              onPressed: () {
                                if (tokenProvider.token == "") {
                                  if (_currentPosition == 3) {
                                    return;
                                  }
                                }

                                Navigator.of(context).pushNamed(
                                    RouteName.bottomNavigationHomeScreen);
                              },
                              child: const Icon(
                                Icons.check,
                                color: Colors.white,
                              ),
                            )
                          : ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: const CircleBorder(),
                                backgroundColor: iconSelectedColor,
                                padding: const EdgeInsets.all(15.0),
                              ),
                              onPressed: () {
                                buttonCarouselController.nextPage(
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.linear);
                              },
                              child: const Icon(Icons.arrow_forward_ios_rounded,
                                  color: Colors.white),
                            ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Padding textcard(Map<String, dynamic> item) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, left: 35.0, right: 35.0),
      child: Center(
        child: Text(
          item['text'],
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 18.0,
            color: Color(0xFF008080),
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  Container fourthcard(BuildContext context, Map<String, dynamic> item) {
    return Container(
      decoration: BoxDecoration(
        color: backgnColStepCard,
        borderRadius: const BorderRadius.all(
          Radius.circular(10.0),
        ),
        border: Border.all(
          color: cardCashColor,
        ),
      ),
      width: MediaQuery.of(context).size.width / 1.2,
      padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 10.0),
      child: Text(
        item["image"].toString(),
        style: TextStyle(
          color: iconSelectedColor,
          fontSize: 36.0,
          fontWeight: FontWeight.w700,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
