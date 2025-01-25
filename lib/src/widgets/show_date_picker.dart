import 'package:flutter/material.dart';
import '/src/widgets/date_picker/date_picker_exports.dart';

import 'date_picker/date_picker.dart';

/// Displays a single date picker in a dialog box.
///
/// [context] The required BuildContext to show the dialog.
/// [controller] Optional controller to manage the date picker state.
/// [closeOnSelection] If true, closes the dialog after date selection.
/// [dateFormatter] Custom function to format the display of dates.
/// [allowDeselection] If true, allows deselecting a date.
/// [header] Optional widget to display at the top of the calendar.
/// [footer] Optional widget to display at the bottom of the calendar.
/// [calendarDecoration] Custom decoration for the calendar.
/// [showOutsideDays] If true, shows days from previous/next months.
/// [initialMonth] Initial month to display.
/// [monthYearFormatter] Custom function to format month/year display.
/// [weekdayLabels] Custom list of weekday labels.
/// [showWeekNumbers] If true, displays week numbers.
/// [weekStartsOn] Starting day of the week (default: Monday).
/// [numberOfMonths] Number of months to display simultaneously.
/// [minDate] Minimum selectable date.
/// [maxDate] Maximum selectable date.
/// [initialDate] Initially selected date.
/// [selectableDayPredicate] Function to determine which days are selectable.
/// [hideNavigation] If true, hides navigation buttons.
/// [theme] Custom theme for the calendar.
/// [onChange] Callback called when a date is selected.
/// [dialogPadding] Custom padding for the dialog.

Future<void> showSingleDatePicker({
  required BuildContext context,
  // DatePickerController? controller,
  bool closeOnSelection = true,
  final String Function(DateTime)? dateFormatter,
  bool allowDeselection = true,
  Widget? header,
  Widget? footer,
  BoxDecoration? calendarDecoration,
  bool showOutsideDays = true,
  DateTime? initialMonth,
  final String Function(DateTime)? monthYearFormatter,
  List<String>? weekdayLabels,
  bool showWeekNumbers = false,
  int weekStartsOn = DateTime.monday,
  int numberOfMonths = 1,
  DateTime? minDate,
  DateTime? maxDate,
  DateTime? initialDate,
  SelectableDayPredicate? selectableDayPredicate,
  bool hideNavigation = false,
  DatePickerThemeCustom? theme,
  required ValueChanged<DateTime> onChange,
  EdgeInsets? dialogPadding,
}) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
          key: ValueKey(initialDate),
          builder: (context, setStater) {
            return Dialog(
              child: Container(
                decoration: calendarDecoration,
                child: Padding(
                  padding: dialogPadding ?? const EdgeInsets.all(16.0),
                  child: DatePicker.single(
                    // controller: controller,
                    closeOnSelection: closeOnSelection,
                    dateFormatter: dateFormatter,
                    allowDeselection: allowDeselection,
                    header: header,
                    footer: footer,
                    calendarDecoration: calendarDecoration,
                    showOutsideDays: showOutsideDays,
                    initialMonth: initialMonth,
                    monthYearFormatter: monthYearFormatter,
                    weekdayLabels: weekdayLabels,
                    showWeekNumbers: showWeekNumbers,
                    weekStartsOn: weekStartsOn,
                    numberOfMonths: numberOfMonths,
                    minDate: minDate,
                    maxDate: maxDate,
                    selectableDayPredicate: selectableDayPredicate,
                    hideNavigation: hideNavigation,
                    theme: theme,
                    selectedDate: initialDate,
                    onChange: (date) {
                      setStater(() {
                        initialDate = date;
                      });
                      onChange(date!);
                      if (closeOnSelection) {
                        Navigator.of(context).pop(date);
                      }
                    },
                  ),
                ),
              ),
            );
          });
    },
  );
}

/// Displays a date range picker in a dialog box.
///
/// [context] The required BuildContext to show the dialog.
/// [controller] Optional controller to manage the date picker state.
/// [closeOnSelection] If true, closes the dialog after range selection.
/// [dateFormatter] Custom function to format the display of dates.
/// [allowDeselection] If true, allows deselecting a range.
/// [header] Optional widget to display at the top of the calendar.
/// [footer] Optional widget to display at the bottom of the calendar.
/// [calendarDecoration] Custom decoration for the calendar.
/// [showOutsideDays] If true, shows days from previous/next months.
/// [initialMonth] Initial month to display.
/// [monthYearFormatter] Custom function to format month/year display.
/// [weekdayLabels] Custom list of weekday labels.
/// [showWeekNumbers] If true, displays week numbers.
/// [weekStartsOn] Starting day of the week (default: Monday).
/// [numberOfMonths] Number of months to display simultaneously.
/// [minDate] Minimum selectable date.
/// [maxDate] Maximum selectable date.
/// [initialRange] Initially selected date range.
/// [selectableDayPredicate] Function to determine which days are selectable.
/// [hideNavigation] If true, hides navigation buttons.
/// [theme] Custom theme for the calendar.
/// [onRangeChange] Callback called when a range is selected.
/// [dialogPadding] Custom padding for the dialog.

Future<void> showRangeDatePicker({
  required BuildContext context,
  // DatePickerController? controller,
  bool closeOnSelection = true,
  final String Function(DateTime)? dateFormatter,
  bool allowDeselection = true,
  Widget? header,
  Widget? footer,
  BoxDecoration? calendarDecoration,
  bool showOutsideDays = true,
  DateTime? initialMonth,
  final String Function(DateTime)? monthYearFormatter,
  List<String>? weekdayLabels,
  bool showWeekNumbers = false,
  int weekStartsOn = DateTime.monday,
  int numberOfMonths = 1,
  DateTime? minDate,
  DateTime? maxDate,
  DateRange? initialRange,
  SelectableDayPredicate? selectableDayPredicate,
  bool hideNavigation = false,
  DatePickerThemeCustom? theme,
  required ValueChanged<DateRange> onRangeChange,
  EdgeInsets? dialogPadding,
}) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
          key: ValueKey(initialRange),
          builder: (context, setState) {
            return Dialog(
              child: Container(
                decoration: calendarDecoration,
                child: Padding(
                  padding: dialogPadding ?? const EdgeInsets.all(16.0),
                  child: DatePicker.range(
                    // controller: controller,
                    closeOnSelection: closeOnSelection,
                    dateFormatter: dateFormatter,
                    allowDeselection: allowDeselection,
                    header: header,
                    footer: footer,
                    calendarDecoration: calendarDecoration,
                    showOutsideDays: showOutsideDays,
                    initialMonth: initialMonth,
                    monthYearFormatter: monthYearFormatter,
                    weekdayLabels: weekdayLabels,
                    showWeekNumbers: showWeekNumbers,
                    weekStartsOn: weekStartsOn,
                    numberOfMonths: numberOfMonths,
                    minDate: minDate,
                    maxDate: maxDate,
                    selectableDayPredicate: selectableDayPredicate,
                    hideNavigation: hideNavigation,
                    theme: theme,
                    selectedRange: initialRange,
                    onRangeChange: (range) {
                      setState(() {
                        initialRange = range;
                      });
                      onRangeChange(range!);
                      if (closeOnSelection) {
                        Navigator.of(context).pop();
                      }
                    },
                  ),
                ),
              ),
            );
          });
    },
  );
}
