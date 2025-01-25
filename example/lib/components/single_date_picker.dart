// import 'package:flui_kit/flui_kit.dart';
// import 'package:flutter/material.dart';

// class SingleDatePicker extends StatefulWidget {
//   const SingleDatePicker({super.key});

//   @override
//   State<SingleDatePicker> createState() => _SingleDatePickerState();
// }

// class _SingleDatePickerState extends State<SingleDatePicker> {
//   DateTime? _selectedDate;

//   final DatePickerController _controller = DatePickerController();

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(15.0),
//       child: DatePicker.single(
//         controller: _controller,
//         selectedDate: _selectedDate,
//         closeOnSelection: false,
//         onChange: (date) {
//           setState(() => _selectedDate = date);
//         },
//         // Customization
//         // theme: DatePickerThemeCustom(
//         //   daySize: 40,
//         //   selectedDayColor: Colors.deepPurple,
//         //   todayColor: Colors.deepPurple.withOpacity(0.2),
//         //   dayTextStyle: const TextStyle(
//         //     fontWeight: FontWeight.w600,
//         //     fontSize: 16,
//         //   ),
//         //   selectedDayTextStyle: const TextStyle(
//         //     fontWeight: FontWeight.bold,
//         //     fontSize: 16,
//         //     color: Colors.white,
//         //   ),
//         //   weekdayTextStyle: const TextStyle(
//         //     fontWeight: FontWeight.bold,
//         //     color: Colors.deepPurple,
//         //   ),
//         //   monthTextStyle: const TextStyle(
//         //     fontSize: 18,
//         //     fontWeight: FontWeight.bold,
//         //     color: Colors.deepPurple,
//         //   ),
//         //   padding: const EdgeInsets.all(8),
//         // ),
//         // Calendar container decoration
//         calendarDecoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(12),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey.withOpacity(0.2),
//               spreadRadius: 2,
//               blurRadius: 5,
//               offset: const Offset(0, 2),
//             ),
//           ],
//         ),
//         // Date constraints
//         minDate: DateTime.now().subtract(const Duration(days: 365)),
//         maxDate: DateTime.now().add(const Duration(days: 365)),
//         // Custom formatters
//         dateFormatter: (date) {
//           return '${date.day}';
//         },
//         // monthYearFormatter: (date) {
//         //   return DateFormat('MMMM yyyy').format(date);
//         // },
//         weekdayLabels: const ['M', 'T', 'W', 'T', 'F', 'S', 'S'],
//         // Other options
//         showWeekNumbers: true,
//         weekStartsOn: DateTime.monday,
//         numberOfMonths: 1,
//         showOutsideDays: true,
//         selectableDayPredicate: (date) {
//           // Disable weekends
//           return date.weekday != DateTime.saturday &&
//               date.weekday != DateTime.sunday;
//         },
//       ),
//     );
//   }
// }
