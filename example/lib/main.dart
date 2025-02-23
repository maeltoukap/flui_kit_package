import 'package:flutter/material.dart';

import 'components/accordion_example.dart';
// import 'components/advanced_pagination_example.dart';
import 'components/date_picker_example.dart';
// import 'components/queed_notification_example.dart';
// import 'components/multi_stepper_example.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AccordionExample(),
    );
  }
}
