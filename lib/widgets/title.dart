import 'package:flutter/material.dart';

SizedBox title(context, title) {
  return SizedBox(
    width: MediaQuery.of(context).size.width,
    child: Padding(
      padding: const EdgeInsets.only(left: 4.0, top: 5.0),
      child: Text(
        title.toUpperCase(),
        style: const TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.w600,
        ),
        textAlign: TextAlign.left,
      ),
    ),
  );
}
