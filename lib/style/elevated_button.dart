import 'package:flutter/material.dart';

final ButtonStyle elevatedButton = ElevatedButton.styleFrom(
  foregroundColor: Colors.white,
  backgroundColor: const Color(0xFF008080),
  minimumSize: const Size(88, 36),
  padding: const EdgeInsets.symmetric(horizontal: 16),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(5),
    ),
  ),
  textStyle: const TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.w400,
    fontFamily: "Roboto",
  ),
  // shadowColor: const Color.fromARGB(255, 251, 189, 4),
  // side: const BorderSide(
  //   color: Color.fromARGB(255, 251, 189, 4),
  // ),
  // elevation: 7.0
);
