import 'package:avto_baraka/widgets/announcement/step_navigation_controller.dart';
import 'package:flutter/material.dart';

Card stepsNavigation(
    context, currentStep, onStepCansel, onStepContinue, region, district, getSteps) {
  return Card(
    elevation: 5,
    margin: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(0.0),
    ),
    color: Colors.white,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 7.0),
      child: stepControls(
          context, currentStep, onStepCansel, onStepContinue, region, district, getSteps),
    ),
  );
}
