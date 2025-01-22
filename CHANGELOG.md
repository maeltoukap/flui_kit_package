## 0.0.1

# Changelog

## [0.0.1] - 2025-01-22

### 🚀 New Features

- **PlanSwitcher**: Main widget for displaying and selecting subscription plans.
  - Supports monthly and annual periods with dynamic price adjustments.
  - Configurable annual discount percentage.
  - Includes animation to highlight the selected plan.
  - Customization options available via `PlanSwitcherTheme`.
- **PlanData**: New data class to represent subscription plans, including names, monthly/annual prices, popularity, description, and features.

### ✨ Enhancements

- Improved callback handling:
  - `onPlanSelected`: Returns the index of the selected plan.
  - `onPeriodChanged`: Notifies when the period changes (monthly/annual).
  - `onPressed`: Triggered when a plan is selected.
- Added optional footer (`footer`) for additional content below the plans.
- Enhanced customization options with dedicated themes:
  - `PlanSwitcherTheme`: Global styles for the widget.
  - `PlanChoicesTheme`: Theme for individual plans.
  - `ToggleTheme`: Customization for the period toggle button.

### 🐛 Bug Fixes

- Resolved an issue preventing optional widgets (`Widget?`) from being included in the children list.
- Fixed a problem with calling `void` methods on callbacks.

### ⚙️ Compatibility

- Tested with Flutter **3.13.0** and above.
- Compatible with Dart >= **3.0.0**.

### 📚 Documentation

- Added complete documentation for main classes and parameters.
- Included usage examples in the `example/` directory.

### 🛠️ Upgrade Instructions

1. Add the `PlanSwitcher` widget to your application and provide a list of `PlanData`.
2. Configure themes (`PlanSwitcherTheme`, `PlanChoicesTheme`, `ToggleTheme`) to match your app’s style.
3. Implement callbacks to handle events such as plan selection, period changes, and button actions.
