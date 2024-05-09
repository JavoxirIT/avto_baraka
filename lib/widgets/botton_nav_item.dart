import 'package:avto_baraka/generated/l10n.dart';
import 'package:avto_baraka/style/colors.dart';
import 'package:avto_baraka/widgets/bottom_nav_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

BottomNavigationBar bottomNavItem(
    onItemTapped, int selectedIndex, double size, BuildContext context) {
  return BottomNavigationBar(
    items: [
      bottomNavigationBarItem(
          Icon(FontAwesomeIcons.bullseye, size: size), S.of(context).elonlar),
      bottomNavigationBarItem(
          Icon(FontAwesomeIcons.heartCircleCheck, size: size), S.of(context).tanlanganlar),
      bottomNavigationBarItem(const Text(""), ""),
      bottomNavigationBarItem(
          Badge(
            label: Text('2'),
            child: Icon(Icons.messenger_sharp, size: size),
          ),
          S.of(context).suhbatlar),
      bottomNavigationBarItem(
          Icon(Icons.airplay_rounded, size: size), S.of(context).kabinet),
    ],
    currentIndex: selectedIndex,
    showUnselectedLabels: true,
    type: BottomNavigationBarType.fixed,
    onTap: onItemTapped,
  );
}
