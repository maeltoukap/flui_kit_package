// form_step.dart
import 'package:flutter/material.dart';

class FormStep {
  final String title;
  final Widget content;
  final GlobalKey<FormState> formKey;
  bool isCompleted;

  FormStep({
    required this.title,
    required this.content,
    required this.formKey,
    this.isCompleted = false,
  });
}
