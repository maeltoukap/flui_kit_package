import 'package:flutter/material.dart';

/// A widget that animates number transitions with configurable style and precision.
class AnimatedNumber extends StatelessWidget {
  final double value;
  final TextStyle? style;
  final Duration duration;
  final int decimalPlaces;

  /// Creates an animated number display.
  ///
  /// - [value]: The number to display.
  /// - [style]: Optional text style for the displayed number.
  /// - [duration]: Animation duration, defaults to 300ms.
  /// - [decimalPlaces]: Number of decimal places to display, defaults to 2.
  const AnimatedNumber({
    Key? key,
    required this.value,
    this.style,
    this.duration = const Duration(milliseconds: 300),
    this.decimalPlaces = 2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      duration: duration,
      tween: Tween<double>(begin: value, end: value),
      builder: (context, value, child) {
        return Text(
          value.toStringAsFixed(decimalPlaces),
          style: style,
        );
      },
    );
  }
}

/// Configuration class for the plan button's visual properties.
class PlanChoicesTheme {
  final Color borderColor;
  final Color activeBorderColor;
  final Color popularBackgroundColor;
  final Color popularTextColor;
  final TextStyle planTextStyle;
  final TextStyle priceTextStyle;
  final TextStyle periodTextStyle;
  final double borderWidth;
  final double borderRadius;
  final double height;
  final EdgeInsets padding;

  const PlanChoicesTheme({
    this.borderColor = const Color(0xFFCBD5E1),
    this.activeBorderColor = Colors.black,
    this.popularBackgroundColor = const Color(0xFFFEF9C3),
    this.popularTextColor = const Color(0xFF713F12),
    this.planTextStyle = const TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 20,
    ),
    this.priceTextStyle = const TextStyle(
      fontWeight: FontWeight.w500,
      color: Color(0xFF1F2937),
    ),
    this.periodTextStyle = const TextStyle(
      color: Color(0xFF64748B),
    ),
    this.borderWidth = 2,
    this.borderRadius = 16,
    this.height = 88,
    this.padding = const EdgeInsets.all(16),
  });
}

/// A customizable subscription plan button widget.
class ButtonPlan extends StatelessWidget {
  final String plan;
  final bool active;
  final VoidCallback onTap;
  final double price;
  final bool popular;
  final String? popularLabel;
  final String currencySymbol;
  final String? periodLabel;
  final PlanChoicesTheme theme;
  final int decimalPlaces;
  final Duration animationDuration;
  final Widget? trailing;
  final Widget? leading;

