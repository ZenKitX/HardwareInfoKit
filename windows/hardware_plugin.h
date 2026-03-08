#ifndef HARDWARE_PLUGIN_H_
#define HARDWARE_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>
#include <flutter/standard_method_codec.h>

#include <memory>
#include <string>

namespace hardware_monitor {

class HardwarePlugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows* registrar);

  HardwarePlugin();
  virtual ~HardwarePlugin();

  HardwarePlugin(const HardwarePlugin&) = delete;
  HardwarePlugin& operator=(const HardwarePlugin&) = delete;

  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue>& method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);

 private:
  flutter::EncodableMap GetHardwareInfo();
  flutter::EncodableMap GetCpuInfo();
  flutter::EncodableMap GetMemoryInfo();
  flutter::EncodableMap GetGpuInfo();
  flutter::EncodableMap GetOsInfo();
  flutter::EncodableMap GetDiskInfo();
  flutter::EncodableMap GetBatteryInfo();
  flutter::EncodableMap GetNetworkInfo();
};

}  // namespace hardware_monitor

#endif  // HARDWARE_PLUGIN_H_
