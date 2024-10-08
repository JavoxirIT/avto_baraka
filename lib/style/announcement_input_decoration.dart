import 'package:avto_baraka/style/outline_input_border.dart';
import 'package:flutter/material.dart' hide CarouselController;

InputDecoration announcementInputDecoration([label]) {
  return InputDecoration(
      focusedBorder: formInputBorder,
      enabledBorder: formInputBorder,
      floatingLabelBehavior: FloatingLabelBehavior.always,
      label: Text(label ?? ""),
      counterText: '');
}
