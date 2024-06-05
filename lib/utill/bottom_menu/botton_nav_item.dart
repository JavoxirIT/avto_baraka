import 'package:avto_baraka/generated/l10n.dart';
import 'package:avto_baraka/utill/bottom_menu/bottom_nav_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

BottomNavigationBar bottomNavItem(
    onItemTapped, int selectedIndex, double size, BuildContext context) {
  return BottomNavigationBar(
    items: [
      bottomNavigationBarItem(
        Icon(FontAwesomeIcons.bullseye, size: size),
        S.of(context).elonlar,
      ),
      bottomNavigationBarItem(
        Icon(
          FontAwesomeIcons.heartCircleCheck,
          size: size,
        ),
        S.of(context).tanlanganlar,
      ),
      bottomNavigationBarItem(const Text(""), ""),
      // chat
      bottomNavigationBarItem(
        Badge(
          // label: const Text('0'),
          child: Icon(Icons.messenger_sharp, size: size),
        ),
        S.of(context).suhbatlar,
      ),
      bottomNavigationBarItem(
        Icon(Icons.airplay_rounded, size: size),
        S.of(context).kabinet,
      ),
    ],
    currentIndex: selectedIndex,
    showUnselectedLabels: true,
    type: BottomNavigationBarType.fixed,
    onTap: onItemTapped,
  );
}
