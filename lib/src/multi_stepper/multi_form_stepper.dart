// multi_step_form.dart
import 'package:flutter/material.dart';

import 'controllers/multi_form_stepper_controller.dart';

// stepper_position.dart
enum StepperPosition {
  /// Stepper is positioned at the top of the form
  top,

  /// Stepper is positioned at the bottom of the form
  bottom,

  /// Stepper is positioned at the left of the form
  left,

  /// Stepper is positioned at the right of the form
  right
}

// stepper_theme.dart
class StepperTheme {
  /// Color of the progress indicator and active step
  final Color? activeColor;

  /// Color of completed steps
  final Color? completedColor;

  /// Background color of the progress indicator
  final Color? backgroundColor;

  /// Color of inactive steps
  final Color? inactiveColor;

  /// Text style for step titles
  final TextStyle? stepTitleStyle;

  /// Text style for active step title
  final TextStyle? activeStepTitleStyle;

  /// Text style for completed step title
  final TextStyle? completedStepTitleStyle;

  /// Size of step indicators
  final double stepSize;

  /// Thickness of the progress indicator
  final double progressThickness;

  /// Gap between step indicator and title
  final double labelGap;

  /// Spacing between steps
  final double stepSpacing;

  /// Border radius of the progress indicator
  final double progressBorderRadius;

  const StepperTheme({
    this.activeColor,
    this.completedColor,
    this.backgroundColor,
    this.inactiveColor,
    this.stepTitleStyle,
    this.activeStepTitleStyle,
    this.completedStepTitleStyle,
    this.stepSize = 30,
    this.progressThickness = 8,
    this.labelGap = 8,
    this.stepSpacing = 16,
    this.progressBorderRadius = 8,
  });
}

/// A customizable multi-step form widget with configurable stepper position and styling.
///
/// This widget provides a form wizard interface with:
/// * Configurable stepper position (top, right, bottom, left)
/// * Customizable styling through [StepperTheme]
/// * Progress tracking
/// * Step validation
/// * Navigation controls
///
/// Example usage:
/// ```dart
/// MultiStepForm(
///   controller: FormWizardController(steps: [
///     FormStep(
///       title: 'Personal Info',
///       content: PersonalInfoForm(),
///       formKey: GlobalKey<FormState>(),
///     ),
///     FormStep(
///       title: 'Address',
///       content: AddressForm(),
///       formKey: GlobalKey<FormState>(),
///     ),
///   ]),
///   stepperPosition: StepperPosition.left,
///   theme: StepperTheme(
///     activeColor: Colors.blue,
///     completedColor: Colors.green,
///   ),
///   onCompleted: () {
///     print('Form completed!');
///   },
/// )
/// ```
/// Configuration for form navigation buttons
// Modification de la classe FormNavigationConfig pour inclure les callbacks
class FormNavigationConfig {
  /// Custom widget for the "Previous" button
  final Widget Function(VoidCallback onPressed)? previousButtonBuilder;

  /// Custom widget for the "Next" button
  final Widget Function(VoidCallback onPressed)? nextButtonBuilder;

  /// Custom widget for the "Complete" button
  final Widget Function(VoidCallback onPressed)? completeButtonBuilder;

  /// Whether to show navigation buttons on the last step
  final bool showNavigationOnLastStep;

  /// Whether to show the previous button on the last step
  final bool showPreviousButtonOnLastStep;

  const FormNavigationConfig({
    this.previousButtonBuilder,
    this.nextButtonBuilder,
    this.completeButtonBuilder,
    this.showNavigationOnLastStep = true,
    this.showPreviousButtonOnLastStep = true,
  });
}

class MultiFormStep extends StatefulWidget {
  /// Controller managing the form state and navigation
  final MultiFormStepperController controller;

  /// Callback fired when the form is completed
  final Function()? onCompleted;

  /// Custom builder for step content
  final Widget Function(BuildContext, int)? stepBuilder;

  /// Position of the stepper relative to the form content
  final StepperPosition stepperPosition;

  /// Theme configuration for the stepper
  final StepperTheme theme;

  /// Padding around the form content
  final EdgeInsets? contentPadding;

  /// Navigation buttons configuration
  final FormNavigationConfig navigationConfig;

  /// Default labels for navigation buttons (used if custom buttons not provided)
  final String previousLabel;
  final String nextLabel;
  final String completeLabel;

  /// Animation duration for page transitions
  final Duration animationDuration;

  /// Animation curve for page transitions
  final Curve animationCurve;

  const MultiFormStep({
    Key? key,
    required this.controller,
    this.onCompleted,
    this.stepBuilder,
    this.stepperPosition = StepperPosition.top,
    this.theme = const StepperTheme(),
    this.contentPadding,
    this.navigationConfig = const FormNavigationConfig(),
    this.previousLabel = 'Previous',
    this.nextLabel = 'Next',
    this.completeLabel = 'Complete',
    this.animationDuration = const Duration(milliseconds: 300),
    this.animationCurve = Curves.easeInOut,
  }) : super(key: key);

  @override
  _MultiFormStepState createState() => _MultiFormStepState();
}

