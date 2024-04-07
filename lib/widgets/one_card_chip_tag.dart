import 'package:flutter/material.dart';

Card oneCardChipTag(tag) {
  return Card(
    elevation: 0,
    color: const Color(0x6800C2AB),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 7.0, vertical: 3.0),
      child: Text(
        tag,
        style: const TextStyle(fontSize: 12.0),
      ),
    ),
  );
}
