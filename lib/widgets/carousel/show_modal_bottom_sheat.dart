import 'package:flutter/material.dart';

showModalBottom(context, title, text) {
  return showModalBottomSheet(
    context: context,
    builder: (_) {
      return SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 190.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.labelLarge,
            ),
            Text(
              text,
              style: Theme.of(context).textTheme.bodyLarge,
            )
          ],
        ),
      );
    },
  );
}
