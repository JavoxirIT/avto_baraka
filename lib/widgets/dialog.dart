import 'package:avto_baraka/screen/imports/imports_announcement.dart';
import 'package:flutter/material.dart';

dialogBuilder(
    BuildContext context, title, [Widget? content, List<Widget>? widgets]) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          title,
          style: Theme.of(context).textTheme.labelLarge!.copyWith(color: colorWhite),
        ),
        content: content,
        actions: widgets,
      );
    },
  );
}
