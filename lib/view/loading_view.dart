import 'dart:async';

import 'package:avto_baraka/router/route_name.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoadingView extends StatefulWidget {
  const LoadingView({Key? key}) : super(key: key);

  @override
  State<LoadingView> createState() => _LoadingViewState();
}

class _LoadingViewState extends State<LoadingView>
    with TickerProviderStateMixin {
  final String img = "assets/loading/loading.png";
  String? token;
  @override
  initState() {
    getLocalData();

    Timer(const Duration(seconds: 3), () {
      setState(() {
        if (token == null) {
          Navigator.of(context).pushReplacementNamed(RouteName.introduction);
          return;
        }
        Navigator.of(context)
            .pushReplacementNamed(RouteName.bottomNavigationHomeScreen);
      });
    });
    super.initState();
  }

  Future<void> getLocalData() async {
    final prefs = await SharedPreferences.getInstance();
    final savedToken = prefs.getString("access_token");
    if (savedToken != null) {
      token = savedToken;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Image.asset(img);
  }
}
