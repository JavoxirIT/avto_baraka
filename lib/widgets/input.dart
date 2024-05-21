// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:avto_baraka/style/outline_input_border.dart';
import 'package:flutter/material.dart';

TextFormField input(
  TextEditingController? _controller,
  TextInputType? _keyboardType,
  Function _validator,
  String _labelText,
) {
  return TextFormField(
    controller: _controller,
    keyboardType: _keyboardType,
    validator: (value) => _validator(value),
    decoration: InputDecoration(
      focusedBorder: formInputBorder,
      enabledBorder: formInputBorder,
      floatingLabelBehavior: FloatingLabelBehavior.always,
      label: Text(_labelText),
    ),
  );
}
