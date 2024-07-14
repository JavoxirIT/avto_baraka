import 'dart:convert';

import 'package:avto_baraka/bloc/listing_active/listing_active_bloc.dart';
import 'package:avto_baraka/http_config/config.dart';
import 'package:avto_baraka/screen/imports/imports_listing.dart';
import 'package:avto_baraka/style/colors.dart';
import 'package:avto_baraka/style/elevation_button_white.dart';
import 'package:avto_baraka/utill/bs_64_image.dart';
import 'package:avto_baraka/widgets/car_card/car_tag_card.dart';
import 'package:avto_baraka/widgets/dialog.dart';
import 'package:intl/intl.dart';
import 'package:material_symbols_icons/symbols.dart';

class CarActiveCard extends StatelessWidget {
  const CarActiveCard({
    Key? key,
    required this.token,
    required this.lang,
  }) : super(key: key);

  final String token;
  final String lang;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ListingActiveBloc, ListingActiveState>(
        builder: (context, state) {
      if (state is ListingActiveStateLoad) {
        return ListView.builder(
          itemCount: state.listing.length,
          itemBuilder: (context, i) {
            final item = state.listing[i];
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
                                bottom: 0,
                                right: 0,
                                child: Card(
                                  color: cardBlackColor,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0, vertical: 3.0),
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
                                            symbol: item.valyutaShort!
                                                .toUpperCase(),
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
                                  Navigator.of(context).pushNamed(
                                      RouteName.ratesView,
                                      arguments: {"listingId": item.id});
                                },
                                style: elevatedButton,
                                child: Text(
                                  S.of(context).topgaChiqarish,
                                  style:
                                      Theme.of(context).textTheme.displayMedium,
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
                                          BlocProvider.of<ListingActiveBloc>(
                                                  context)
                                              .add(
                                            ListingActiveDeleteEvent(
                                              listingId: item.id,
                                              token: token,
                                              lang: lang,
                                            ),
                                          );
                                          BlocProvider.of<ListingBloc>(context)
                                              .add(
                                                  const ListingEventAddListing());
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
                                    ],
                                  );
                                },
                                style: elevatedButton.copyWith(
                                  backgroundColor:
                                      MaterialStatePropertyAll(colorRed),
                                ),
                                child: Text(
                                  S.of(context).ochirish,
                                  style:
                                      Theme.of(context).textTheme.displayMedium,
                                ),
                              )
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
      if (state is ListingActiveNotData) {
        return Center(
          child: Text(
            S.of(context).tasdiqlanganElonlarMavjutEmas,
            style: Theme.of(context)
                .textTheme
                .labelLarge!
                .copyWith(color: colorWhite),
          ),
        );
      }
      if (state is ListingActiveStateError) {
        return Center(
          child: Text(S.of(context).malumotlarBazasidaXatolik),
        );
      }
      if (state is ListingActiveInitial) {
        const Center(
          child: CircularProgressIndicator(),
        );
      }

      return const Center(
        child: CircularProgressIndicator(),
      );
    });
  }
}
