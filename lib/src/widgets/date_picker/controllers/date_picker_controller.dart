import 'package:flutter/material.dart';

/// Controller for managing DatePicker state externally
class DatePickerController {
  /// Callback function to toggle the date picker visibility
  VoidCallback? _toggleCallback;

  /// Sets the toggle callback
  void setToggleCallback(VoidCallback callback) {
    _toggleCallback = callback;
  }

  /// Toggles the date picker visibility
  void toggle() {
    _toggleCallback?.call();
  }
}
