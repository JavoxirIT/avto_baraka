import 'package:flutter/material.dart';

final ButtonStyle oneCaroutlineButton = OutlinedButton.styleFrom(
    backgroundColor: const Color.fromARGB(22, 0, 26, 171),
    // minimumSize: const Size(88, 36),
    padding: const EdgeInsets.symmetric(horizontal: 16),
    // shape: const RoundedRectangleBorder(
    //   borderRadius: BorderRadius.all(
    //     Radius.circular(10),
    //   ),
    // ),
    textStyle: const TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.w700,
      fontFamily: "Roboto",
    ),
    // shadowColor: const Color.fromARGB(255, 251, 189, 4),
    side: const BorderSide(
      color: Color.fromARGB(22, 0, 26, 171),
    ),
    elevation: 7.0);
