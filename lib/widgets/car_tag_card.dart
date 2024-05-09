import 'package:flutter/material.dart';

Card cardTagCard(item, icon) {
  const TextStyle textStyle = TextStyle(fontSize: 12.0);
  return Card(
  elevation: 3.0,
  
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 7.0),
      child: Column(
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
