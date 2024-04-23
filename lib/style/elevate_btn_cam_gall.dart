import 'package:flutter/material.dart';

ButtonStyle elevatedBtnCamGall({required Color backgrounColor}) =>
    ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: backgrounColor,
        // minimumSize: const Size(88, 100),

        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        textStyle: const TextStyle(
          fontSize: 11.0,
          fontWeight: FontWeight.w700,
          fontFamily: "Roboto",
        ),
        // shadowColor: const Color.fromARGB(255, 251, 189, 4),
        // side: const BorderSide(
        //   color: Color.fromARGB(255, 251, 189, 4),
        // ),
        elevation: 0);
