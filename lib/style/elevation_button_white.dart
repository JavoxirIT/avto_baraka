import 'package:avto_baraka/style/colors.dart';
import 'package:flutter/material.dart';

final ButtonStyle elevationButtonWhite = ElevatedButton.styleFrom(
  // foregroundColor: const Color.fromARGB(255, 255, 255, 255),
  backgroundColor: textColorWhite,
  minimumSize: const Size(88, 36),
  padding: const EdgeInsets.symmetric(horizontal: 16),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(5),
    ),
  ),
  textStyle: TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.w400,
    fontFamily: "Roboto",
    color: iconSelectedColor,
  ),
  shadowColor: const Color.fromARGB(255, 161, 161, 161),
  elevation: 7.0,
);
