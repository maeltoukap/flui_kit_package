import 'package:flui_kit_example/components/accordion_example.dart';
import 'package:flui_kit_example/components/advanced_pagination_example.dart'
    show AdvancedPaginationExample;
import 'package:flui_kit_example/components/date_picker_example.dart'
    show DatePickerExample;
import 'package:flui_kit_example/components/multi_stepper_example.dart'
    show MultiStepperExample;
import 'package:flui_kit_example/components/plan_switcher_example.dart'
    show PlanSwitcherExample;
import 'package:flui_kit_example/components/queed_notification_example.dart'
    show QueedNotificationExample;
import 'package:flutter/material.dart';

enum FluKitExample {
  accordionExample("Accordion Example"),
  advancedPaginationExample("Advanced Pagination Example"),
  datePickerExample("Date Picker Example"),
  multiStepperExample("Multi Stepper Example"),
  planSwitcherExample("Plan Switcher Example"),
  queedNotificationExample("Queed Notification Example");

  final String title;

  const FluKitExample(this.title);

  static List<FluKitExample> getExampleList() => [
        FluKitExample.accordionExample,
        FluKitExample.advancedPaginationExample,
        FluKitExample.datePickerExample,
        FluKitExample.multiStepperExample,
        FluKitExample.planSwitcherExample,
        FluKitExample.queedNotificationExample,
      ];
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flu Kit Examples'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: FluKitExample.getExampleList()
              .map(
                (e) => ListTile(
                  title: Text(e.title),
                  onTap: () => onTap(e, context),
                ),
              )
              .toList(),
        ),
      ),
    );
  }

  void onTap(FluKitExample e, BuildContext context) {
    switch (e) {
      case FluKitExample.accordionExample:
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => AccordionExample(),
          ),
        );
        break;
      case FluKitExample.advancedPaginationExample:
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const AdvancedPaginationExample(),
          ),
        );
        break;
      case FluKitExample.datePickerExample:
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const DatePickerExample(),
          ),
        );
        break;
      case FluKitExample.multiStepperExample:
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => MultiStepperExample(),
          ),
        );
        break;
      case FluKitExample.planSwitcherExample:
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => PlanSwitcherExample(),
          ),
        );
        break;
      case FluKitExample.queedNotificationExample:
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => QueedNotificationExample(),
          ),
        );
        break;
    }
  }
}
