// form_wizard_controller.dart
import 'package:flutter/material.dart';

import '../models/stepper.dart';

class MultiFormStepperController extends ChangeNotifier {
  int _currentStep = 0;
  List<FormStep> steps;

  MultiFormStepperController({required this.steps});

  int get currentStep => _currentStep;
  int get totalSteps => steps.length;
  bool get isFirstStep => _currentStep == 0;
  bool get isLastStep => _currentStep == steps.length - 1;
  double get progress => (_currentStep + 1) / steps.length;

  void goToStep(int step) {
    if (step >= 0 && step < steps.length) {
      _currentStep = step;
      notifyListeners();
    }
  }

  bool nextStep() {
    final currentFormKey = steps[_currentStep].formKey;
    if (currentFormKey.currentState?.validate() ?? false) {
      if (!isLastStep) {
        steps[_currentStep].isCompleted = true;
        _currentStep++;
        notifyListeners();
        return true;
      }
    }
    return false;
  }

  bool previousStep() {
    if (!isFirstStep) {
      _currentStep--;
      notifyListeners();
      return true;
    }
    return false;
  }

  void reset() {
    _currentStep = 0;
    for (var step in steps) {
      step.isCompleted = false;
    }
    notifyListeners();
  }
}
