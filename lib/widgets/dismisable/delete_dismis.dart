import 'package:avto_baraka/generated/l10n.dart';
import 'package:avto_baraka/style/colors.dart';
import 'package:flutter/material.dart';

Container deleteDismiss(context) {
  return Container(
    color: const Color.fromARGB(255, 221, 221, 221),
    child: Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Center(
              child: Icon(
            Icons.delete,
            color: iconSelectedColor,
          )),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Center(
            child: Text(
              S.of(context).royhatdanChiqarish,
              style: TextStyle(
                color: iconSelectedColor,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
