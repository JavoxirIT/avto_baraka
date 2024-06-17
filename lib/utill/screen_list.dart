import 'package:avto_baraka/router/route_impoer.dart';
import 'package:avto_baraka/screen/listing_screen.dart';
import 'package:flutter/material.dart';

const List<Widget> screenList = <Widget>[
  ListingScreen(),
  FavoriteScreen(),
  Announcement(),
  ChatScreen(),
  CobinetScreen()
];
