import 'package:avto_baraka/generated/l10n.dart';
import 'package:avto_baraka/router/route_name.dart';
import 'package:avto_baraka/style/elevated_button.dart';
import 'package:avto_baraka/utill/car_list_data.dart';
import 'package:avto_baraka/widgets/car_card.dart';
import 'package:avto_baraka/widgets/carousel/category_carousel.dart';
import 'package:flutter/material.dart';
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
                onPressed: () {},
                icon: const Icon(FontAwesomeIcons.sliders),
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding:
                    const EdgeInsets.only(top: 10.0, bottom: 0.0, left: 15.0),
                child: Text(
                  S.of(context).kategoriyalar,
                  style: Theme.of(context).textTheme.displayLarge,
                ),
              ),
            ),
            flutterCarousel(),
            const SizedBox(
              height: 10.0,
            ),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: carCard(list),
            ))
          ],
        ),
      ),
    );
  }
}
