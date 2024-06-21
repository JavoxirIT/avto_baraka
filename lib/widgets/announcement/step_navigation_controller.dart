import 'package:avto_baraka/generated/l10n.dart';
import 'package:avto_baraka/style/colors.dart';
import 'package:avto_baraka/style/elevated_button.dart';
import 'package:avto_baraka/style/elevation_button_white.dart';
import 'package:flutter/material.dart';

Row stepControls(context, currentStep, onStepCansel, onStepContinue, getSteps) {
  TextStyle textStyle = TextStyle(
      fontSize: 16.0, fontWeight: FontWeight.w600, color: colorEmber);
  TextStyle textStyle2 = const TextStyle(
      fontSize: 16.0, fontWeight: FontWeight.w600, color: Colors.white);
  final isLastStep = currentStep == getSteps(context).length - 1;

  return Row(
    children: [
      if (currentStep != 0)
        Expanded(
          child: ElevatedButton(
            style: elevationButtonWhite,
            onPressed: onStepCansel,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.arrow_back_ios,
                  color: colorEmber,
                ),
                Text(
                  S.of(context).orqaga,
                  style: textStyle,
                )
              ],
            ),
          ),
        ),
      const SizedBox(
        width: 12.0,
      ),
      Expanded(
        child: ElevatedButton(
          style: elevatedButton.copyWith(
              backgroundColor: MaterialStatePropertyAll(colorEmber)),
          onPressed: onStepContinue,
          child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  isLastStep ? S.of(context).saqlash : S.of(context).oldinga,
                  style: textStyle2,
                ),
                !isLastStep
                    ? const Icon(Icons.arrow_forward_ios_outlined)
                    : const SizedBox()
              ]),
        ),
      ),
    ],
  );
}
