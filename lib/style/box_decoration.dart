import 'package:avto_baraka/style/colors.dart';
import 'package:flutter/material.dart';

BoxDecoration boxDecoration() {
  return BoxDecoration(
    borderRadius: BorderRadius.circular(15.0),
    border: Border.all(
      width: 1.0,
      color: backgrounColorWhite,
    ),
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.3),
        spreadRadius: 2,
        blurRadius: 5,
        offset: const Offset(0, 2),
      ),
    ],
  );
}
