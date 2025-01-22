//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <flui_kit/flui_kit_plugin.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) flui_kit_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "FluiKitPlugin");
  flui_kit_plugin_register_with_registrar(flui_kit_registrar);
}
