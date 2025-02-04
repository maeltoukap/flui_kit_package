import 'package:flutter/material.dart';

class QueedNotification {
  final String message;
  final NotificationType type;
  // final NotificationPosition position;
  final Widget? icon;
  final VoidCallback? onTap;
  final Duration duration;

  QueedNotification({
    required this.message,
    this.type = NotificationType.info,
    // this.position = NotificationPosition.top,
    this.icon,
    this.onTap,
    this.duration = const Duration(seconds: 3),
  });
}

enum NotificationPosition {
  top,
  topLeft,
  topRight,
  bottom,
  // bottomLeft,
  // bottomRight
}

enum NotificationType { success, error, warning, info }
