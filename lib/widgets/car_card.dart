import 'dart:convert';
import 'dart:typed_data';

import 'package:avto_baraka/bloc/like/like_bloc.dart';
import 'package:avto_baraka/bloc/listing/listing_bloc.dart';
import 'package:avto_baraka/generated/l10n.dart';
import 'package:avto_baraka/http_config/config.dart';
import 'package:avto_baraka/provider/language_provider/locale_provider.dart';
import 'package:avto_baraka/provider/token_provider/token_provider.dart';
import 'package:avto_baraka/router/route_name.dart';
import 'package:avto_baraka/style/colors.dart';
import 'package:avto_baraka/utill/bs64Image.dart';
import 'package:avto_baraka/widgets/car_tag_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:provider/provider.dart';

carCard(context, state) {
  final tokenProvider = Provider.of<TokenProvider>(context);
  final languageProvider = Provider.of<LocalProvider>(context);

  if (state is ListingStateLoading) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
  if (state is ListingStateLoad) {
    return ListView.builder(
      itemCount: state.listing.length,
      itemBuilder: (context, i) {
        final item = state.listing[i];

        final carTitle = "${item.brand} ${item.model} ${item.car_position}";
        Color likeColor = item.liked != 1 ? iconDizLike : colorRed;
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          return Stack(
            children: [
              Card(
                margin: const EdgeInsets.only(bottom: 22.0),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: InkWell(
                    splashColor: splashColor,
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        RouteName.oneCarView,
                        arguments: item,
                      );
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12.0),
                              child: FadeInImage(
                                fit: BoxFit.cover,
                                width: MediaQuery.of(context).size.width,
                                height: 200.0,
                                placeholder: MemoryImage(
                                  base64.decode(bs64Image.split(',').last),
                                ),
                                image: NetworkImage(
                                  Config.imageUrl! +
                                      item.carImage[0].substring(1),
                                ),
                              ),
                            ),
                            // item['statusTop'] == true
                            //     ? Positioned(
                            //         child: Card(
                            //           color: cardFixCardColor,
                            //           margin: const EdgeInsets.all(4.0),
                            //           child: Padding(
                            //             padding: const EdgeInsets.symmetric(
                            //               horizontal: 24.0,
                            //               vertical: 5.0,
                            //             ),
                            //             child: Text(
                            //               "TOP",
                            //               style: TextStyle(
                            //                 color: colorRed,
                            //                 fontSize: 14.0,
                            //                 fontWeight: FontWeight.w700,
                            //               ),
                            //             ),
                            //           ),
                            //         ),
                            //       )
                            //     : const Positioned(child: Text("")),
                            Positioned(
                              right: -7.5,
                              top: 0,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: const CircleBorder(),
                                  backgroundColor: cardFixCardColor,
                                  // padding: const EdgeInsets.all(15.0)\
                                ),
                                onPressed: () {
                                  BlocProvider.of<LikeBloc>(context)
                                      .add(LikeEvendSend(
                                    id: item.id,
                                    token: tokenProvider.token!,
                                  ));
                                  BlocProvider.of<ListingBloc>(context)
                                      .add(ListingEventLoad(
                                    languageProvider.locale.languageCode,
                                    tokenProvider.token,
                                  ));
                                },
                                child: Icon(
                                  FontAwesomeIcons.solidHeart,
                                  color: likeColor,
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
                                                child: Icon(
                                                    FontAwesomeIcons.eye,
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
              )
            ],
          );
        });
      },
    );
  }
  if (state is ListingStateNoData) {
    return Center(
      child: Text(S.of(context).malumotlatYuklanishidaXatolik),
    );
  }
  if (state is ListingStateError) {
    return Center(
      child: Text(S.of(context).malumotlarBazasidaXatolik),
    );
  }
  // return const Center(
  //   child: CircularProgressIndicator(),
  // );
}
