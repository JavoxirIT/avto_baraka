import 'package:avto_baraka/generated/l10n.dart';
import 'package:avto_baraka/style/colors.dart';
import 'package:flutter/material.dart';

Container deleteDismiss(context) {
  return Container(
    color: iconSelectedColor,
    child: Row(
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 10.0),
          child: Center(
              child: Icon(
            Icons.delete,
            color: Colors.white,
          )),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Center(
            child: Text(
              S.of(context).royhatdanChiqarish,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
