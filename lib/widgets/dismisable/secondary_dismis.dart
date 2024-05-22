import 'package:avto_baraka/generated/l10n.dart';
import 'package:flutter/material.dart';

Container secondaryDismiss(context) {
  return Container(
    color: const Color.fromARGB(255, 221, 221, 221),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        const Padding(
          padding: EdgeInsets.only(right: 5.0),
          child: Center(
              child: Icon(
            Icons.remove_red_eye,
            color: Color.fromARGB(255, 0, 0, 0),
          )),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: Center(
            child: Text(S.of(context).batafsilMalumot,
                style: Theme.of(context).textTheme.displayLarge),
          ),
        ),
      ],
    ),
  );
}
