import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flui_kit_platform_interface.dart';

/// An implementation of [FluiKitPlatform] that uses method channels.
class MethodChannelFluiKit extends FluiKitPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flui_kit');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
