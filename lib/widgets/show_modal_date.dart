import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<void> showCupModalPopup(Widget child, BuildContext context) {
  return showCupertinoModalPopup(
    context: context,
    builder: (BuildContext context) => Container(
      // height: 350,
      // padding: const EdgeInsets.only(top: 6.0),
      // margin: EdgeInsets.only(
      //   bottom: MediaQuery.of(context).viewInsets.bottom,
      // ),
      color: CupertinoColors.systemBackground.resolveFrom(context),
      // Use a SafeArea widget to avoid system overlaps.

      height: MediaQuery.of(context).size.height / 3,
      child: CupertinoTheme(
        data: const CupertinoThemeData(
          textTheme: CupertinoTextThemeData(
            dateTimePickerTextStyle:
                TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontSize: 22.0),
          ),
          // brightness: Brightness.dark
          barBackgroundColor: Colors.amber,
        ),
        child: child,
      ),
    ),
  );
}
