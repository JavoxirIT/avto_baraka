import 'package:flutter/material.dart';

CircleAvatar iconButton(icon, size, color, fnc, context, [arg]) {
  return CircleAvatar(
    backgroundColor: color,
    radius: size,
    child: IconButton(
      onPressed: () {
        if (arg != null) {
          fnc(arg[0], arg[1]);
        } else {
          fnc(context);
        }
      },
      icon: icon,
    ),
  );
}
