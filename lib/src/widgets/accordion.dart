import 'package:flutter/material.dart';

/// A customizable accordion widget
class Accordion<T> extends StatefulWidget {
  /// The list of accordion items
  final List<AccordionItem<T>> children;

  /// The initial value of the accordion
  final T? initialValue;

  /////// / The type of accordion (single or multiple)
 /////// // final AccordionType type;

  /// Whether to maintain the state of the accordion
  final bool maintainState;

  /// The theme of the accordion
  final AccordionTheme theme;

  /// Constructor for the Accordion widget
  Accordion({
    required this.children,
    this.initialValue,
    // this.type = AccordionType.single,
    this.maintainState = false,
    required this.theme,
  });

  @override
  _AccordionState<T> createState() => _AccordionState<T>();
}

/// A stateful widget for the Accordion
class _AccordionState<T> extends State<Accordion<T>> {
  late List<T> _values = [];

  @override
  void initState() {
    super.initState();
    if (widget.initialValue != null) {
      _values.add(widget.initialValue as T);
    }
  }

  void _toggle(T value) {
    setState(() {
      // if (widget.type == AccordionType.single) {
      //   if (_values.contains(value)) {
      //     _values = [];
      //   } else {
      //     _values = [value];
      //   }
      // } else {
      if (_values.contains(value)) {
        _values.remove(value);
      } else {
        _values.add(value);
      }
      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: widget.theme.backgroundColor,
        borderRadius: widget.theme.borderRadius,
        border: Border.all(
          width: widget.theme.borderWidth,
          color: widget.theme.borderColor,
        ),
      ),
      padding: widget.theme.padding,
      margin: widget.theme.margin,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: widget.children.map((child) {
          return _AccordionItem(
            child: child,
            values: _values,
            toggle: _toggle,
            theme: widget.theme,
          );
        }).toList(),
      ),
    );
  }
}

/// A class for a single accordion item
class AccordionItem<T> {
  /// The value of the accordion item
  final T value;

  /// The title of the accordion item
  final String title;

  /// The child of the accordion item
  final String child;

  /// Constructor for the AccordionItem class
  AccordionItem({
    required this.value,
    required this.title,
    required this.child,
  });
}

/// A stateful widget for a single accordion item
class _AccordionItem<T> extends StatefulWidget {
  /// The child of the accordion item
  final AccordionItem<T> child;

  /// The list of values of the accordion
  final List<T> values;

  /// The function to toggle the accordion item
  final void Function(T) toggle;

  /// The theme of the accordion item
  final AccordionTheme theme;

  /// Constructor for the _AccordionItem widget
  _AccordionItem({
    required this.child,
    required this.values,
    required this.toggle,
    required this.theme,
  });

  @override
  _AccordionItemState<T> createState() => _AccordionItemState<T>();
}

/// A stateful widget for a single accordion item
class _AccordionItemState<T> extends State<_AccordionItem<T>>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        GestureDetector(
          onTap: () {
            widget.toggle(widget.child.value);
            setState(() {
              _expanded = !_expanded;
            });
            if (_expanded) {
              _animationController.forward();
            } else {
              _animationController.reverse();
            }
          },
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: widget.theme.titleBackgroundColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.child.title,
                  style: widget.theme.titleStyle,
                ),
                RotationTransition(
                  turns: _animation,
                  child: Icon(
                    Icons.arrow_drop_down,
                    color: widget.theme.arrowColor,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizeTransition(
          sizeFactor: _animation,
          axis: Axis.vertical,
          axisAlignment: 0,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: widget.theme.childBackgroundColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              widget.child.child,
              style: widget.theme.childStyle,
            ),
          ),
        ),
      ],
    );
  }
}

/// An enum for the type of accordion
// enum AccordionType {
//   single,
//   multiple,
// }

/// A theme for customizing the appearance of the accordion.
class AccordionTheme {
  /// The text style for the accordion titles.
  final TextStyle titleStyle;

  /// The text style for the accordion children.
  final TextStyle childStyle;

  /// The background color for the accordion titles.
  final Color titleBackgroundColor;

  /// The background color for the accordion children.
  final Color childBackgroundColor;

  /// The color of the accordion arrow.
  final Color arrowColor;

  /// The border radius of the accordion corners.
  final BorderRadius borderRadius;

  /// The width of the accordion border.
  final double borderWidth;

  /// The color of the accordion border.
  final Color borderColor;

  /// The background color of the accordion.
  final Color backgroundColor;

  /// The internal padding of the accordion.
  final EdgeInsets padding;

  /// The external margin of the accordion.
  final EdgeInsets margin;

  /// Constructor for the AccordionTheme class.
  /// Customize the appearance of the accordion by passing values for these properties.
  AccordionTheme({
    this.titleStyle = const TextStyle(),
    this.childStyle = const TextStyle(),
    this.titleBackgroundColor = Colors.white,
    this.childBackgroundColor = Colors.white,
    this.arrowColor = Colors.grey,
    this.borderRadius = const BorderRadius.all(Radius.circular(8)),
    this.borderWidth = 1,
    this.borderColor = Colors.grey,
    this.backgroundColor = Colors.white,
    this.padding = const EdgeInsets.all(0),
    this.margin = const EdgeInsets.all(0),
  });
}
