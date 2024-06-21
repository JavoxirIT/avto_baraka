import 'package:avto_baraka/style/colors.dart';
import 'package:flutter/material.dart';

SizedBox formStepsTitle(text, context) {
  TextStyle textStyle = TextStyle(
      fontSize: 14.0, fontWeight: FontWeight.w600, color: colorEmber);
  return SizedBox(
    width: MediaQuery.of(context).size.width,
    child: Text(
      text,
      style: textStyle,
    ),
  );
}
