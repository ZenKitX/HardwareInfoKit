#include "hardware_info_kit_plugin.h"
#include "hardware_plugin.h"

#include <windows.h>

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>
#include <flutter/standard_method_codec.h>

#include <memory>

namespace hardware_info_kit {

// static
void HardwareInfoKitPlugin::RegisterWithRegistrar(
    flutter::PluginRegistrarWindows *registrar) {
  // Use our HardwarePlugin implementation
  hardware_monitor::HardwarePlugin::RegisterWithRegistrar(registrar);
}

HardwareInfoKitPlugin::HardwareInfoKitPlugin() {}

HardwareInfoKitPlugin::~HardwareInfoKitPlugin() {}

void HardwareInfoKitPlugin::HandleMethodCall(
    const flutter::MethodCall<flutter::EncodableValue> &method_call,
    std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result) {
  result->NotImplemented();
}

}  // namespace hardware_info_kit
