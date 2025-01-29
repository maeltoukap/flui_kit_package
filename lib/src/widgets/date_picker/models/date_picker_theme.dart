import 'package:flutter/material.dart';

/// Theme configuration for the DatePicker widget
class DatePickerThemeCustom {
  /// Size of each day cell
  final double? daySize;

  /// Background color for selected days
  final Color? selectedDayColor;

  /// Background color for today's date
  final Color? todayColor;

  /// Text style for regular days
  final TextStyle? dayTextStyle;

  /// Text style for selected days
  final TextStyle? selectedDayTextStyle;

  /// Text style for weekday headers
  final TextStyle? weekdayTextStyle;

  /// Text style for month/year display
  final TextStyle? monthTextStyle;

  /// Padding for the calendar
  final EdgeInsets? padding;

  /// Creates a new DatePickerThemeCustom instance
  const DatePickerThemeCustom({
    this.daySize,
    this.selectedDayColor,
    this.todayColor,
    this.dayTextStyle,
    this.selectedDayTextStyle,
    this.weekdayTextStyle,
    this.monthTextStyle,
    this.padding,
  });

  /// Creates a copy of this DatePickerThemeCustom with the given fields replaced
  DatePickerThemeCustom copyWith({
    double? daySize,
    Color? selectedDayColor,
    Color? todayColor,
    TextStyle? dayTextStyle,
    TextStyle? selectedDayTextStyle,
    TextStyle? weekdayTextStyle,
    TextStyle? monthTextStyle,
    EdgeInsets? padding,
  }) {
    return DatePickerThemeCustom(
      daySize: daySize ?? this.daySize,
      selectedDayColor: selectedDayColor ?? this.selectedDayColor,
      todayColor: todayColor ?? this.todayColor,
      dayTextStyle: dayTextStyle ?? this.dayTextStyle,
      selectedDayTextStyle: selectedDayTextStyle ?? this.selectedDayTextStyle,
      weekdayTextStyle: weekdayTextStyle ?? this.weekdayTextStyle,
      monthTextStyle: monthTextStyle ?? this.monthTextStyle,
      padding: padding ?? this.padding,
    );
  }
}
