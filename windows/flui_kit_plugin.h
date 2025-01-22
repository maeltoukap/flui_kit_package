#ifndef FLUTTER_PLUGIN_FLUI_KIT_PLUGIN_H_
#define FLUTTER_PLUGIN_FLUI_KIT_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace flui_kit {

class FluiKitPlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  FluiKitPlugin();

  virtual ~FluiKitPlugin();

  // Disallow copy and assign.
  FluiKitPlugin(const FluiKitPlugin&) = delete;
  FluiKitPlugin& operator=(const FluiKitPlugin&) = delete;

  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace flui_kit

#endif  // FLUTTER_PLUGIN_FLUI_KIT_PLUGIN_H_
