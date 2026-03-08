# hardware_info_kit

[![pub package](https://img.shields.io/pub/v/hardware_info_kit.svg)](https://pub.dev/packages/hardware_info_kit)

A Flutter plugin for retrieving hardware information across multiple platforms.

## Features

- **CPU Information**: Model, vendor, architecture, cores, frequency
- **Memory Information**: Total, available, used memory and usage percentage
- **GPU Information**: Model, vendor, memory, driver version
- **Disk Information**: Total, free, used space and drive count
- **Battery Information**: Level, charging status, health, temperature
- **Network Information**: IP addresses, MAC address, interface name
- **Operating System**: Name, version, architecture, computer name

## Supported Platforms

| Platform | Support |
|----------|---------|
| Windows  | Fully supported |
| Android  | Fully supported |
| iOS      | Planned |
| Linux    | Planned |
| macOS    | Planned |
| Web      | Not supported |

## Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  hardware_info_kit: ^1.0.0
```

Then run:

```bash
flutter pub get
```

## Usage

### Get All System Information

```dart
import 'package:hardware_info_kit/hardware_info_kit.dart';

// Get all hardware information at once
final systemInfo = await HardwareInfo.getSystemInfo();

print('CPU: ${systemInfo.cpu.model}');
print('Memory: ${systemInfo.memory.totalMemoryGB} GB');
print('OS: ${systemInfo.os.name}');
```

### Get Specific Hardware Information

```dart
// Get only CPU information
final cpuInfo = await HardwareInfo.getCpuInfo();
print('CPU Model: ${cpuInfo.model}');
print('Cores: ${cpuInfo.logicalCores}');

// Get only memory information
final memoryInfo = await HardwareInfo.getMemoryInfo();
print('Total Memory: ${memoryInfo.totalMemoryGB?.toStringAsFixed(2)} GB');
print('Available: ${memoryInfo.availableMemoryGB?.toStringAsFixed(2)} GB');

// Get only GPU information
final gpuInfo = await HardwareInfo.getGpuInfo();
print('GPU: ${gpuInfo.model}');

// Get only disk information
final diskInfo = await HardwareInfo.getDiskInfo();
print('Total Space: ${diskInfo.totalSpaceGB?.toStringAsFixed(2)} GB');

// Get only OS information
final osInfo = await HardwareInfo.getOsInfo();
print('OS: ${osInfo.name} ${osInfo.version}');

// Get battery information (returns null if no battery)
final batteryInfo = await HardwareInfo.getBatteryInfo();
if (batteryInfo != null) {
  print('Battery: ${batteryInfo.level}%');
  print('Charging: ${batteryInfo.isCharging}');
}
```

### Error Handling

```dart
try {
  final systemInfo = await HardwareInfo.getSystemInfo();
  // Use systemInfo
} on HardwareInfoException catch (e) {
  print('Error: ${e.message}');
} catch (e) {
  print('Unexpected error: $e');
}
```

## API Reference

### HardwareInfo

Main class for accessing hardware information.

#### Methods

- `static Future<SystemInfo> getSystemInfo()` - Get all hardware information
- `static Future<CpuInfo> getCpuInfo()` - Get CPU information only
- `static Future<MemoryInfo> getMemoryInfo()` - Get memory information only
- `static Future<GpuInfo> getGpuInfo()` - Get GPU information only
- `static Future<DiskInfo> getDiskInfo()` - Get disk information only
- `static Future<OsInfo> getOsInfo()` - Get OS information only
- `static Future<BatteryInfo?> getBatteryInfo()` - Get battery information (null if no battery)
- `static Future<NetworkInfo> getNetworkInfo()` - Get network information

### Data Models

#### SystemInfo

Complete system hardware information.

```dart
class SystemInfo {
  final OsInfo os;
  final CpuInfo cpu;
  final MemoryInfo memory;
  final GpuInfo gpu;
  final DiskInfo disk;
  final BatteryInfo? battery;
  final NetworkInfo? network;
}
```

#### CpuInfo

CPU/Processor information.

```dart
class CpuInfo {
  final String? model;
  final String? vendor;
  final String? architecture;
  final int? logicalCores;
  final int? physicalCores;
  final double? frequency; // in MHz
  final int? cacheSize; // in bytes
}
```

#### MemoryInfo

Memory (RAM) information.

```dart
class MemoryInfo {
  final int? totalMemory; // in bytes
  final int? availableMemory; // in bytes
  final int? usedMemory; // in bytes
  final double? usagePercentage;
  
  // Convenience getters
  double? get totalMemoryGB;
  double? get availableMemoryGB;
  double? get usedMemoryGB;
}
```

#### GpuInfo

GPU/Graphics card information.

```dart
class GpuInfo {
  final String? model;
  final String? vendor;
  final int? memory; // in bytes
  final String? driverVersion;
  
  // Convenience getter
  double? get memoryGB;
}
```

#### DiskInfo

Disk/Storage information.

```dart
class DiskInfo {
  final int? totalSpace; // in bytes
  final int? freeSpace; // in bytes
  final int? usedSpace; // in bytes
  final int? driveCount;
  
  // Convenience getters
  double? get totalSpaceGB;
  double? get freeSpaceGB;
  double? get usedSpaceGB;
  double? get usagePercentage;
}
```

#### OsInfo

Operating System information.

```dart
class OsInfo {
  final String? name;
  final String? version;
  final String? architecture;
  final String? computerName;
  final String? kernel;
}
```

#### BatteryInfo

Battery information.

```dart
class BatteryInfo {
  final int? level; // 0-100
  final bool? isCharging;
  final String? health;
  final double? temperature; // in Celsius
  final double? voltage; // in Volts
}
```

#### NetworkInfo

Network information.

```dart
class NetworkInfo {
  final String? ipv4;
  final String? ipv6;
  final String? macAddress;
  final String? interfaceName;
}
```

## Example

See the [example](example) directory for a complete sample app.

To run the example:

```bash
cd example
flutter run -d windows  # or -d android
```

## Platform-Specific Notes

### Windows

- Requires Windows 10 or later
- Some information may require administrator privileges
- GPU information is basic (WMI queries can be added for more details)

### Android

- Requires Android API level 21 (Android 5.0) or later
- Some information requires specific permissions
- Battery information includes temperature and voltage

## Extending the Plugin

This plugin is designed to be easily extensible. To add new hardware information:

1. Add new methods to `HardwareInfo` class
2. Create corresponding data models
3. Implement platform-specific code in `windows/` and `android/` directories
4. Update the method channel handlers

See [CONTRIBUTING.md](CONTRIBUTING.md) for detailed instructions.

## Performance

- All methods are asynchronous and non-blocking
- Information retrieval is fast (< 100ms on most systems)
- Consider caching results for static information (CPU model, etc.)

## Troubleshooting

### Windows

**Issue**: Plugin not found error

**Solution**: Make sure to run `flutter clean` and rebuild the project.

**Issue**: Compilation errors

**Solution**: Ensure Visual Studio 2019 or later is installed with C++ desktop development tools.

### Android

**Issue**: Permission denied errors

**Solution**: Add required permissions to `AndroidManifest.xml`:

```xml
<uses-permission android:name="android.permission.BATTERY_STATS"/>
```

## Contributing

Contributions are welcome! Please read [CONTRIBUTING.md](CONTRIBUTING.md) for details.

## License

MIT License - see [LICENSE](LICENSE) file for details.

## Credits

Inspired by [hwinfo](https://github.com/lfreist/hwinfo) C++ library.

## Changelog

See [CHANGELOG.md](CHANGELOG.md) for version history.
