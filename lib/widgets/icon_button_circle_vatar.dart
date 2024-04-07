import 'package:flutter/material.dart';

CircleAvatar iconButton(icon, size, color, fnc, context) {
  return CircleAvatar(
    backgroundColor: color,
    radius: size,
    child: IconButton(
      onPressed: () {
        fnc(context);
      },
      icon: icon,
    ),
  );
}
