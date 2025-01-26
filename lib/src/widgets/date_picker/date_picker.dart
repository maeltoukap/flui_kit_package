// ignore_for_file: unused_element

import 'package:flutter/material.dart';

import 'controllers/date_picker_controller.dart';
import 'models/date_picker_theme.dart';
import 'models/date_range.dart';
import 'utils.dart';

/// A customizable date picker widget that supports both single date
/// and date range selection
class DatePicker extends StatefulWidget {
  /// Private base constructor
  const DatePicker._({
    super.key,
    required this.type,
    // this.controller,
    this.selectedDate,
    this.maxSelectableRange,
    this.selectedRange,
    this.onChange,
    this.onRangeChange,
    this.closeOnSelection = true,
    this.dateFormatter,
    this.allowDeselection = true,
    this.header,
    this.footer,
    this.calendarDecoration,
    this.showOutsideDays = true,
    this.initialMonth,
    this.monthYearFormatter,
    this.weekdayLabels,
    this.showWeekNumbers = false,
    this.weekStartsOn = DateTime.monday,
    this.numberOfMonths = 1,
    this.minDate,
    this.maxDate,
    this.selectableDayPredicate,
    this.hideNavigation = false,
    this.theme,
  });

  /// Constructor for single date selection mode
  const DatePicker.single({
    super.key,
    // this.controller,
    this.closeOnSelection = true,
    this.dateFormatter,
    this.allowDeselection = true,
    this.header,
    this.footer,
    this.calendarDecoration,
    this.showOutsideDays = true,
    this.initialMonth,
    this.monthYearFormatter,
    this.weekdayLabels,
    this.showWeekNumbers = false,
    this.weekStartsOn = DateTime.monday,
    this.numberOfMonths = 1,
    this.minDate,
    this.maxDate,
    this.selectableDayPredicate,
    this.hideNavigation = false,
    this.theme,
    this.selectedDate,
    required this.onChange,
  })  : type = DatePickerType.single,
        selectedRange = null,
        maxSelectableRange = null,
        onRangeChange = null;

  /// Constructor for date range selection mode
  const DatePicker.range({
    super.key,
    // this.controller,
    this.closeOnSelection = true,
    this.dateFormatter,
    this.allowDeselection = true,
    this.header,
    this.footer,
    this.calendarDecoration,
    this.showOutsideDays = true,
    this.initialMonth,
    this.monthYearFormatter,
    this.weekdayLabels,
    this.showWeekNumbers = false,
    this.weekStartsOn = DateTime.monday,
    this.numberOfMonths = 1,
    this.minDate,
    this.maxDate,
    this.selectableDayPredicate,
    this.hideNavigation = false,
    this.theme,
    this.selectedRange,
    this.maxSelectableRange,
    required this.onRangeChange,
  })  : type = DatePickerType.range,
        selectedDate = null,
        onChange = null;

  /// The type of date selection (single or range)
  final DatePickerType type;

  /// Controller for managing the date picker externally
  // final DatePickerController? controller;

  /// Currently selected date (for single mode)
  final DateTime? selectedDate;

  /// Currently selected date range (for range mode)
  final DateRange? selectedRange;

  /// Maximum selectable range in days
  final int? maxSelectableRange;

  /// Callback when a date is selected in single mode
  final ValueChanged<DateTime?>? onChange;

  /// Callback when a date range is selected in range mode
  final ValueChanged<DateRange?>? onRangeChange;

  /// Whether to close the picker after a selection is made
  final bool closeOnSelection;

  /// Custom date formatter for displaying dates
  final String Function(DateTime)? dateFormatter;

  /// Whether to allow deselecting dates
  final bool allowDeselection;

  /// Custom header widget
  final Widget? header;

  /// Custom footer widget
  final Widget? footer;

  /// Decoration for the calendar container
  final BoxDecoration? calendarDecoration;

  /// Whether to show days from previous/next months
  final bool showOutsideDays;

  /// Initial month to display
  final DateTime? initialMonth;

  /// Custom month/year formatter
  final String Function(DateTime)? monthYearFormatter;

  /// Custom weekday formatter
  final List<String>? weekdayLabels;

  /// Whether to show week numbers
  final bool showWeekNumbers;

  /// First day of the week (Monday = 1, Sunday = 7)
  final int weekStartsOn;

  /// Number of months to display
  final int numberOfMonths;

  /// Minimum selectable date
  final DateTime? minDate;

  /// Maximum selectable date
  final DateTime? maxDate;

  /// Predicate to determine which days are selectable
  final bool Function(DateTime)? selectableDayPredicate;

  /// Whether to hide the navigation arrows
  final bool hideNavigation;

  /// Theme configuration for the date picker
  final DatePickerThemeCustom? theme;

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  /// Current visible month
  late DateTime _currentMonth;