class _MultiFormStepState extends State<MultiFormStep> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController =
        PageController(initialPage: widget.controller.currentStep);
    widget.controller.addListener(_onControllerChanged);
  }

  @override
  void dispose() {
    _pageController.dispose();
    widget.controller.removeListener(_onControllerChanged);
    super.dispose();
  }

  void _onControllerChanged() {
    if (_pageController.page?.round() != widget.controller.currentStep) {
      _pageController.animateToPage(
        widget.controller.currentStep,
        duration: widget.animationDuration,
        curve: widget.animationCurve,
      );
      setState(() {});
    }
  }

  Widget _buildStepper() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isHorizontal = widget.stepperPosition == StepperPosition.top ||
            widget.stepperPosition == StepperPosition.bottom;

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isHorizontal) ...[
              ClipRRect(
                borderRadius:
                    BorderRadius.circular(widget.theme.progressBorderRadius),
                child: LinearProgressIndicator(
                  value: widget.controller.progress,
                  backgroundColor:
                      widget.theme.backgroundColor ?? Colors.grey[200],
                  valueColor: AlwaysStoppedAnimation<Color>(
                    widget.theme.activeColor ?? Theme.of(context).primaryColor,
                  ),
                  minHeight: widget.theme.progressThickness,
                ),
              ),
              SizedBox(height: widget.theme.labelGap),
            ],
            Flex(
              direction: isHorizontal ? Axis.horizontal : Axis.vertical,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                widget.controller.totalSteps,
                (index) => _buildStepIndicator(index),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildStepIndicator(int index) {
    final isCurrentStep = index == widget.controller.currentStep;
    final isCompleted = widget.controller.steps[index].isCompleted;

    final title = widget.controller.steps[index].title;
    final TextStyle titleStyle;
    if (isCurrentStep) {
      titleStyle = widget.theme.activeStepTitleStyle ??
          widget.theme.stepTitleStyle?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ) ??
          const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          );
    } else if (isCompleted) {
      titleStyle = widget.theme.completedStepTitleStyle ??
          widget.theme.stepTitleStyle?.copyWith(
            color: widget.theme.completedColor ?? Colors.green,
          ) ??
          TextStyle(
            color: widget.theme.completedColor ?? Colors.green,
          );
    } else {
      titleStyle = widget.theme.stepTitleStyle ??
          const TextStyle(
            color: Colors.black54,
          );
    }

    final isHorizontal = widget.stepperPosition == StepperPosition.top ||
        widget.stepperPosition == StepperPosition.bottom;

    return Padding(
      padding: EdgeInsets.all(widget.theme.stepSpacing / 2),
      child: Flex(
        direction: isHorizontal ? Axis.vertical : Axis.horizontal,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: widget.theme.stepSize,
            height: widget.theme.stepSize,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isCurrentStep
                  ? widget.theme.activeColor ?? Theme.of(context).primaryColor
                  : isCompleted
                      ? widget.theme.completedColor ?? Colors.green
                      : widget.theme.inactiveColor ?? Colors.grey[300],
            ),
            child: Center(
              child: isCompleted
                  ? Icon(
                      Icons.check,
                      color: Colors.white,
                      size: widget.theme.stepSize * 0.6,
                    )
                  : Text(
                      '${index + 1}',
                      style: TextStyle(
                        color: isCurrentStep ? Colors.white : Colors.black54,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ),
          ),
          SizedBox(
            width: isHorizontal ? 0 : widget.theme.labelGap,
            height: isHorizontal ? widget.theme.labelGap : 0,
          ),
          Text(title, style: titleStyle),
        ],
      ),
    );
  }

  void _handleNextStep() {
    if (widget.controller.isLastStep) {
      final lastFormKey = widget.controller.steps.last.formKey;
      if (lastFormKey.currentState?.validate() ?? false) {
        widget.onCompleted?.call();
      }
    } else {
      widget.controller.nextStep();
    }
  }

  Widget _buildNavigationButtons() {
    // Don't show navigation on last step if configured not to
    if (widget.controller.isLastStep &&
        !widget.navigationConfig.showNavigationOnLastStep) {
      return const SizedBox.shrink();
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Previous button
        if (!widget.controller.isFirstStep &&
            (!widget.controller.isLastStep ||
                widget.navigationConfig.showPreviousButtonOnLastStep))
          widget.navigationConfig.previousButtonBuilder?.call(
                widget.controller.previousStep,
              ) ??
              TextButton(
                onPressed: widget.controller.previousStep,
                child: Text(widget.previousLabel),
              )
        else
          const SizedBox(width: 80),

        // Next/Complete button
        if (widget.controller.isLastStep)
          widget.navigationConfig.completeButtonBuilder?.call(
                _handleNextStep,
              ) ??
              ElevatedButton(
                onPressed: _handleNextStep,
                child: Text(widget.completeLabel),
              )
        else
          widget.navigationConfig.nextButtonBuilder?.call(
                _handleNextStep,
              ) ??
              ElevatedButton(
                onPressed: _handleNextStep,
                child: Text(widget.nextLabel),
              ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final content = Column(
      children: [
        Expanded(
          child: PageView.builder(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: widget.controller.totalSteps,
            onPageChanged: (index) {
              if (widget.controller.currentStep != index) {
                widget.controller.goToStep(index);
              }
            },
            itemBuilder: (context, index) {
              if (widget.stepBuilder != null) {
                return widget.stepBuilder!(context, index);
              }
              return AnimatedSwitcher(
                duration: widget.animationDuration,
                child: widget.controller.steps[index].content,
              );
            },
          ),
        ),
        Padding(
          padding: widget.contentPadding ?? const EdgeInsets.all(16),
          child: _buildNavigationButtons(),
        ),
      ],
    );

    final stepper = Padding(
      padding: widget.contentPadding ?? const EdgeInsets.all(16),
      child: _buildStepper(),
    );

    switch (widget.stepperPosition) {
      case StepperPosition.top:
        return Column(
          children: [stepper, Expanded(child: content)],
        );
      case StepperPosition.bottom:
        return Column(
          children: [Expanded(child: content), stepper],
        );
      case StepperPosition.left:
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [stepper, Expanded(child: content)],
        );
      case StepperPosition.right:
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [Expanded(child: content), stepper],
        );
    }
  }
}
