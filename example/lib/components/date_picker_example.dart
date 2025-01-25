import 'package:flui_kit/flui_kit.dart';
import 'package:flui_kit_example/components/single_date_picker.dart';
import 'package:flutter/material.dart';

class DatePickerExample extends StatefulWidget {
  const DatePickerExample({super.key});

  @override
  State<DatePickerExample> createState() => _DatePickerExampleState();
}

class _DatePickerExampleState extends State<DatePickerExample> {
  DateTime? _selectedDate;
  DateRange? _selectedRange;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Date Picker Example'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Single Date Picker Example
            const Text(
              'Single Date Selection',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: () async {
                await showSingleDatePicker(
                  context: context,
                  closeOnSelection: false,
                  calendarDecoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  showOutsideDays: true,
                  initialMonth: DateTime.now(),
                  weekdayLabels: [
                    'Lun',
                    'Mar',
                    'Mer',
                    'Jeu',
                    'Ven',
                    'Sam',
                    'Dim',
                  ],
                  showWeekNumbers: true,
                  weekStartsOn: DateTime.monday,
                  numberOfMonths: 2,
                  minDate: DateTime(2023),
                  maxDate: DateTime(2026),
                  selectableDayPredicate: (date) =>
                      date.weekday != DateTime.sunday,
                  hideNavigation: false,
                  theme: const DatePickerThemeCustom(),
                  initialDate: DateTime.now(),
                  onChange: (date) {
                    setState(() {
                      _selectedDate = date;
                    });
                  },
                  dialogPadding: const EdgeInsets.all(24),
                );
              },
              child: Container(
                height: 50,
                width: double.infinity,
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.blue,
                ),
                alignment: Alignment.center,
                child: const Text("Click me to open date picker"),
              ),
            ),

            const SizedBox(height: 32),

            // Range Date Picker Example
            const Text(
              'Date Range Selection',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: () async {
                await showRangeDatePicker(
                  context: context,
                  closeOnSelection: false,
                  calendarDecoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  showOutsideDays: true,
                  initialMonth: DateTime.now(),
                  weekdayLabels: [
                    'Lun',
                    'Mar',
                    'Mer',
                    'Jeu',
                    'Ven',
                    'Sam',
                    'Dim',
                  ],
                  showWeekNumbers: true,
                  weekStartsOn: DateTime.monday,
                  numberOfMonths: 2,
                  minDate: DateTime(2023),
                  maxDate: DateTime(2026),
                  selectableDayPredicate: (date) =>
                      date.weekday != DateTime.sunday,
                  hideNavigation: false,
                  theme: const DatePickerThemeCustom(),
                  onRangeChange: (range) {
                    setState(() {
                      _selectedRange = range;
                    });
                  },
                  dialogPadding: const EdgeInsets.all(24),
                );
              },
              child: Container(
                height: 50,
                width: double.infinity,
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.blue,
                ),
                alignment: Alignment.center,
                child: const Text("Click me to open date picker"),
              ),
            ),

            const SizedBox(height: 32),

            // Display selected values
            Text(
              'Selected Date: ${_selectedDate?.toString() ?? "None"}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              'Selected Range: ${_selectedRange?.toString() ?? "None"}',
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
