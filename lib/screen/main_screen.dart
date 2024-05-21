import 'package:avto_baraka/api/models/car_category_models.dart';
import 'package:avto_baraka/api/models/region_models.dart';
import 'package:avto_baraka/api/service/car_service.dart';
import 'package:avto_baraka/api/service/region_service.dart';
import 'package:avto_baraka/bloc/listing/listing_bloc.dart';
import 'package:avto_baraka/generated/l10n.dart';
import 'package:avto_baraka/router/route_name.dart';
import 'package:avto_baraka/style/elevated_button.dart';
import 'package:avto_baraka/widgets/car_card.dart';
import 'package:avto_baraka/widgets/carousel/category_carousel.dart';
import 'package:avto_baraka/view/search_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<CarCategoryModels> categoryList = [];

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    RoundedRectangleBorder shape = const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(15.0),
      ),
    );

    return DefaultTabController(
      // initialIndex: 1,
      length: 1,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 35.0,
          leadingWidth: MediaQuery.of(context).size.width / 2.5,
          leading: Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(RouteName.creditBankListScreen);
              },
              style: elevatedButton,
              child: Text(
                S.of(context).kreditKalkulatori,
                style: Theme.of(context).textTheme.displayMedium,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(RouteName.searchView);
                },
                icon: const Icon(FontAwesomeIcons.sliders),
              ),
            ),
          ],
        ),
        body: BlocBuilder<ListingBloc, ListingState>(
          builder: (context, state) {
            if (state is ListingStateNoDataSearch) {
              WidgetsBinding.instance!.addPostFrameCallback(
                (_) {
                  showDialog(
                    context: context,
                    builder: (_) {
                      Future.delayed(const Duration(seconds: 3), () {
                        Navigator.of(context).pop();
                      });
                      return AlertDialog(
                        title: Text(
                          S.of(context).kechirasiz,
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                        content: Text(
                          S.of(context).malumotTopilmadi,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      );
                    },
                  );
                },
              );
            }

            return Column(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 10.0, bottom: 0.0, left: 15.0),
                    child: Text(
                      S.of(context).kategoriyalar,
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                  ),
                ),
                flutterCarousel(context, categoryList),
                const SizedBox(
                  height: 10.0,
                ),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: carCard(context, state),
                ))
              ],
            );
          },
        ),
      ),
    );
  }

  Future<void> getData() async {
    categoryList = await CarService().carCategoryLoad();
    setState(() {});
  }
}
