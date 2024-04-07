import 'package:avto_baraka/widgets/bottom_nav_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

const double _size = 18.0;
List<BottomNavigationBarItem> listBottomBar = [
  bottomNavigationBarItem(
      const Icon(FontAwesomeIcons.bullseye, size: _size), 'E’lonlar'),
  bottomNavigationBarItem(
      const Icon(FontAwesomeIcons.heartCircleCheck, size: _size),
      'Tanlanganlar'),
  bottomNavigationBarItem(const Text(""), ""),
  bottomNavigationBarItem(
      const Badge(
        label: Text('2'),
        child: Icon(Icons.messenger_sharp, size: _size),
      ),
      'Suhbatlar'),
  bottomNavigationBarItem(
      const Icon(Icons.airplay_rounded, size: _size), 'Kabinet'),
];