  final DatePickerController controller = DatePickerController();

  /// Whether the picker is visible
  bool _isVisible = true;

  @override
  void initState() {
    super.initState();
    _currentMonth = widget.initialMonth ?? DateTime.now();
    controller.setToggleCallback(_toggle);
  }

  void _toggle() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  /// Handles date selection in single mode
  void _handleDateSelected(DateTime date) {
    if (widget.type != DatePickerType.single) return;

    final isDeselection =
        widget.selectedDate == date && widget.allowDeselection;
    widget.onChange?.call(isDeselection ? null : date);

    if (widget.closeOnSelection) {
      setState(() => _isVisible = false);
    }
  }

  /// Handles date selection in range mode
  void _handleRangeSelected(DateTime date) {
    if (widget.type != DatePickerType.range) return;

    final currentRange = widget.selectedRange;
    DateRange? newRange;

    if (currentRange == null || currentRange.end != null) {
      // Start new range
      newRange = DateRange(start: date);
    } else if (date.isBefore(currentRange.start)) {
      // Selected date is before start date, make it new start
      newRange = DateRange(start: date);
    } else {
      // Check if the selected range is within maxSelectableRange
      final daysDifference = date.difference(currentRange.start).inDays;

      if (widget.maxSelectableRange != null &&
          daysDifference >= widget.maxSelectableRange!) {
        // If exceeds max range, create new range starting from selected date
        newRange = DateRange(start: date);
      } else {
        // Complete the range
        newRange = DateRange(
          start: currentRange.start,
          end: date,
        );
      }
    }

    widget.onRangeChange?.call(newRange);

    if (widget.closeOnSelection && newRange.end != null) {
      setState(() => _isVisible = false);
    }
  }

  /// Navigates to the previous month
  void _previousMonth() {
    setState(() {
      _currentMonth = DateTime(
        _currentMonth.year,
        _currentMonth.month - 1,
        1,
      );
    });
  }

  /// Navigates to the next month
  void _nextMonth() {
    setState(() {
      _currentMonth = DateTime(
        _currentMonth.year,
        _currentMonth.month + 1,
        1,
      );
    });
  }

  /// Checks if a date is selectable
  bool _isDateSelectable(DateTime date) {
    if (widget.selectableDayPredicate != null &&
        !widget.selectableDayPredicate!(date)) {
      return false;
    }

    if (widget.minDate != null && date.isBefore(widget.minDate!)) {
      return false;
    }

    if (widget.maxDate != null && date.isAfter(widget.maxDate!)) {
      return false;
    }

    return true;
  }

  List<String> _reorderWeekdayLabels(List<String> labels, int weekStartsOn) {
    // No need to reorganize if starting with Monday (1) or Sunday (7/0)
    if (weekStartsOn == DateTime.monday) return labels;

    // Convert weekStartsOn from 1-7 format to 0-6
    int start = weekStartsOn == 7 ? 0 : weekStartsOn - 1;

    // Reorganize labels based on start day
    List<String> reorderedLabels = [...labels];
    for (int i = 0; i < labels.length; i++) {
      int newIndex = (i + start) % 7;
      reorderedLabels[i] = labels[newIndex];
    }

    return reorderedLabels;
  }

