import 'package:flui_kit/flui_kit.dart';
import 'package:flutter/material.dart';

class PlanSwitcherExample extends StatelessWidget {
  PlanSwitcherExample({super.key});

  final myTheme = PlanSwitcherTheme(
    borderRadius: 24,
    backgroundColor: Colors.grey[50]!,
    buttonTextColor: Colors.white,
  );

  final myPlanTheme = PlanChoicesTheme(
    popularBackgroundColor: Colors.red[50]!,
    popularTextColor: const Color(0xFF900DA1)!,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plan switcher example app'),
      ),
      body: PlanSwitcher(
        plans: [
          PlanData(
            name: 'Free',
            monthlyPrice: 0.00,
            yearlyPrice: 0.00,
            popular: false,
          ),
          PlanData(
            name: 'Starter',
            monthlyPrice: 9.99,
            yearlyPrice: 7.49,
            popular: true,
          ),
          PlanData(
            name: 'Pro',
            monthlyPrice: 19.99,
            yearlyPrice: 17.49,
            popular: false,
          ),
        ],
        theme: myTheme,
        planTheme: myPlanTheme,
        onPlanSelected: (index) => print('Selected plan: $index'),
        period: '/month',
        buttonTitle: 'Get Started',
      ),
    );
  }
}
