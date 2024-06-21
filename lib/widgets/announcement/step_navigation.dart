import 'package:avto_baraka/widgets/announcement/step_navigation_controller.dart';
import 'package:flutter/material.dart';

Widget stepsNavigation(
  context,
  currentStep,
  onStepCansel,
  onStepContinue,
  getSteps,
) {
  return SafeArea(
    child: Card(
      elevation: 0,
      margin: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0.0),
      ),
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 15.0),
        child: stepControls(
          context,
          currentStep,
          onStepCansel,
          onStepContinue,
          getSteps,
        ),
      ),
    ),
  );
}
