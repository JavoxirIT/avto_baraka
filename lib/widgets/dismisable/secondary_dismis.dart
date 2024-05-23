import 'package:avto_baraka/generated/l10n.dart';
import 'package:avto_baraka/style/colors.dart';
import 'package:flutter/material.dart';

Container secondaryDismiss(context) {
  return Container(
    color: iconSelectedColor,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        const Padding(
          padding: EdgeInsets.only(right: 5.0),
          child: Center(
              child: Icon(
            Icons.remove_red_eye,
            color: Colors.white,
          )),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: Center(
            child: Text(S.of(context).batafsilMalumot,
                style: Theme.of(context)
                    .textTheme
                    .displayLarge!
                    .copyWith(color: Colors.white)),
          ),
        ),
      ],
    ),
  );
}
