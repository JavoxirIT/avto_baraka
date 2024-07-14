import 'dart:convert';

import 'package:avto_baraka/bloc/not_active/not_active_bloc.dart';
import 'package:avto_baraka/http_config/config.dart';
import 'package:avto_baraka/screen/imports/imports_listing.dart';
import 'package:avto_baraka/style/colors.dart';
import 'package:avto_baraka/style/elevation_button_white.dart';
import 'package:avto_baraka/widgets/car_card/car_tag_card.dart';
import 'package:avto_baraka/widgets/dialog.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../utill/bs_64_image.dart';

class CarNotActiv extends StatefulWidget {
  const CarNotActiv({
    Key? key,
    required this.token,
    required this.languageCode,
  }) : super(key: key);

  final String languageCode;
  final String? token;

  @override
  State<CarNotActiv> createState() => _CarNotActivState();
}

class _CarNotActivState extends State<CarNotActiv> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotActiveBloc, NotActiveState>(
        builder: (context, state) {
      if (state is NotActiveStateDeleteError) {
        WidgetsBinding.instance.addPostFrameCallback(
          (_) {
            if (mounted) {
              showDialog(
                context: context,
                builder: (_) {
                  return AlertDialog(
                    title: Text(
                      S.of(context).diqqat,
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    content: Text(
                      S.of(context).elonniOchirishdaXatolikYuzBerdi,
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
      if (state is NotActiveStateDeleteSuccess) {
        WidgetsBinding.instance.addPostFrameCallback(
          (_) {
            if (mounted) {
              showDialog(
                context: context,
                builder: (_) {
                  return AlertDialog(
                    title: Text(
                      S.of(context).diqqat,
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    content: Text(
                      S.of(context).elonniOchirildi,
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
      if (state is NotActiveStateActivitySuccess) {
        WidgetsBinding.instance.addPostFrameCallback(
          (_) {
            if (mounted) {
              showDialog(
                context: context,
                builder: (_) {
                  return AlertDialog(
                    title: Text(
                      S.of(context).diqqat,
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    content: Text(
                      S.of(context).elonQaytaAktivlandi,
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
      if (state is NotActiveStateActivityError) {
        WidgetsBinding.instance.addPostFrameCallback(
          (_) {
            if (mounted) {
              showDialog(
                context: context,
                builder: (_) {
                  return AlertDialog(
                    title: Text(
                      S.of(context).diqqat,
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    content: Text(
                      S.of(context).elonniAktivlashJarayonidaXatolikYuzBerdi,
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

      if (state is NotActiveLoad) {
        return ListView.builder(
          itemCount: state.list.length,
          itemBuilder: (context, i) {
            final item = state.list[i];
            final carTitle = "${item.brand} ${item.model} ${item.car_position}";
            return Stack(
              children: [
                Card(
                  margin: const EdgeInsets.only(bottom: 22.0),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: InkWell(
                      splashColor: splashColor,
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed(RouteName.oneCarView, arguments: item);
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
                                        // SizedBox(width: 1.0,),
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
                                                style: const TextStyle(
                                                    fontSize: 12.0,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Text(
                                          '${item.price.toString()} ${item.valyutaShort!.toUpperCase()}',
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
                              ],
                            ),
                          ),
                          ButtonBar(
                            alignment: MainAxisAlignment.end,
                            children: [
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
                                            BlocProvider.of<NotActiveBloc>(
                                                    context)
                                                .add(
                                              NotActiveEventDelete(
                                                listingId: item.id,
                                                token: widget.token!,
                                                lang: widget.languageCode,
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
                                  backgroundColor:
                                      MaterialStatePropertyAll(colorRed),
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
                              //
                              item.activeStatus != 1
                                  ? ElevatedButton(
                                      onPressed: () {
                                        BlocProvider.of<NotActiveBloc>(context)
                                            .add(
                                          NotActiveEventListingActivating(
                                            id: item.id,
                                            token: widget.token!,
                                            lang: widget.languageCode,
                                          ),
                                        );
                                        BlocProvider.of<ListingBloc>(context)
                                            .add(
                                          const ListingEventAddListing(),
                                        );
                                      },
                                      style: elevatedButton,
                                      child: Text(
                                        S.of(context).qaytaAktivlash,
                                        style: Theme.of(context)
                                            .textTheme
                                            .displayMedium,
                                      ),
                                    )
                                  : Text(
                                      S
                                          .of(context)
                                          .adminTasdiqlashiniKutilmoqda,
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    ),
                            ],
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
      }
      if (state is NotActiveStateNotData) {
        return Center(
          child: Text(
            S.of(context).faolBolmaganElonlarMavjutEmas('\n'),
            style: Theme.of(context).textTheme.labelLarge!.copyWith(color: colorWhite),
            textAlign: TextAlign.center,
          ),
        );
      }
      if (state is NotActiveStateError) {
        return Center(
          child: Text(S.of(context).malumotlarBazasidaXatolik),
        );
      }
      if (state is NotActiveStateLoading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      return const Center(
        child: CircularProgressIndicator(),
      );
    });
  }
}
