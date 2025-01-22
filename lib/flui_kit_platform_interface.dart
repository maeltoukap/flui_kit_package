import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flui_kit_method_channel.dart';

abstract class FluiKitPlatform extends PlatformInterface {
  /// Constructs a FluiKitPlatform.
  FluiKitPlatform() : super(token: _token);

  static final Object _token = Object();

  static FluiKitPlatform _instance = MethodChannelFluiKit();

  /// The default instance of [FluiKitPlatform] to use.
  ///
  /// Defaults to [MethodChannelFluiKit].
  static FluiKitPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FluiKitPlatform] when
  /// they register themselves.
  static set instance(FluiKitPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
