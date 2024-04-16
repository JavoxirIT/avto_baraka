import 'package:flutter/material.dart';

final ButtonStyle locationButton = ElevatedButton.styleFrom(
  // foregroundColor: Colors.white,
  backgroundColor: const Color(0xFFF5E6FD),
  // minimumSize: const Size(88, 36),
  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(10),
    ),
  ),
  textStyle: const TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.w400,
      fontFamily: "Roboto",
      color: Colors.red),
  // shadowColor: const Color.fromARGB(255, 251, 189, 4),
  side: const BorderSide(
    color: Color(0xFFF5E6FD),
  ),
  // elevation: 7.0
);
