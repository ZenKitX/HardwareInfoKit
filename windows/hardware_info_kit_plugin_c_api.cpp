#include "include/hardware_info_kit/hardware_info_kit_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "hardware_info_kit_plugin.h"

void HardwareInfoKitPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  hardware_info_kit::HardwareInfoKitPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
