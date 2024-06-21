import 'package:avto_baraka/router/navigator_key.dart';
import 'package:avto_baraka/screen/introductory_screen.dart';
import 'package:flutter/material.dart';

void redirectToLogin() {
  navigatorKey.currentState?.pushReplacement(
    MaterialPageRoute(builder: (context) => const IntroductionScreen()),
  );
}
