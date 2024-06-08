import 'package:avto_baraka/router/route_impoer.dart';
import 'package:avto_baraka/screen/chat_screen.dart';
import 'package:avto_baraka/screen/cobinet_screen.dart';
import 'package:avto_baraka/screen/favorit_screen.dart';
import 'package:avto_baraka/screen/listing_screen.dart';
import 'package:flutter/material.dart';

const List<Widget> screenList = <Widget>[
  FirstPayFormView(),
  // ListingScreen(),
  FavoriteScreen(),
  SizedBox(),
  ChatScreen(),
  CobinetScreen()
];