  /// Builds the weekday labels grid
  Widget _buildWeekdayLabels() {
    final labels = _reorderWeekdayLabels(
        widget.weekdayLabels ??
            ['Lun', 'Mar', 'Mer', 'Jeu', 'Ven', 'Sam', 'Dim'],
        widget.weekStartsOn);

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        mainAxisSpacing: 2,
        crossAxisSpacing: 2,
      ),
      itemCount: 7,
      itemBuilder: (context, index) {
        return Center(
          child: Text(
            labels[index],
            style: widget.theme?.weekdayTextStyle ??
                const TextStyle(fontWeight: FontWeight.bold),
          ),
        );
      },
    );
  }

  /// Default weekday formatter
  String _defaultWeekdayFormatter(int weekday) {
    const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return days[weekday];
  }

  @override
  Widget build(BuildContext context) {
    if (!_isVisible) return const SizedBox.shrink();

    return Container(
      decoration: widget.calendarDecoration,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.header != null) widget.header!,
          _buildCalendarHeader(),
          _buildWeekdayLabels(),
          _buildCalendarGrid(),
          if (widget.footer != null) widget.footer!,
        ],
      ),
    );
  }

  Widget _buildCalendarHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (!widget.hideNavigation)
          IconButton(
            icon: const Icon(Icons.chevron_left),
            onPressed: _previousMonth,
          ),
        Text(
          widget.monthYearFormatter?.call(_currentMonth) ??
              _defaultMonthYearFormatter(_currentMonth),
          style: widget.theme?.monthTextStyle,
        ),
        if (!widget.hideNavigation)
          IconButton(
            icon: const Icon(Icons.chevron_right),
            onPressed: _nextMonth,
          ),
      ],
    );
  }

  Widget _buildCalendarGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        mainAxisSpacing: 2,
        crossAxisSpacing: 2,
      ),
      itemCount: _getDaysInMonth(_currentMonth) + _getFirstDayOffset(),
      itemBuilder: (context, index) {
        if (index < _getFirstDayOffset()) {
          return const SizedBox();
        }

        final date = DateTime(
          _currentMonth.year,
          _currentMonth.month,
          index - _getFirstDayOffset() + 1,
        );

        return _DayCell(
          date: date,
          isSelected: _isDateSelected(date),
          isSelectable: _isDateSelectable(date),
          isInRange: _isDateInRange(date),
          isRangeStart: _isRangeStart(date),
          isRangeEnd: _isRangeEnd(date),
          onTap: _isDateSelectable(date)
              ? () => widget.type == DatePickerType.single
                  ? _handleDateSelected(date)
                  : _handleRangeSelected(date)
              : null,
          theme: widget.theme,
          dateFormatter: widget.dateFormatter,
        );
      },
    );
  }

  // Helper methods
  String _defaultMonthYearFormatter(DateTime date) {
    return '${_getMonthName(date.month)} ${date.year}';
  }

  bool _isDateSelected(DateTime date) {
    if (widget.type == DatePickerType.single) {
      return widget.selectedDate != null &&
          isSameDay(date, widget.selectedDate!);
    }
    return false;
  }

  bool _isDateInRange(DateTime date) {
    if (widget.type != DatePickerType.range || widget.selectedRange == null) {
      return false;
    }

    final range = widget.selectedRange!;
    if (range.end == null) return false;

    return date.isAfter(range.start) && date.isBefore(range.end!);
  }

  bool _isRangeStart(DateTime date) {
    return widget.type == DatePickerType.range &&
        widget.selectedRange != null &&
        isSameDay(date, widget.selectedRange!.start);
  }

  bool _isRangeEnd(DateTime date) {
    return widget.type == DatePickerType.range &&
        widget.selectedRange != null &&
        widget.selectedRange!.end != null &&
        isSameDay(date, widget.selectedRange!.end!);
  }

  int _getDaysInMonth(DateTime date) {
    return DateTime(date.year, date.month + 1, 0).day;
  }

  int _getFirstDayOffset() {
    final firstDayOfMonth =
        DateTime(_currentMonth.year, _currentMonth.month, 1);
    return (firstDayOfMonth.weekday - widget.weekStartsOn) % 7;
  }

  String _getMonthName(int month) {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    return months[month - 1];
  }
}

/// A widget representing a single day cell in the calendar
class _DayCell extends StatelessWidget {
  const _DayCell({
    required this.date,
    required this.isSelected,
    required this.isSelectable,
    required this.isInRange,
    required this.isRangeStart,
    required this.isRangeEnd,
    required this.onTap,
    this.theme,
    this.dateFormatter,
  });

  final DateTime date;
  final bool isSelected;
  final bool isSelectable;
  final bool isInRange;
  final bool isRangeStart;
  final bool isRangeEnd;
  final VoidCallback? onTap;
  final DatePickerThemeCustom? theme;
  final String Function(DateTime)? dateFormatter;

  @override
  Widget build(BuildContext context) {
    final isToday = isSameDay(date, DateTime.now());

    return GestureDetector(
      onTap: isSelectable ? onTap : null,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: _getBackgroundColor(isToday),
          borderRadius: BorderRadius.circular(
            theme?.daySize ?? 25,
          ),
        ),
        child: Text(
          dateFormatter?.call(date) ?? '${date.day}',
          style: _getTextStyle(isToday),
        ),
      ),
    );
  }

  Color? _getBackgroundColor(bool isToday) {
    if (isSelected || isRangeStart || isRangeEnd) {
      return theme?.selectedDayColor ?? Colors.blue;
    }
    if (isInRange) {
      return theme?.selectedDayColor?.withOpacity(0.3) ??
          Colors.blue.withOpacity(0.3);
    }
    if (isToday) {
      return theme?.todayColor ?? Colors.grey[300];
    }
    return null;
  }

  TextStyle? _getTextStyle(bool isToday) {
    if (isSelected || isRangeStart || isRangeEnd) {
      return theme?.selectedDayTextStyle ??
          const TextStyle(color: Colors.white);
    }
    if (!isSelectable) {
      return theme?.dayTextStyle?.copyWith(color: Colors.grey) ??
          TextStyle(color: Colors.grey);
    }
    return theme?.dayTextStyle;
  }
}
