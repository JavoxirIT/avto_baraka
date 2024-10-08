import 'dart:convert';

import 'package:avto_baraka/bloc/like/like_bloc.dart';
import 'package:avto_baraka/bloc/listing/listing_bloc.dart';
import 'package:avto_baraka/generated/l10n.dart';
import 'package:avto_baraka/http_config/config.dart';
import 'package:avto_baraka/router/route_name.dart';
import 'package:avto_baraka/style/colors.dart';
import 'package:avto_baraka/style/elevated_button.dart';
import 'package:avto_baraka/style/elevation_button_white.dart';
import 'package:avto_baraka/utill/bs_64_image.dart';
import 'package:avto_baraka/widgets/car_card/car_tag_card.dart';
import 'package:avto_baraka/widgets/dismisable/delete_dismis.dart';
import 'package:avto_baraka/widgets/dismisable/secondary_dismis.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:material_symbols_icons/symbols.dart';


class CarFavoriteCard extends StatelessWidget {
  const CarFavoriteCard({Key? key, required this.token, required this.lang, required this.state }):super(key: key);

  final String token;
  final String lang;
  final LikeStateData state;
  @override
  Widget build(BuildContext context) {
   return  ListView.builder(
     itemCount: state.listing.length,
     itemBuilder: (context, i) {
       final item = state.listing[i];
       final carTitle = "${item.brand} ${item.model} ${item.car_position}";
       return Stack(
         children: [
           InkWell(
             onTap: () {
               Navigator.of(context)
                   .pushNamed(RouteName.oneCarView, arguments: item);
             },
             child: Card(
               elevation: 0,
               borderOnForeground: true,
               surfaceTintColor: Colors.amber,
               margin: const EdgeInsets.only(bottom: 22.0),
               child: Dismissible(
                 key: Key(item.id.toString()),
                 confirmDismiss: (DismissDirection direction) async {
                   if (direction == DismissDirection.startToEnd) {
                     return await showDialog(
                       context: context,
                       builder: (BuildContext context) {
                         return AlertDialog(
                           title: Text(
                             S.of(context).diqqat,
                             style: Theme.of(context).textTheme.labelLarge,
                           ),
                           content: Text(S.of(context).ishonchingizKomilmi),
                           actions: <Widget>[
                             ElevatedButton(
                               style: elevatedButton,
                               onPressed: () {
                                 BlocProvider.of<ListingBloc>(context)
                                     .add(LikeEvendSend(
                                   id: item.id,
                                   token: token,
                                 ));

                                 BlocProvider.of<LikeBloc>(context).add(
                                   LikeEvendGet(lang, token),
                                 );
                                 Navigator.of(context).pop();
                               },
                               child: Text(S.of(context).ha),
                             ),
                             ElevatedButton(
                               style: elevationButtonWhite,
                               onPressed: () => Navigator.of(context).pop(false),
                               child: Text(
                                 S.of(context).yoq,
                               ),
                             ),
                           ],
                         );
                       },
                     );
                   } else if (direction == DismissDirection.endToStart) {
                     Navigator.of(context)
                         .pushNamed(RouteName.oneCarView, arguments: item);
                   }
                   return null;
                 },
                 background: deleteDismiss(context),
                 secondaryBackground: secondaryDismiss(context),
                 child: Container(
                   padding: const EdgeInsets.all(10.0),
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
                                 '${Config.imageUrl!}${item.carImage[0].substring(1)}',
                               ),
                             ),
                           ),
                           Positioned(
                             right: 5,
                             top: 5,
                             child: Container(
                               width: 40.0,
                               height: 40.0,
                               decoration: BoxDecoration(
                                 shape: BoxShape.circle,
                                 color: colorEmber,
                               ),
                               child: Center(
                                 child: IconButton(
                                   icon: Icon(
                                     FontAwesomeIcons.solidHeart,
                                     color: colorRed,
                                     size: 20.0,
                                   ),
                                   onPressed: () {
                                     BlocProvider.of<ListingBloc>(context)
                                         .add(LikeEvendSend(
                                       id: item.id,
                                       token: token,
                                     ));

                                     BlocProvider.of<LikeBloc>(context).add(
                                       LikeEvendGet(lang, token),
                                     );
                                   },
                                 ),
                               ),
                             ),
                           ),
                           Positioned(
                             bottom: 0,
                             right: 0,
                             // width: 192,
                             child: Card(
                               color: cardBlackColor.withOpacity(0.8),
                               child: Padding(
                                 padding: const EdgeInsets.only(
                                     left: 10.0,
                                     right: 10.0,
                                     top: 3.0,
                                     bottom: 3.0),
                                 child: Row(
                                   mainAxisAlignment:
                                   MainAxisAlignment.spaceBetween,
                                   children: [
                                     Text.rich(
                                       TextSpan(
                                         children: [
                                           WidgetSpan(
                                             child: Padding(
                                               padding: const EdgeInsets.only(
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
                                         symbol: item.valyutaShort!.toUpperCase(),
                                         decimalDigits: 0,
                                       ).format(item.price),
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
                       )
                     ],
                   ),
                 ),
               ),
             ),
           ),
         ],
       );
     },
   );
  }
}


