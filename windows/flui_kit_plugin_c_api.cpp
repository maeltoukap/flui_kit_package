#include "include/flui_kit/flui_kit_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "flui_kit_plugin.h"

void FluiKitPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  flui_kit::FluiKitPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
