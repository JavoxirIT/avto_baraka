import 'package:flutter/material.dart';

showModalBottom(context, height ,widgets) {
  return showModalBottomSheet(
    context: context,
    builder: (_) {
      return SizedBox(
        width: MediaQuery.of(context).size.width,
        height: height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: widgets,
        ),
      );
    },
  );
}
