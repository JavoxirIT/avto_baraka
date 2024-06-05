import 'package:avto_baraka/bloc/listing_blocked/listing_blocked_bloc.dart';
import 'package:avto_baraka/http_config/config.dart';
import 'package:avto_baraka/screen/imports/imports_favorite.dart';
// import 'package:avto_baraka/router/route_name.dart';
import 'package:avto_baraka/style/colors.dart';
import 'package:avto_baraka/style/elevated_button.dart';
import 'package:avto_baraka/style/elevation_button_white.dart';
import 'package:avto_baraka/widgets/car_tag_card.dart';
import 'package:avto_baraka/widgets/dialog.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../generated/l10n.dart';

carBlockedCard(context, state, token, lang) {
  // onOneCarView(context, item) {
  //   Navigator.of(context).pushNamed(RouteName.oneCarView, arguments: item);
  // }

  if (state is ListingBlockedStateLoad) {
    return ListView.builder(
      itemCount: state.blockedList.length,
      itemBuilder: (context, i) {
        final item = state.blockedList[i];

        final carTitle = "${item.brand} ${item.model} ${item.car_position}";

        return Stack(
          children: [
            Card(
              clipBehavior: Clip.hardEdge,
              margin: const EdgeInsets.only(bottom: 22.0),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
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
                        item.activeStatus != 0
                            ? Positioned(
                                child: Card(
                                  color: cardFixCardColor,
                                  margin: const EdgeInsets.all(4.0),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 24.0,
                                      vertical: 5.0,
                                    ),
                                    child: Text(
                                      "TOP",
                                      style: TextStyle(
                                        color: colorRed,
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : const Positioned(child: Text("")),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          width: 192,
                          child: Card(
                            color: cardFixCardColor,
                            child: Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text.rich(
                                    TextSpan(
                                      children: [
                                        const WidgetSpan(
                                          child: Padding(
                                            padding:
                                                EdgeInsets.only(right: 8.0),
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
                    Text("${item.region} ${item.description}",
                        style: Theme.of(context).textTheme.bodyMedium),
                    Padding(
                      padding: const EdgeInsets.only(top: 22.0),
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
                          cardTagCard("${item.year} yil",
                              const Icon(Icons.calendar_month, size: 17.0)),
                          cardTagCard(
                              item.transmission,
                              const Icon(Symbols.auto_transmission,
                                  size: 17.0)),
                          cardTagCard(item.type_of_fuel,
                              const Icon(Symbols.gas_meter_sharp, size: 17.0)),
                          cardTagCard('${item.mileage.toString()} km',
                              const Icon(Symbols.speed, size: 17.0))
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 20.0,
              top: 0,
              left: 0,
              right: 0,
              child: Card(
                elevation: 0,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(0.0),
                  ),
                ),
                color: const Color.fromARGB(180, 255, 255, 255),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                        heightFactor: 5,
                        child: Text(
                          S
                              .of(context)
                              .ushbuElondaHatolikMavjudligiUchunTizimgaJoylanishiBekorQilindi,
                          style: TextStyle(
                            color: iconSelectedColor,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w700,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 3,
                          softWrap: true,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        dialogBuilder(
                            context,
                            S.of(context).diqqat,
                            Text(S
                                .of(context)
                                .eqlonOchirilgandanKeyinMalumotlarniTiklabBolmaydi),
                            [
                              ElevatedButton(
                                style: elevatedButton,
                                onPressed: () {
                                  BlocProvider.of<ListingBlockedBloc>(context)
                                      .add(
                                    ListingDeleteEvent(
                                      listingId: item.id,
                                      token: token,
                                      lang: lang,
                                    ),
                                  );
                                  Navigator.of(context).pop();
                                },
                                child: Text(
                                  S.of(context).ochirish,
                                ),
                              ),
                              ElevatedButton(
                                style: elevationButtonWhite,
                                onPressed: () =>
                                    Navigator.of(context).pop(false),
                                child: Text(
                                  S.of(context).yoq,
                                ),
                              ),
                            ]);
                      },
                      style: elevatedButton.copyWith(
                        backgroundColor: MaterialStatePropertyAll(colorRed),
                      ),
                      child: Text(
                        S.of(context).ochirish,
                        style: TextStyle(
                          fontSize: 14.0,
                          color: textColorWhite,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const SizedBox()
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
  if (state is ListingBlockedStateNotData) {
    return Center(
      child: Text(
        S.of(context).bloklanganElonMavjutNEmas("\n"),
        style: Theme.of(context).textTheme.labelLarge,
        textAlign: TextAlign.center,
      ),
    );
  }
  if (state is ListingBlockedInitial) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  if (state is ListingDeleted) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
