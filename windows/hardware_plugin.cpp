#include "hardware_plugin.h"

#include <windows.h>
#include <sysinfoapi.h>
#include <powerbase.h>

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>
#include <flutter/standard_method_codec.h>

#include <memory>
#include <sstream>
#include <string>

namespace hardware_monitor {

void HardwarePlugin::RegisterWithRegistrar(
    flutter::PluginRegistrarWindows* registrar) {
  auto channel =
      std::make_unique<flutter::MethodChannel<flutter::EncodableValue>>(
          registrar->messenger(), "hardware_info_kit",
          &flutter::StandardMethodCodec::GetInstance());

  auto plugin = std::make_unique<HardwarePlugin>();

  channel->SetMethodCallHandler(
      [plugin_pointer = plugin.get()](const auto& call, auto result) {
        plugin_pointer->HandleMethodCall(call, std::move(result));
      });

  // Store plugin to keep it alive
  static std::unique_ptr<HardwarePlugin> plugin_instance = std::move(plugin);
}

HardwarePlugin::HardwarePlugin() {}

HardwarePlugin::~HardwarePlugin() {}

void HardwarePlugin::HandleMethodCall(
    const flutter::MethodCall<flutter::EncodableValue>& method_call,
    std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result) {
  if (method_call.method_name() == "getSystemInfo") {
    result->Success(flutter::EncodableValue(GetHardwareInfo()));
  } else if (method_call.method_name() == "getCpuInfo") {
    result->Success(flutter::EncodableValue(GetCpuInfo()));
  } else if (method_call.method_name() == "getMemoryInfo") {
    result->Success(flutter::EncodableValue(GetMemoryInfo()));
  } else if (method_call.method_name() == "getGpuInfo") {
    result->Success(flutter::EncodableValue(GetGpuInfo()));
  } else if (method_call.method_name() == "getDiskInfo") {
    result->Success(flutter::EncodableValue(GetDiskInfo()));
  } else if (method_call.method_name() == "getOsInfo") {
    result->Success(flutter::EncodableValue(GetOsInfo()));
  } else if (method_call.method_name() == "getBatteryInfo") {
    result->Success(flutter::EncodableValue(GetBatteryInfo()));
  } else if (method_call.method_name() == "getNetworkInfo") {
    result->Success(flutter::EncodableValue(GetNetworkInfo()));
  } else {
    result->NotImplemented();
  }
}

flutter::EncodableMap HardwarePlugin::GetHardwareInfo() {
  flutter::EncodableMap info;
  info[flutter::EncodableValue("os")] = flutter::EncodableValue(GetOsInfo());
  info[flutter::EncodableValue("cpu")] = flutter::EncodableValue(GetCpuInfo());
  info[flutter::EncodableValue("memory")] = flutter::EncodableValue(GetMemoryInfo());
  info[flutter::EncodableValue("gpu")] = flutter::EncodableValue(GetGpuInfo());
  info[flutter::EncodableValue("disk")] = flutter::EncodableValue(GetDiskInfo());
  
  auto battery = GetBatteryInfo();
  if (!battery.empty()) {
    info[flutter::EncodableValue("battery")] = flutter::EncodableValue(battery);
  }
  
  return info;
}

flutter::EncodableMap HardwarePlugin::GetCpuInfo() {
  flutter::EncodableMap cpu_info;
  
  SYSTEM_INFO sys_info;
  GetSystemInfo(&sys_info);
  
  cpu_info[flutter::EncodableValue("Logical Cores")] = 
      flutter::EncodableValue(static_cast<int>(sys_info.dwNumberOfProcessors));
  
  std::string arch = "Unknown";
  if (sys_info.wProcessorArchitecture == PROCESSOR_ARCHITECTURE_AMD64) {
    arch = "x64";
  } else if (sys_info.wProcessorArchitecture == PROCESSOR_ARCHITECTURE_INTEL) {
    arch = "x86";
  } else if (sys_info.wProcessorArchitecture == PROCESSOR_ARCHITECTURE_ARM64) {
    arch = "ARM64";
  }
  cpu_info[flutter::EncodableValue("Architecture")] = flutter::EncodableValue(arch);
  
  // Get CPU brand string
  int cpu_info_array[4] = {-1};
  char cpu_brand[0x40];
  __cpuid(cpu_info_array, 0x80000000);
  unsigned int n_ex_ids = cpu_info_array[0];
  
  memset(cpu_brand, 0, sizeof(cpu_brand));
  
  if (n_ex_ids >= 0x80000004) {
    __cpuid(cpu_info_array, 0x80000002);
    memcpy(cpu_brand, cpu_info_array, sizeof(cpu_info_array));
    __cpuid(cpu_info_array, 0x80000003);
    memcpy(cpu_brand + 16, cpu_info_array, sizeof(cpu_info_array));
    __cpuid(cpu_info_array, 0x80000004);
    memcpy(cpu_brand + 32, cpu_info_array, sizeof(cpu_info_array));
  }
  
  cpu_info[flutter::EncodableValue("Model")] = flutter::EncodableValue(std::string(cpu_brand));
  
  return cpu_info;
}

flutter::EncodableMap HardwarePlugin::GetMemoryInfo() {
  flutter::EncodableMap memory_info;
  
  MEMORYSTATUSEX mem_status;
  mem_status.dwLength = sizeof(mem_status);
  GlobalMemoryStatusEx(&mem_status);
  
  double total_gb = mem_status.ullTotalPhys / (1024.0 * 1024.0 * 1024.0);
  double available_gb = mem_status.ullAvailPhys / (1024.0 * 1024.0 * 1024.0);
  double used_gb = total_gb - available_gb;
  
  std::ostringstream total_stream, available_stream, used_stream;
  total_stream.precision(2);
  available_stream.precision(2);
  used_stream.precision(2);
  total_stream << std::fixed << total_gb << " GB";
  available_stream << std::fixed << available_gb << " GB";
  used_stream << std::fixed << used_gb << " GB";
  
  memory_info[flutter::EncodableValue("Total Memory")] = flutter::EncodableValue(total_stream.str());
  memory_info[flutter::EncodableValue("Available Memory")] = flutter::EncodableValue(available_stream.str());
  memory_info[flutter::EncodableValue("Used Memory")] = flutter::EncodableValue(used_stream.str());
  memory_info[flutter::EncodableValue("Usage")] = 
      flutter::EncodableValue(std::to_string(mem_status.dwMemoryLoad) + "%");
  
  return memory_info;
}

flutter::EncodableMap HardwarePlugin::GetGpuInfo() {
  flutter::EncodableMap gpu_info;
  
  gpu_info[flutter::EncodableValue("Vendor")] = flutter::EncodableValue("Detecting...");
  gpu_info[flutter::EncodableValue("Model")] = flutter::EncodableValue("Requires WMI query");
  
  return gpu_info;
}

flutter::EncodableMap HardwarePlugin::GetOsInfo() {
  flutter::EncodableMap os_info;
  
  os_info[flutter::EncodableValue("System")] = flutter::EncodableValue("Windows");
  
  char computer_name[MAX_COMPUTERNAME_LENGTH + 1];
  DWORD size = sizeof(computer_name);
  GetComputerNameA(computer_name, &size);
  
  os_info[flutter::EncodableValue("Computer Name")] = flutter::EncodableValue(std::string(computer_name));
  os_info[flutter::EncodableValue("Architecture")] = flutter::EncodableValue(sizeof(void*) == 8 ? "64-bit" : "32-bit");
  
  return os_info;
}

flutter::EncodableMap HardwarePlugin::GetDiskInfo() {
  flutter::EncodableMap disk_info;
  
  DWORD drives = GetLogicalDrives();
  int drive_count = 0;
  
  for (int i = 0; i < 26; i++) {
    if (drives & (1 << i)) {
      drive_count++;
    }
  }
  
  disk_info[flutter::EncodableValue("Drive Count")] = flutter::EncodableValue(drive_count);
  
  char drive_letter[4] = "C:\\";
  ULARGE_INTEGER free_bytes, total_bytes, total_free_bytes;
  
  if (GetDiskFreeSpaceExA(drive_letter, &free_bytes, &total_bytes, &total_free_bytes)) {
    double total_gb = total_bytes.QuadPart / (1024.0 * 1024.0 * 1024.0);
    double free_gb = free_bytes.QuadPart / (1024.0 * 1024.0 * 1024.0);
    
    std::ostringstream total_stream, free_stream;
    total_stream.precision(2);
    free_stream.precision(2);
    total_stream << std::fixed << total_gb << " GB";
    free_stream << std::fixed << free_gb << " GB";
    
    disk_info[flutter::EncodableValue("C: Total")] = flutter::EncodableValue(total_stream.str());
    disk_info[flutter::EncodableValue("C: Free")] = flutter::EncodableValue(free_stream.str());
  }
  
  return disk_info;
}

flutter::EncodableMap HardwarePlugin::GetBatteryInfo() {
  flutter::EncodableMap battery_info;
  
  SYSTEM_POWER_STATUS power_status;
  if (GetSystemPowerStatus(&power_status)) {
    if (power_status.BatteryFlag != 128) {  // 128 means no battery
      battery_info[flutter::EncodableValue("Battery Level")] = 
          flutter::EncodableValue(std::to_string(power_status.BatteryLifePercent) + "%");
      battery_info[flutter::EncodableValue("Charging Status")] = 
          flutter::EncodableValue(power_status.ACLineStatus == 1 ? "Charging" : "Not Charging");
    }
  }
  
  return battery_info;
}

}  // namespace hardware_monitor


flutter::EncodableMap HardwarePlugin::GetNetworkInfo() {
  flutter::EncodableMap network_info;
  
  // Basic network info - can be extended with WMI queries
  network_info[flutter::EncodableValue("Interface")] = flutter::EncodableValue("Not implemented");
  
  return network_info;
}
