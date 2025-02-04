// Exemple d'utilisation
import 'package:flui_kit/flui_kit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MultiStepperExample extends StatefulWidget {
  MultiStepperExample({super.key});

  @override
  State<MultiStepperExample> createState() => _MultiStepperExampleState();
}

class _MultiStepperExampleState extends State<MultiStepperExample> {
  late MultiFormStepperController _controller;

  @override
  void initState() {
    _controller = MultiFormStepperController(
      steps: [
        FormStep(
          title: 'Personal Info',
          content: _buildPersonalInfoStep(),
          formKey: _step1Key,
        ),
        FormStep(
          title: 'Address',
          content: _buildContactStep(),
          formKey: _step2Key,
        ),
        FormStep(
          title: 'Review',
          content: _buildSummaryStep(),
          formKey: _step3Key,
        ),
      ],
    );
    super.initState();
  }

  final _step1Key = GlobalKey<FormState>();

  final _step2Key = GlobalKey<FormState>();

  final _step3Key = GlobalKey<FormState>();

  Widget _buildPersonalInfoStep() {
    return Form(
      key: _step1Key,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TextFormField(
            decoration: const InputDecoration(labelText: 'Last name'),
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return 'Please enter your last name';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            decoration: const InputDecoration(labelText: 'First name'),
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return 'Please enter your first name';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildContactStep() {
    return Form(
      key: _step2Key,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TextFormField(
            decoration: const InputDecoration(labelText: 'Email address'),
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return 'Please enter your email';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            decoration: const InputDecoration(labelText: 'Phone number'),
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return 'Please enter your phone number';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryStep() {
    return Form(
      key: _step3Key,
      child: const Center(
        child: Text('Please check your information before validating'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inscription'),
      ),
      body: MultiFormStep(
        controller: MultiFormStepperController(
          steps: [
            FormStep(
              title: 'Personal Info',
              content: _buildPersonalInfoStep(),
              formKey: _step1Key,
            ),
            FormStep(
              title: 'Address',
              content: _buildContactStep(),
              formKey: _step2Key,
            ),
            FormStep(
              title: 'Review',
              content: _buildSummaryStep(),
              formKey: _step3Key,
            ),
          ],
        ),
        navigationConfig: FormNavigationConfig(
          // Builder pattern pour les boutons personnalisés
          previousButtonBuilder: (onPressed) => OutlinedButton.icon(
            onPressed: onPressed, // Utilise le callback fourni
            icon: const Icon(Icons.arrow_back),
            label: const Text('Retour'),
          ),
          nextButtonBuilder: (onPressed) => ElevatedButton.icon(
            onPressed: onPressed, // Utilise le callback fourni
            icon: const Icon(Icons.arrow_forward),
            label: const Text('Suivant'),
          ),
          completeButtonBuilder: (onPressed) => FilledButton.icon(
            onPressed: onPressed, // Utilise le callback fourni
            icon: const Icon(Icons.check),
            label: const Text('Terminer'),
          ),
          showNavigationOnLastStep: true,
          showPreviousButtonOnLastStep: false,
        ),
        onCompleted: () {
          if (kDebugMode) {
            print('Form completed!');
          }
        },
      ),
    );
  }
}
