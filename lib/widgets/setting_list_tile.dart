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
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
        side: BorderSide(color: Colors.white12)),
    contentPadding: const EdgeInsets.symmetric(horizontal: 10.0),
  );
}
