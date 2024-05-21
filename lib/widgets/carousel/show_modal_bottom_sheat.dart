import 'package:flutter/material.dart';

showModalBottom(context, height, List<Widget> widgets, bool isScrollControlled,
    bool showDragHandle) {
  return showModalBottomSheet(
    isScrollControlled: isScrollControlled,
    showDragHandle: showDragHandle,
    context: context,
    builder: (_) {
      return Container(
        padding:
            const EdgeInsets.only(top: 0, left: 15.0, right: 15.0, bottom: 15.0),
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
