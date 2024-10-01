import 'dart:convert';
import 'package:avto_baraka/api/models/listing_get_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:avto_baraka/bloc/listing/listing_bloc.dart';
import 'package:avto_baraka/generated/l10n.dart';
import 'package:avto_baraka/http_config/config.dart';
import 'package:avto_baraka/provider/token_provider/token_provider.dart';
import 'package:avto_baraka/router/route_name.dart';
import 'package:avto_baraka/style/colors.dart';
import 'package:avto_baraka/utill/bs_64_image.dart';
import 'package:avto_baraka/widgets/bottom_loader.dart';
import 'package:avto_baraka/widgets/car_card/car_tag_card.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:intl/intl.dart';

class CarCard extends StatefulWidget {
  const CarCard({Key? key, required this.scrollController}) : super(key: key);

  final ScrollController scrollController;

  @override
  State<CarCard> createState() => _CarCardState();
}

class _CarCardState extends State<CarCard> {
  @override
  Widget build(BuildContext context) {
    final tokenProvider = Provider.of<TokenProvider>(context);

    return BlocBuilder<ListingBloc, ListingState>(builder: (context, state) {
      if (state is ListingStateNoDataSearch) {
        WidgetsBinding.instance.addPostFrameCallback(
          (_) {
            if (mounted) {
              showDialog(
                context: context,
                builder: (_) {
                  return AlertDialog(
                    title: Text(
                      S.of(context).kechirasiz,
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge!
                          .copyWith(color: colorWhite),
                    ),
                    content: Text(
                      S.of(context).malumotTopilmadi,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  );
                },
              ).then((_) {
                if (mounted) {
                  setState(() {}); // Ensure mounted before setState
                }
              });
            }
          },
        );
      }
      if (state is ListingStateHasDataSearch) {
        WidgetsBinding.instance.addPostFrameCallback(
          (_) {
            if (mounted) {
              showDialog(
                context: context,
                builder: (_) {
                  return AlertDialog(
                    title: Text(
                      S.of(context).sorovingizBoyicha,
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge!
                          .copyWith(color: colorWhite),
                    ),
                    content: Text(
                      S.of(context).countElonTopildi(state.count),
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  );
                },
              ).then((_) {
                if (mounted) {
                  setState(() {}); // Ensure mounted before setState
                }
              });
            }
          },
        );
      }

      switch (state.status) {
        case ListingStatus.failure:
          return Center(
            child: Text(S.of(context).malumotlarBazasidaXatolik),
          );
        case ListingStatus.success:
          if (state.listing.isEmpty) {
            return Center(
              child: Text(S.of(context).malumotlatYuklanishidaXatolik),
            );
          }
          return ListView.builder(
            controller: widget.scrollController,
            itemCount: state.hasReachedMax
                ? state.listing.length
                : state.listing.length + 1,
            itemBuilder: (context, i) {
              if (i >= state.listing.length) {
                return BottomLoader(
                  children: state.currentPage == state.lastPage
                      ? Text(S.of(context).yangiElonlarQoq,
                          textAlign: TextAlign.center)
                      : CircularProgressIndicator(
                          strokeWidth: 1.5, color: colorEmber),
                );
              }

              final item = state.listing[i];
              final carTitle =
                  "${item.brand} ${item.model} ${item.car_position}";

              return Stack(
                children: [
                  Card(
                    margin: const EdgeInsets.only(bottom: 22.0),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
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
                                      imageSemanticLabel: "image auto",
                                      fit: BoxFit.cover,
                                      width: MediaQuery.of(context).size.width,
                                      height: 200.0,
                                      placeholder: MemoryImage(
                                        base64
                                            .decode(bs64Image.split(',').last),
                                      ),
                                      image: item.carImage.isNotEmpty
                                          ? NetworkImage(Config.imageUrl! +
                                              item.carImage[0].substring(1))
                                          : NetworkImage("")),
                                ),
                                item.topStatus == 1
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
                                    : const SizedBox(),
                                Positioned(
                                  right: -7.5,
                                  top: 0,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      shape: const CircleBorder(),
                                      backgroundColor:
                                          cardBlackColor.withOpacity(0.5),
                                    ),
                                    onPressed: () {
                                      BlocProvider.of<ListingBloc>(context).add(
                                        LikeEvendSend(
                                          id: item.id,
                                          token: tokenProvider.token!,
                                        ),
                                      );

                                      // BlocProvider.of<ListingBloc>(context).add(
                                      //   const ListingEventLoad(),
                                      // );
                                    },
                                    child: Icon(
                                      FontAwesomeIcons.solidHeart,
                                      color: item.liked != 1
                                          ? colorWhite
                                          : colorRed,
                                      size: 14.0,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: Card(
                                    color: cardBlackColor,
                                    elevation: 0,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 3.0, horizontal: 10.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text.rich(
                                            TextSpan(
                                              children: [
                                                WidgetSpan(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                      right: 8.0,
                                                      left: 8.0,
                                                    ),
                                                    child: Icon(
                                                      FontAwesomeIcons.eye,
                                                      size: 14.0,
                                                      color: colorRed,
                                                    ),
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: item.viewed != 0
                                                      ? item.viewed.toString()
                                                      : "0",
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(width: 10.0),
                                          Text(
                                            NumberFormat.currency(
                                              locale: "uz-UZ",
                                              symbol: item.valyutaShort,
                                              decimalDigits: 0,
                                            ).format(item.price),
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge,
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
                                  childAspectRatio: 1.5,
                                  crossAxisSpacing: 2.0,
                                  mainAxisSpacing: 0,
                                ),
                                children: carTag(item),
                              ),
                            ),
                            TextButton(
                              style: const ButtonStyle(
                                alignment: Alignment.center,
                                padding: WidgetStatePropertyAll(
                                  EdgeInsets.all(0),
                                ),
                              ),
                              onPressed: () {
                                Navigator.of(context).pushNamed(
                                  RouteName.creditScreen,
                                  arguments: {
                                    "listingId": item.id,
                                    "price": item.price,
                                    "currency": item.valyutaShort
                                  },
                                );
                              },
                              child: Text(
                                S.of(context).kreditKalkulatori,
                                style:
                                    Theme.of(context).textTheme.displayMedium,
                                // textDirection: TextDecoration(),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              );
            },
          );
        case ListingStatus.initial:
          return Center(
              child: CircularProgressIndicator(
            color: colorEmber,
          ));
      }
    });

    // if (state is ListingStateLoading) {
    //   return const Center(
    //     child: CircularProgressIndicator(),
    //   );
    // }
    // if (state is ListingStateNoData) {
    //   return Center(
    //     child: Text(S.of(context).malumotlatYuklanishidaXatolik),
    //   );
    // }
    // if (state is ListingStateError) {
    //   return Center(
    //     child: Text(S.of(context).malumotlarBazasidaXatolik),
    //   );
    // }
  }

  List<Widget> carTag(ListingGetModels item) {
    return [
      cardTagCard(
        "${item.year} yil",
        Icon(
          Icons.calendar_month,
          size: 17.0,
          color: colorEmber,
        ),
      ),
      cardTagCard(
        item.transmission,
        Icon(
          Symbols.auto_transmission,
          size: 17.0,
          color: colorEmber,
        ),
      ),
      cardTagCard(
        item.type_of_fuel,
        Icon(
          Symbols.gas_meter_sharp,
          size: 17.0,
          color: colorEmber,
        ),
      ),
      cardTagCard(
        '${item.mileage.toString()} km',
        Icon(
          Symbols.speed,
          size: 17.0,
          color: colorEmber,
        ),
      ),
    ];
  }
}
