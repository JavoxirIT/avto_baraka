import 'package:avto_baraka/style/colors.dart';
import 'package:flutter/material.dart';

ListTile settingListTile(String title, textTheme, fnc) {
  return ListTile(
    leading: Text(
      title,
      style: textTheme,
    ),
    onTap: () {
      fnc();
    },
    trailing: Icon(
      Icons.arrow_forward_ios,
      color: iconSelectedColor,
      size: 15.0,
    ),
    shape: Border(
      bottom: BorderSide(color: iconSelectedColor, width: 0.1),
    ),
    contentPadding: EdgeInsets.zero,
  );
}
