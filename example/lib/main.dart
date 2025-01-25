import 'package:flutter/material.dart';

import 'components/accordion_example.dart';
import 'components/date_picker_example.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
 const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: DatePickerExample(),
    );
  }
}
