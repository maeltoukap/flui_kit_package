import 'dart:async';
import 'dart:collection';
import 'package:flui_kit/src/widgets/queed_notification/queed_notification_exports.dart';
import 'package:flutter/material.dart';

/// A singleton class that manages the display of notifications throughout the app.
class NotificationManager {
  // Singleton instance
  static final NotificationManager _instance = NotificationManager._internal();
  factory NotificationManager() => _instance;
  NotificationManager._internal();

  /// Stream controller for broadcasting notifications
  final _notificationController =
      StreamController<QueedNotification>.broadcast();

  /// Public stream that can be listened to for notification updates
  Stream<QueedNotification> get notificationStream =>
      _notificationController.stream;

  /// Shows a notification by adding it to the stream
  void show(QueedNotification notification) {
    _notificationController.add(notification);
  }

  /// Closes the stream controller
  void dispose() {
    _notificationController.close();
  }
}

/// Widget that displays notifications in a queue with animations
class QueedNotificationWidget extends StatefulWidget {
  final Stream<QueedNotification> notificationStream;
  final NotificationPosition position;

  const QueedNotificationWidget({
    Key? key,
    required this.notificationStream,
    this.position = NotificationPosition.top,
  }) : super(key: key);

  @override
  QueedNotificationWidgetState createState() => QueedNotificationWidgetState();
}

/// State class for QueedNotificationWidget that handles the notification queue and animations
class QueedNotificationWidgetState extends State<QueedNotificationWidget>
    with SingleTickerProviderStateMixin {
  final Queue<QueedNotification> _notificationQueue = Queue();
  QueedNotification? _currentNotification;
  late AnimationController _animationController;
  late Animation<Offset> _offsetAnimation;
  StreamSubscription? _streamSubscription;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    )..value = 0.0;

    _offsetAnimation = Tween<Offset>(
      begin: _getInitialOffset(),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _streamSubscription = widget.notificationStream.listen(_handleNotification);
  }

  Offset _getInitialOffset() {
    switch (widget.position) {
      case NotificationPosition.top:
        return const Offset(0, -1);
      case NotificationPosition.topLeft:
        return const Offset(-1, 0);
      case NotificationPosition.topRight:
        return const Offset(1, 0);
      case NotificationPosition.bottom:
        return const Offset(0, 1);
      // case NotificationPosition.bottomLeft:
      //   return const Offset(-1, 0);
      // case NotificationPosition.bottomRight:
      //   return const Offset(1, 0);
    }
  }

  void _handleNotification(QueedNotification notification) {
    setState(() {
      _notificationQueue.add(notification);
    });

    if (_currentNotification == null) {
      _processNextNotification();
    }
  }

  void _processNextNotification() {
    if (_notificationQueue.isEmpty) return;

    setState(() {
      _currentNotification = _notificationQueue.removeFirst();
    });

    // _animationController.reset();
    // Future.delayed(const Duration(microseconds: 50), () {
    _animationController.forward();
    // });

    _timer?.cancel();
    _timer = Timer(_currentNotification!.duration, () {
      _dismissCurrentNotification();
    });
  }

  void _dismissCurrentNotification() {
    _animationController.reverse().then((_) {
      setState(() {
        _currentNotification = null;
      });
      _processNextNotification();
    });
  }

  void _showNextNotification() {
    if (_currentNotification == null && _notificationQueue.isNotEmpty) {
      setState(() {
        _currentNotification = _notificationQueue.removeFirst();
      });
      _animationController.forward();

      Future.delayed(_currentNotification!.duration, () {
        _dismissNotification();
      });
    }
  }

  void _dismissNotification() {
    _animationController.reverse().then((_) {
      setState(() {
        _currentNotification = null;
      });
      _showNextNotification();
    });
  }

  Color _getColorForType(NotificationType type) {
    switch (type) {
      case NotificationType.success:
        return Colors.green;
      case NotificationType.error:
        return Colors.red;
      case NotificationType.warning:
        return Colors.orange;
      case NotificationType.info:
        return Colors.blue;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_currentNotification == null) return const SizedBox.shrink();

    return Positioned(
      top: _getPositionedTop(),
      bottom: _getPositionedBottom(),
      left: _getPositionedLeft(),
      right: _getPositionedRight(),
      child: SlideTransition(
        position: _offsetAnimation,
        child: GestureDetector(
          onTap: () {
            _currentNotification?.onTap?.call();
            _dismissNotification();
          },
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Card(
              color: _getColorForType(_currentNotification!.type),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (_currentNotification!.icon != null)
                      Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: _currentNotification!.icon!,
                      ),
                    Text(
                      _currentNotification!.message,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  double? _getPositionedTop() {
    switch (widget.position) {
      case NotificationPosition.top:
      case NotificationPosition.topLeft:
      case NotificationPosition.topRight:
        return 50;
      default:
        return null;
    }
  }

  double? _getPositionedBottom() {
    switch (widget.position) {
      case NotificationPosition.bottom:
        // case NotificationPosition.bottomLeft:
        // case NotificationPosition.bottomRight:
        return 50;
      default:
        return null;
    }
  }

  double? _getPositionedLeft() {
    switch (widget.position) {
      case NotificationPosition.top:
      case NotificationPosition.bottom:
      case NotificationPosition.topLeft:
      case NotificationPosition.topRight:
        // case NotificationPosition.bottomLeft:
        // case NotificationPosition.bottomRight:
        return 16;
    }
  }

  double? _getPositionedRight() {
    switch (widget.position) {
      case NotificationPosition.top:
      case NotificationPosition.bottom:
      case NotificationPosition.topLeft:
      case NotificationPosition.topRight:
        // case NotificationPosition.bottomLeft:
        // case NotificationPosition.bottomRight:
        return 16;
    }
  }

  @override
  void dispose() {
    _streamSubscription?.cancel();
    _animationController.dispose();
    _timer?.cancel();
    super.dispose();
  }
}
