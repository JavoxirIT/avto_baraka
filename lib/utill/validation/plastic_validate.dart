import 'package:avto_baraka/generated/l10n.dart';
import 'package:flutter/material.dart';

String? plastikValidate(BuildContext context, String input) {
  // Регулярное выражение для проверки номера пластиковой карты (16 цифр)
  final cardNumberExp = RegExp(r'^\d{16}$');

  if (input.isEmpty) {
    return S.of(context).maydinniToldiring;
  } else if (cardNumberExp.hasMatch(input.replaceAll(" ", ""))) {
    return null;
  } else {
    return S.of(context).kartaRaqaminiToliqKiriting;
  }
}
