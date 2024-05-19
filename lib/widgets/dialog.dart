import 'package:flutter/material.dart';

Future<void> dialogBuilder(
    BuildContext context, title, Widget content, List<Widget> widgets) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          title,
          style: Theme.of(context).textTheme.labelLarge,
        ),
        content: content,
        actions: widgets,
      );
    },
  );
}
