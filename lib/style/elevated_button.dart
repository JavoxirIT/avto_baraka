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
  shadowColor: const Color.fromARGB(255, 161, 161, 161),
  elevation: 7.0,
);
