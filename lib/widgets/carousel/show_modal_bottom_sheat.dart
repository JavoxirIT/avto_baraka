import 'package:flutter/material.dart';

showModalBottom(context, widgets) {
  return showModalBottomSheet(
    context: context,
    builder: (_) {
      return SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 190.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: widgets,
        ),
      );
    },
  );
}
