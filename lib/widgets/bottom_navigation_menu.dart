import 'dart:async';
import 'dart:developer' as developer;
import 'package:avto_baraka/router/route_name.dart';
import 'package:avto_baraka/screen/chat_screen.dart';
import 'package:avto_baraka/screen/cobinet_screen.dart';
import 'package:avto_baraka/screen/favorit_screen.dart';
import 'package:avto_baraka/screen/main_screen.dart';
import 'package:avto_baraka/view/checking_internet_connection.dart';
import 'package:avto_baraka/style/colors.dart';
import 'package:avto_baraka/widgets/botton_nav_item.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BottomNavigationMenu extends StatefulWidget {
  const BottomNavigationMenu({super.key});

  @override
  State<BottomNavigationMenu> createState() => _BottomNavigationMenuState();
}

class _BottomNavigationMenuState extends State<BottomNavigationMenu> {
  List<ConnectivityResult> _connectionStatus = [ConnectivityResult.none];
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    initConnectivity();

    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initConnectivity() async {
    late List<ConnectivityResult> result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      developer.log('Couldn\'t check connectivity status', error: e);
      return;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(List<ConnectivityResult> result) async {
    setState(() {
      _connectionStatus = result;
    });
    // ignore: avoid_print
    print('Connectivity changed: $_connectionStatus');
  }

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

  final bool payStatus = false;

  @override
  Widget build(BuildContext context) {
    const double _size = 18.0;
    if (_connectionStatus.toString() == [ConnectivityResult.none].toString()) {
      return const CheckingInternetConnection(title: "Title");
    }
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
            if (!payStatus) {
              Navigator.of(context).pushNamed(RouteName.firstpayView);
              return;
            }
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
      bottomNavigationBar:
          bottomNavItem(_onItemTapped, _selectedIndex, _size, context),
    );
  }
}
