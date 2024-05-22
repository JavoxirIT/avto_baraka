import 'package:avto_baraka/bloc/listing_active/listing_active_bloc.dart';
import 'package:avto_baraka/generated/l10n.dart';
import 'package:avto_baraka/http/config.dart';
import 'package:avto_baraka/router/route_name.dart';
import 'package:avto_baraka/style/clear_button.dart';
import 'package:avto_baraka/style/colors.dart';
import 'package:avto_baraka/widgets/car_tag_card.dart';
import 'package:avto_baraka/widgets/dismisable/delete_dismis.dart';
import 'package:avto_baraka/widgets/dismisable/secondary_dismis.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:material_symbols_icons/symbols.dart';

carFavpriteCard(context, state) {
  return ListView.builder(
    itemCount: state.listing.length,
    itemBuilder: (context, i) {
      final item = state.listing[i];
      final carTitle = "${item.brand} ${item.model} ${item.car_position}";
      return Stack(
        children: [
          Card(
            elevation: 5.0,
            borderOnForeground: true,
            surfaceTintColor: Colors.amber,
            margin: const EdgeInsets.only(bottom: 22.0),
            child: Dismissible(
              key: Key(item.id.toString()),
              confirmDismiss: (DismissDirection direction) async {
                if (direction == DismissDirection.startToEnd) {
                  // return await showDialog(
                  //   context: context,
                  //   builder: (BuildContext context) {
                  //     return AlertDialog(
                  //       title: const Text("Внимание"),
                  //       content: const Text(
                  //           "Вы уверены? после удаления данные не восстановить!?"),
                  //       actions: <Widget>[
                  //         ElevatedButton(
                  //             style: clearButton,
                  //             onPressed: () {},
                  //             child: const Text("Удалить")),
                  //         ElevatedButton(
                  //           onPressed: () => Navigator.of(context).pop(false),
                  //           child: const Text("Нет"),
                  //         ),
                  //       ],
                  //     );
                  //   },
                  // );
                } else if (direction == DismissDirection.endToStart) {
                  Navigator.of(context)
                      .pushNamed(RouteName.oneCarView, arguments: item);
                }
                return null;
              },
              background: deleteDismiss(context),
              secondaryBackground: secondaryDismiss(context),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(4.0),
                        child: Image.network(
                          Config.imageUrl! + item.carImage[0].substring(1),
                          fit: BoxFit.cover,
                          width: MediaQuery.of(context).size.width,
                          height: 200.0,
                        ),
                      ),
                      Positioned(
                        right: -7.5,
                        top: 0,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: const CircleBorder(),
                            backgroundColor: cardFixCardColor,
                            // padding: const EdgeInsets.all(15.0)\
                          ),
                          onPressed: () {},
                          child: Icon(
                            FontAwesomeIcons.solidHeart,
                            color: colorRed,
                            // color: true
                            //     ? colorRed
                            //     : const Color.fromARGB(255, 83, 83, 83),
                            size: 14.0,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
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
                                          child: Icon(FontAwesomeIcons.eye,
                                              size: 14.0),
                                        ),
                                      ),
                                      TextSpan(
                                        text: item.viewed != 0
                                            ? item.viewed.toString()
                                            : "0",
                                        style: const TextStyle(
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  '${item.price.toString()} y.e',
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
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 9.0),
                    child: Text(
                      carTitle,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                  Text(
                    "${item.region} ${item.district}",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: GridView(
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        // childAspectRatio: (itemWidth / itemHeight),
                        childAspectRatio: 1.5,
                        crossAxisSpacing: 2.0,
                        mainAxisSpacing: 0,
                        // mainAxisExtent: ,
                      ),
                      children: [
                        cardTagCard(
                          "${item.year} yil",
                          Icon(
                            Icons.calendar_month,
                            size: 17.0,
                            color: iconSelectedColor,
                          ),
                        ),
                        cardTagCard(
                          item.transmission,
                          Icon(
                            Symbols.auto_transmission,
                            size: 17.0,
                            color: iconSelectedColor,
                          ),
                        ),
                        cardTagCard(
                          item.type_of_fuel,
                          Icon(
                            Symbols.gas_meter_sharp,
                            size: 17.0,
                            color: iconSelectedColor,
                          ),
                        ),
                        cardTagCard(
                          '${item.mileage.toString()} km',
                          Icon(
                            Symbols.speed,
                            size: 17.0,
                            color: iconSelectedColor,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      );
    },
  );
}
