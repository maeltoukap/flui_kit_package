// Example Usage
import 'package:flui_kit/flui_kit.dart';
import 'package:flutter/material.dart';

class QueedNotificationExample extends StatelessWidget {
  final NotificationManager _notificationManager = NotificationManager();

  QueedNotificationExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: ElevatedButton(
              onPressed: () {
                _notificationManager.show(
                  QueedNotification(
                    message: "Bottom Right Notification",
                    type: NotificationType.success,
                  ),
                );
              },
              child: const Text('Bottom Right Notification'),
            ),
          ),
          QueedNotificationWidget(
            notificationStream: _notificationManager.notificationStream,
            position: NotificationPosition.bottom,
          ),
        ],
      ),
    );
  }
}
