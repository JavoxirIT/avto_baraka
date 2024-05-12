import 'package:flutter/material.dart';

Card cardTagCard(item, icon) {
  const TextStyle textStyle = TextStyle(fontSize: 10.0);
  return Card(
    elevation: 3.0,
    child: Center(
      child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          icon,
          Text(
            item,
            style: textStyle,
          ),
        ],
      ),
    ),
  );
}
