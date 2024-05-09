import 'package:avto_baraka/utill/category_carousel_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';

FlutterCarousel flutterCarousel() {
  return FlutterCarousel(
    options: CarouselOptions(
      autoPlay: true,
      autoPlayCurve: Curves.ease,
      autoPlayInterval: const Duration(seconds: 3),
      // controller: buttonCarouselController,
      enlargeCenterPage: false,
      enableInfiniteScroll: true,
      // disableCenter: true,
      viewportFraction: 0.4,
      aspectRatio: 2.0,
      initialPage: 1,
      height: 85.0,
      showIndicator: false,
      onPageChanged: (index, reason) {},
    ),
    items: categoryCarouselItem
        .map(
          (item) => Card(
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
                  padding:
                      const EdgeInsets.only(top: 5.0, left: 0.0, right: 0.0),
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
  );
}
