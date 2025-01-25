import 'package:flutter_test/flutter_test.dart';
import 'package:flui_kit/flui_kit.dart';
import 'package:flui_kit/flui_kit_platform_interface.dart';
import 'package:flui_kit/flui_kit_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFluiKitPlatform
    with MockPlatformInterfaceMixin
    implements FluiKitPlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final FluiKitPlatform initialPlatform = FluiKitPlatform.instance;

  test('$MethodChannelFluiKit is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFluiKit>());
  });

  test('getPlatformVersion', () async {
    FluiKit fluiKitPlugin = FluiKit();
    MockFluiKitPlatform fakePlatform = MockFluiKitPlatform();
    FluiKitPlatform.instance = fakePlatform;

    expect(await fluiKitPlugin.getPlatformVersion(), '42');
  });
}
