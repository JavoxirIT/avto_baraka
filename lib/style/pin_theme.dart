import 'package:avto_baraka/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

final pinTheme = PinTheme(
  width: 45,
  height: 45,
  textStyle: const TextStyle(
    fontSize: 22,
    color: Color.fromRGBO(30, 60, 87, 1),
  ),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(10),
    border: Border.all(color: borderColor),
  ),
);
