import 'package:avto_baraka/generated/l10n.dart';
import 'package:flutter/material.dart';

String? validityPeriod(BuildContext context, String input) {
  // Регулярное выражение для проверки формата MM/YY
  final cardExpiryExp = RegExp(r'^(0[1-9]|1[0-2])\/?([0-9]{2})$');

  if (input.isEmpty) {
    return S.of(context).maydinniToldiring;
  } else if (!cardExpiryExp.hasMatch(input)) {
    return S.of(context).kartaMuddatiniTogriKiriting;
  } else {
    // Проверка, что срок действия не истек
    final parts = input.split('/');
    final month = int.parse(parts[0]);
    final year = int.parse(
        '20${parts[1]}'); // Преобразование года из двух цифр в полный год
    final now = DateTime.now();
    final expiryDate = DateTime(year, month);

    if (expiryDate.isBefore(now) ||
        (expiryDate.year == now.year && expiryDate.month < now.month)) {
      return S.of(context).plastikKartaniMuddatiOtganmi;
    }

    return null;
  }
}
