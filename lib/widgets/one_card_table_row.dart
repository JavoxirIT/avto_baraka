import 'package:flutter/material.dart';

TableRow tableRow(title, data) {
  return TableRow(
    children: [
      TableCell(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 5.0, left: 5.0),
          child: Text(
            title,
            style: const TextStyle(fontSize: 12.0),
          ),
        ),
      ),
      TableCell(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 5.0, right: 5.0),
          child: Text(
            data,
            textAlign: TextAlign.end,
            style: const TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      )
    ],
  );
}
