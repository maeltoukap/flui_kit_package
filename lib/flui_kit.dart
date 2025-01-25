import 'flui_kit_platform_interface.dart';

class FluiKit {
  Future<String?> getPlatformVersion() {
    return FluiKitPlatform.instance.getPlatformVersion();
  }
}
