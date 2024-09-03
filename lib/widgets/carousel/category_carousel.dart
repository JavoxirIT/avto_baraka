import 'package:avto_baraka/api/models/car_category_models.dart';
import 'package:avto_baraka/bloc/listing/listing_bloc.dart';
import 'package:avto_baraka/http_config/config.dart';
import 'package:avto_baraka/provider/language_provider/locale_provider.dart';
import 'package:avto_baraka/provider/token_provider/token_provider.dart';
import 'package:flutter/material.dart' hide CarouselController;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:provider/provider.dart';

class CategoryCarousel extends StatelessWidget {
  const CategoryCarousel({
    Key? key,
    required this.categoryList,
  }) : super(key: key);

  final List<CarCategoryModels> categoryList;

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LocalProvider>(context);
    final tokenProvider = Provider.of<TokenProvider>(context);
    return FlutterCarousel(
      options: CarouselOptions(
        // autoPlay: true,
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
      items: categoryList
          .map(
            (item) => InkWell(
              onTap: () {
                BlocProvider.of<ListingBloc>(context).add(
                  ListingEvantSearch(
                    ltype_id: item.id,
                    lang: languageProvider.locale.languageCode,
                    token: tokenProvider.token,
                  ),
                );
              },
              // ltype_id
              child: Card(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.network(
                      Config.imageUrl! + item.icon,
                      fit: BoxFit.cover,
                      height: 42.0,
                      width: 42.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 5.0, left: 0.0, right: 0.0),
                      child: Center(
                        child: Text(
                          item.name,
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
            ),
          )
          .toList(),
    );
  }
}
