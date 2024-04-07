import 'package:flutter/material.dart';

SizedBox onaCardDataTitle(context, title) {
  return SizedBox(
    width: MediaQuery.of(context).size.width,
    child: Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 12.0, fontWeight: FontWeight.w700),
      ),
    ),
  );
}
