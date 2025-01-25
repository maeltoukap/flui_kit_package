/// Represents a range of dates with a start and end date
class DateRange {
  /// The start date of the range
  final DateTime start;

  /// The end date of the range
  final DateTime? end;

  /// Creates a new DateRange instance
  ///
  /// [start] is required and represents the beginning of the range
  /// [end] is optional and represents the end of the range
  const DateRange({
    required this.start,
    this.end,
  });

  /// Creates a copy of this DateRange with the given fields replaced
  DateRange copyWith({
    DateTime? start,
    DateTime? end,
  }) {
    return DateRange(
      start: start ?? this.start,
      end: end ?? this.end,
    );
  }

  @override
  String toString() => 'DateRange(start: $start, end: $end)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is DateRange && other.start == start && other.end == end;
  }

  @override
  int get hashCode => start.hashCode ^ end.hashCode;
}

/// File: models/date_picker_type.dart

/// Defines the type of date selection
enum DatePickerType {
  /// Single date selection mode
  single,

  /// Date range selection mode
  range,
}