  /// Creates a subscription plan button.
  ///
  /// - [plan]: The name of the plan (e.g., "Starter", "Pro").
  /// - [active]: Whether this plan is currently selected.
  /// - [onTap]: Callback when the plan is selected.
  /// - [price]: The price amount to display.
  /// - [popular]: Whether to show the popular badge.
  /// - [popularLabel]: Custom text for the popular badge (defaults to "Popular").
  /// - [currencySymbol]: Currency symbol to display before price (defaults to "$").
  /// - [periodLabel]: Label for the pricing period (defaults to "/month").
  /// - [theme]: Custom theme for the button's appearance.
  /// - [decimalPlaces]: Number of decimal places for the price.
  /// - [animationDuration]: Duration for all animations.
  /// - [trailing]: Optional widget to display at the end.
  /// - [leading]: Optional widget to display at the start.
  const ButtonPlan({
    Key? key,
    required this.plan,
    required this.active,
    required this.onTap,
    required this.price,
    this.popular = false,
    this.popularLabel = 'Popular',
    this.currencySymbol = '\$',
    this.periodLabel = '/month',
    this.theme = const PlanChoicesTheme(),
    this.decimalPlaces = 2,
    this.animationDuration = const Duration(milliseconds: 300),
    this.trailing,
    this.leading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: theme.height,
        padding: theme.padding,
        decoration: BoxDecoration(
          border: Border.all(
            width: theme.borderWidth,
            color: active ? theme.activeBorderColor : theme.borderColor,
          ),
          borderRadius: BorderRadius.circular(theme.borderRadius),
        ),
        child: Row(
          children: [
            if (leading != null) leading!,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Text(plan, style: theme.planTextStyle),
                      if (popular) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: theme.popularBackgroundColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            popularLabel!,
                            style: TextStyle(
                              color: theme.popularTextColor,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  Row(
                    children: [
                      Text(currencySymbol, style: theme.priceTextStyle),
                      AnimatedNumber(
                        value: price,
                        style: theme.priceTextStyle,
                        duration: animationDuration,
                        decimalPlaces: decimalPlaces,
                      ),
                      Text(periodLabel!, style: theme.periodTextStyle),
                    ],
                  ),
                ],
              ),
            ),
            if (trailing != null) trailing! else _buildDefaultTrailing(),
          ],
        ),
      ),
    );
  }

  Widget _buildDefaultTrailing() {
    return Container(
      width: 24,
      height: 24,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        border: Border.all(
          width: 2,
          color: active ? theme.activeBorderColor : const Color(0xFF64748B),
        ),
        shape: BoxShape.circle,
      ),
      child: AnimatedOpacity(
        duration: animationDuration,
        opacity: active ? 1.0 : 0.0,
        child: Container(
          decoration: BoxDecoration(
            color: theme.activeBorderColor,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}

/// Configuration class for the period toggle button's appearance.
class PeriodTheme {
  final Color backgroundColor;
  final Color activeColor;
  final Color shadowColor;
  final TextStyle labelStyle;
  final double height;
  final double borderRadius;
  final EdgeInsets padding;

  const PeriodTheme({
    this.backgroundColor = const Color(0xFFF1F5F9),
    this.activeColor = Colors.white,
    this.shadowColor = Colors.black12,
    this.labelStyle = const TextStyle(
      fontWeight: FontWeight.w600,
      color: Color(0xFF1F2937),
    ),
    this.height = 56,
    this.borderRadius = 30,
    this.padding = const EdgeInsets.all(6),
  });
}

/// A customizable toggle button for switching between different periods.
class ButtonToggle extends StatelessWidget {
  final int period;
  final Function(int) onChangePeriod;
  final List<String> labels;
  final PeriodTheme theme;
  final Duration animationDuration;

  /// Creates a period toggle button.
  ///
  /// - [period]: Index of the active button (e.g., 0 = Monthly, 1 = Yearly).
  /// - [onChangePeriod]: Callback when period changes.
  /// - [labels]: List of period labels (defaults to ["Monthly", "Yearly"]).
  /// - [theme]: Custom theme for the toggle's appearance.
  /// - [animationDuration]: Duration for the sliding animation.
  const ButtonToggle({
    Key? key,
    required this.period,
    required this.onChangePeriod,
    this.labels = const ['Monthly', 'Yearly'],
    this.theme = const PeriodTheme(),
    this.animationDuration = const Duration(milliseconds: 300),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final labelWidth = (MediaQuery.of(context).size.width - 48) / 2.7;
    final leftLabelWidth = (MediaQuery.of(context).size.width - 48) / 2;

    return Container(
      height: theme.height,
      decoration: BoxDecoration(
        color: theme.backgroundColor,
        borderRadius: BorderRadius.circular(theme.borderRadius),
      ),
      padding: theme.padding,
      child: Stack(
        children: [
          AnimatedPositioned(
            duration: animationDuration,
            left: period * leftLabelWidth,
            top: 0,
            bottom: 0,
            child: Container(
              width: labelWidth,
              decoration: BoxDecoration(
                color: theme.activeColor,
                borderRadius: BorderRadius.circular(theme.borderRadius - 6),
                boxShadow: [
                  BoxShadow(
                    color: theme.shadowColor,
                    blurRadius: 4,
                  ),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: List.generate(
              labels.length,
              (index) => Expanded(
                child: TextButton(
                  onPressed: () => onChangePeriod(index),
                  style: TextButton.styleFrom(padding: EdgeInsets.zero),
                  child: Text(
                    labels[index],
                    style: theme.labelStyle,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Configuration class for the main plan switcher widget.
class PlanSwitcherTheme {
  final Color backgroundColor;
  final Color borderColor;
  final double borderWidth;
  final double borderRadius;
  final EdgeInsets padding;
  final BoxShadow shadow;
  final Color buttonBackgroundColor;
  final Color buttonTextColor;
  final double buttonBorderRadius;
  final double buttonElevation;
  final double buttonWidth;
  final double buttonHeight;
  final TextStyle buttonTextStyle;

  const PlanSwitcherTheme({
    this.backgroundColor = Colors.white,
    this.borderColor = const Color(0xFFCBD5E1),
    this.borderWidth = 2,
    this.borderRadius = 32,
    this.padding = const EdgeInsets.all(12),
    this.shadow = const BoxShadow(
      color: Colors.black12,
      blurRadius: 4,
      spreadRadius: 1,
      offset: Offset(0, 2),
    ),
    this.buttonBackgroundColor = Colors.black,
    this.buttonTextColor = Colors.white,
    this.buttonBorderRadius = 15.0,
    this.buttonElevation = 5.0,
    this.buttonWidth = double.infinity,
    this.buttonHeight = 56.0,
    this.buttonTextStyle = const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w500,
    ),
  });
}

/// A customizable button widget that includes a scaling effect when pressed.
///
/// This widget allows for customizing various style properties, including
/// background color, text color, border radius, elevation, size, and more.
/// The button also includes a smooth scaling animation when pressed for an
/// enhanced user experience.
///
/// Example usage:
/// ```dart
/// CustomButton(
///   label: 'Get Started',
///   onPressed: () {
///     // Action when the button is pressed
///   },
///   backgroundColor: Colors.blue,
///   textColor: Colors.white,
///   borderRadius: 15.0,
///   elevation: 5.0,
/// )
/// ```
class CustomButton extends StatefulWidget {
  /// The text displayed on the button.
  final String label;

  /// The callback function executed when the button is pressed.
  final void Function() onPressed;

  /// The background color of the button. Defaults to black.
  final Color backgroundColor;

  /// The color of the text on the button. Defaults to white.
  final Color textColor;

  /// The radius for rounded corners of the button. Defaults to 30.0.
  final double borderRadius;

  /// The elevation (shadow effect) of the button. Defaults to 0.0.
  final double elevation;

  /// The width of the button. Defaults to `double.infinity`.
  final double width;

  /// The height of the button. Defaults to 56.0.
  final double height;

  /// The text style of the button. Defaults to `TextStyle(fontSize: 18, fontWeight: FontWeight.w500)`.
  final TextStyle textStyle;

  /// Creates a new [CustomButton] with the specified properties.
  ///
  /// [label] and [onPressed] are required.
  ///
  /// Other properties are optional and have default values:
  /// - [backgroundColor] defaults to `Colors.black`
  /// - [textColor] defaults to `Colors.white`
  /// - [borderRadius] defaults to `30.0`
  /// - [elevation] defaults to `0.0`
  /// - [width] defaults to `double.infinity`
  /// - [height] defaults to `56.0`
  CustomButton({
    required this.label,
    required this.onPressed,
    this.backgroundColor = Colors.black,
    this.textColor = Colors.white,
    this.borderRadius = 15.0,
    this.elevation = 0.0,
    this.width = double.infinity,
    this.height = 56.0,
    this.textStyle = const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
  });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  Tween<double> tween = Tween<double>(begin: 1.0, end: 1.0);

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 300),
      tween: Tween<double>(
        begin: 1.0,
        end: 1.0,
      ),
      builder: (context, scale, child) {
        return GestureDetector(
          onTapDown: (_) {
            // Update the tween on tap down to create a scaling effect
            setState(() {
              tween = Tween<double>(begin: scale, end: 0.95);
            });
          },
          onTapUp: (_) {
            // Reset to normal scale on tap up
            setState(() {
              tween = Tween<double>(begin: scale, end: 1.0);
            });
          },
          onTapCancel: () {
            // Reset to normal scale if the tap is canceled
            setState(() {
              tween = Tween<double>(begin: scale, end: 1.0);
            });
          },
          child: Transform.scale(
            scale: scale,
            child: SizedBox(
              width: widget.width,
              height: widget.height,
              child: ElevatedButton(
                onPressed: widget.onPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: widget.backgroundColor,
                  elevation: widget.elevation,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(widget.borderRadius),
                  ),
                ),
                child: Text(
                  widget.label,
                  style: widget.textStyle,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

/// Main widget for displaying and selecting subscription plans.
class PlanSwitcher extends StatefulWidget {
  final List<PlanData> plans;
  final String? period;
  final void Function(int)? onPlanSelected;
  final void Function(bool)? onPeriodChanged;
  final void Function(PlanData plan)? onPressed;
  final PlanSwitcherTheme theme;
  final PlanChoicesTheme planTheme;
  final PeriodTheme periodTheme;
  final Widget? footer;
  final String buttonTitle;
  final String? popularLabel;

  /// Creates a plan switcher widget.
  ///
  /// - [plans]: List of plan data to display.
  /// - [buttonTitle]: Title to display on the submit button.
  /// - [period]:Period to display (monthly/yearly).
  /// - [onPlanSelected]: Callback when a plan is selected.
  /// - [onPeriodChanged]: Callback when period changes (monthly/yearly).
  /// - [onPressed]: Callback when plan is submitted.
  /// - [theme]: Custom theme for the main container.
  /// - [planTheme]: Custom theme for plan buttons.
  /// - [periodTheme]: Custom theme for the period toggle.
  /// - [footer]: Optional widget to display at the bottom.
  /// - [buttonTitle]: Title to display on the submit button.
  /// - [popularLabel]: Custom text for the popular badge (defaults to "Popular").
  const PlanSwitcher({
    Key? key,
    required this.plans,
    required this.buttonTitle,
    this.popularLabel = 'Popular',
    this.period = '/month',
    this.onPlanSelected,
    this.onPeriodChanged,
    this.onPressed,
    this.theme = const PlanSwitcherTheme(),
    this.planTheme = const PlanChoicesTheme(),
    this.periodTheme = const PeriodTheme(),
    this.footer,
  }) : super(key: key);

  @override
  State<PlanSwitcher> createState() => _PlanSwitcherState();
}

/// Data class for plan information.
class PlanData {
  final String name;
  double monthlyPrice;
  double yearlyPrice;
  final bool popular;

  PlanData({
    required this.name,
    required this.monthlyPrice,
    required this.yearlyPrice,
    this.popular = false,
  });
}

// [Rest of the implementation remains the same but uses the new configuration options]
class _PlanSwitcherState extends State<PlanSwitcher> {
  int _active = 0;
  int _period = 0;
  List<double> _prices = [];

  void _handleChangePlan(int index) {
    widget.onPlanSelected?.call(index);
    setState(() {
      _active = index;
    });
  }

  void _handleChangePeriod(int period) {
    setState(() {
      _period = period;

      // Update prices based on the selected period
      if (period == 0) {
        _prices = widget.plans.map((plan) => plan.monthlyPrice).toList();
      } else {
        _prices = widget.plans.map((plan) => plan.yearlyPrice).toList();
      }

      widget.onPeriodChanged?.call(period == 1);
    });
  }

  @override
  void initState() {
    _prices = widget.plans.map((plan) => plan.monthlyPrice).toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Container(
            constraints: const BoxConstraints(maxWidth: 500),
            decoration: BoxDecoration(
              color: widget.theme.backgroundColor,
              border: Border.all(
                  width: widget.theme.borderWidth,
                  color: widget.theme.borderColor),
              borderRadius: BorderRadius.circular(widget.theme.borderRadius),
              boxShadow: [
                widget.theme.shadow,
              ],
            ),
            child: Padding(
              padding: widget.theme.padding,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ButtonToggle(
                    period: _period,
                    onChangePeriod: _handleChangePeriod,
                  ),
                  const SizedBox(height: 16),
                  IntrinsicHeight(
                    // height: 312, // (88 * 3) + (24 * 2) pour les espacements
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Column(
                          children: List.generate(
                            widget.plans.length,
                            (int index) => Padding(
                              padding: EdgeInsets.only(
                                  bottom:
                                      index == widget.plans.length ? 0 : 12.0),
                              child: ButtonPlan(
                                plan: widget.plans[index].name,
                                active: _active == index,
                                onTap: () => _handleChangePlan(index),
                                popular: widget.plans[index].popular,
                                periodLabel: widget.period,
                                price: _prices[index],
                                popularLabel: widget.popularLabel,
                                theme: widget.planTheme,
                              ),
                            ),
                          ),
                        ),
                        AnimatedPositioned(
                          duration: const Duration(milliseconds: 300),
                          top: _active * 100.0,
                          left: 0,
                          right: 0,
                          child: Container(
                            height: 88,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black,
                                width: 3,
                              ),
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  CustomButton(
                    label: widget.buttonTitle,
                    onPressed: () {
                      widget.onPressed?.call(widget.plans[_active]);
                    },
                    backgroundColor: widget.theme.buttonBackgroundColor,
                    width: widget.theme.buttonWidth,
                    height: widget.theme.buttonHeight,
                    textStyle: widget.theme.buttonTextStyle
                        .copyWith(color: widget.theme.buttonTextColor),
                    textColor: widget.theme.buttonTextColor,
                    borderRadius: widget.theme.buttonBorderRadius,
                    elevation: widget.theme.buttonElevation,
                  ),
                  if (widget.footer != null) widget.footer!
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
