import 'package:flutter/material.dart';

final ButtonStyle elevatedButtonMap = ElevatedButton.styleFrom(
  foregroundColor: Colors.white,
  backgroundColor: const Color(0xFF008080),
  // minimumSize: const Size(88, 100),
  
  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(10),
    ),
  ),
  // textStyle: const TextStyle(
  //   fontSize: 14.0,
  //   fontWeight: FontWeight.w400,
  //   fontFamily: "Roboto",
  // ),
  // shadowColor: const Color.fromARGB(255, 251, 189, 4),
  // side: const BorderSide(
  //   color: Color.fromARGB(255, 251, 189, 4),
  // ),
  // elevation: 7.0
);
