import 'package:avto_baraka/router/route_name.dart';
import 'package:avto_baraka/screen/chat_screen.dart';
import 'package:avto_baraka/screen/cobinet_screen.dart';
import 'package:avto_baraka/screen/favorit_screen.dart';
import 'package:avto_baraka/screen/main_screen.dart';
import 'package:avto_baraka/style/colors.dart';
import 'package:avto_baraka/widgets/botton_nav_bar_list.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BottomNavigationMenu extends StatefulWidget {
  const BottomNavigationMenu({super.key});

  @override
  State<BottomNavigationMenu> createState() => _BottomNavigationMenuState();
}

class _BottomNavigationMenuState extends State<BottomNavigationMenu> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    MainScreen(),
    FavoritScreen(),
    SizedBox(),
    ChatScreen(),
    CobinetScreen()
  ];

  void _onItemTapped(int index) {
    if (index == 2) {
      return;
    }
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        margin: const EdgeInsets.only(top: 12, left: 10, right: 10),
        height: 65.0,
        width: 65.0,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pushNamed(RouteName.announcement);
          },
          backgroundColor: iconSelectedColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: 3.0,
              color: iconSelectedColor,
            ),
            borderRadius: BorderRadius.circular(100.0),
          ),
          child: const Icon(FontAwesomeIcons.plus,
              color: Colors.white, size: 34.0),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: listBottomBar,
        currentIndex: _selectedIndex,
        selectedItemColor: iconSelectedColor,
        unselectedItemColor: unselectedItemColor,
        unselectedLabelStyle: TextStyle(
          color: unselectedItemColor,
        ),
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        onTap: _onItemTapped,
      ),
    );
  }
}
