# hardware_info_kit

[![pub package](https://img.shields.io/pub/v/hardware_info_kit.svg)](https://pub.dev/packages/hardware_info_kit)

一个用于跨平台获取硬件信息的 Flutter 插件。

[English Documentation](README_EN.md)

## 功能特性

- 🖥️ **CPU 信息**：型号、厂商、架构、核心数、频率
- 💾 **内存信息**：总量、可用、已用内存和使用率
- 🎮 **GPU 信息**：型号、厂商、显存、驱动版本
- 💿 **磁盘信息**：总空间、可用空间、已用空间和驱动器数量
- 🔋 **电池信息**：电量、充电状态、健康度、温度
- 🌐 **网络信息**：IP 地址、MAC 地址、接口名称
- 🖼️ **操作系统**：名称、版本、架构、计算机名

## 支持平台

| 平台 | 支持状态 |
|----------|---------|
| Windows  | ✅ 完全支持 |
| Android  | ✅ 完全支持 |
| iOS      | 🚧 计划中 |
| Linux    | 🚧 计划中 |
| macOS    | 🚧 计划中 |
| Web      | ❌ 不支持 |

## 安装

在 `pubspec.yaml` 中添加依赖：

```yaml
dependencies:
  hardware_info_kit: ^1.0.0
```

然后运行：

```bash
flutter pub get
```

## 使用方法

### 获取所有系统信息

```dart
import 'package:hardware_info_kit/hardware_info_kit.dart';

// 一次性获取所有硬件信息
final systemInfo = await HardwareInfo.getSystemInfo();

print('CPU: ${systemInfo.cpu.model}');
print('内存: ${systemInfo.memory.totalMemoryGB} GB');
print('系统: ${systemInfo.os.name}');
```

### 获取特定硬件信息

```dart
// 仅获取 CPU 信息
final cpuInfo = await HardwareInfo.getCpuInfo();
print('CPU 型号: ${cpuInfo.model}');
print('核心数: ${cpuInfo.logicalCores}');

// 仅获取内存信息
final memoryInfo = await HardwareInfo.getMemoryInfo();
print('总内存: ${memoryInfo.totalMemoryGB?.toStringAsFixed(2)} GB');
print('可用: ${memoryInfo.availableMemoryGB?.toStringAsFixed(2)} GB');

// 仅获取 GPU 信息
final gpuInfo = await HardwareInfo.getGpuInfo();
print('GPU: ${gpuInfo.model}');

// 仅获取磁盘信息
final diskInfo = await HardwareInfo.getDiskInfo();
print('总空间: ${diskInfo.totalSpaceGB?.toStringAsFixed(2)} GB');

// 仅获取操作系统信息
final osInfo = await HardwareInfo.getOsInfo();
print('系统: ${osInfo.name} ${osInfo.version}');

// 获取电池信息（如果没有电池则返回 null）
final batteryInfo = await HardwareInfo.getBatteryInfo();
if (batteryInfo != null) {
  print('电量: ${batteryInfo.level}%');
  print('充电中: ${batteryInfo.isCharging}');
}
```

### 错误处理

```dart
try {
  final systemInfo = await HardwareInfo.getSystemInfo();
  // 使用 systemInfo
} on HardwareInfoException catch (e) {
  print('错误: ${e.message}');
} catch (e) {
  print('未知错误: $e');
}
```

## API 参考

### HardwareInfo

访问硬件信息的主类。

#### 方法

- `static Future<SystemInfo> getSystemInfo()` - 获取所有硬件信息
- `static Future<CpuInfo> getCpuInfo()` - 仅获取 CPU 信息
- `static Future<MemoryInfo> getMemoryInfo()` - 仅获取内存信息
- `static Future<GpuInfo> getGpuInfo()` - 仅获取 GPU 信息
- `static Future<DiskInfo> getDiskInfo()` - 仅获取磁盘信息
- `static Future<OsInfo> getOsInfo()` - 仅获取操作系统信息
- `static Future<BatteryInfo?> getBatteryInfo()` - 获取电池信息（无电池时返回 null）
- `static Future<NetworkInfo> getNetworkInfo()` - 获取网络信息

### 数据模型

#### SystemInfo - 完整系统硬件信息

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

#### CpuInfo - CPU/处理器信息

```dart
class CpuInfo {
  final String? model;          // 型号
  final String? vendor;         // 厂商
  final String? architecture;   // 架构
  final int? logicalCores;      // 逻辑核心数
  final int? physicalCores;     // 物理核心数
  final double? frequency;      // 频率（MHz）
  final int? cacheSize;         // 缓存大小（字节）
}
```

#### MemoryInfo - 内存信息

```dart
class MemoryInfo {
  final int? totalMemory;       // 总内存（字节）
  final int? availableMemory;   // 可用内存（字节）
  final int? usedMemory;        // 已用内存（字节）
  final double? usagePercentage; // 使用率（%）
  
  // 便捷 getter
  double? get totalMemoryGB;     // 总内存（GB）
  double? get availableMemoryGB; // 可用内存（GB）
  double? get usedMemoryGB;      // 已用内存（GB）
}
```

#### GpuInfo - GPU/显卡信息

```dart
class GpuInfo {
  final String? model;          // 型号
  final String? vendor;         // 厂商
  final int? memory;            // 显存（字节）
  final String? driverVersion;  // 驱动版本
  
  // 便捷 getter
  double? get memoryGB;         // 显存（GB）
}
```

#### DiskInfo - 磁盘/存储信息

```dart
class DiskInfo {
  final int? totalSpace;        // 总空间（字节）
  final int? freeSpace;         // 可用空间（字节）
  final int? usedSpace;         // 已用空间（字节）
  final int? driveCount;        // 驱动器数量
  
  // 便捷 getter
  double? get totalSpaceGB;     // 总空间（GB）
  double? get freeSpaceGB;      // 可用空间（GB）
  double? get usedSpaceGB;      // 已用空间（GB）
  double? get usagePercentage;  // 使用率（%）
}
```

#### OsInfo - 操作系统信息

```dart
class OsInfo {
  final String? name;           // 操作系统名称
  final String? version;        // 版本号
  final String? architecture;   // 架构
  final String? computerName;   // 计算机名称
  final String? kernel;         // 内核版本
}
```

#### BatteryInfo - 电池信息

```dart
class BatteryInfo {
  final int? level;             // 电量（0-100）
  final bool? isCharging;       // 是否充电中
  final String? health;         // 健康状态
  final double? temperature;    // 温度（摄氏度）
  final double? voltage;        // 电压（伏特）
}
```

#### NetworkInfo - 网络信息

```dart
class NetworkInfo {
  final String? ipv4;           // IPv4 地址
  final String? ipv6;           // IPv6 地址
  final String? macAddress;     // MAC 地址
  final String? interfaceName;  // 网络接口名称
}
```

## 示例应用

查看 [example](example) 目录获取完整示例应用。

运行示例：

```bash
cd example
flutter run -d windows  # 或 -d android
```

## 平台特定说明

### Windows

- 需要 Windows 10 或更高版本
- 某些信息可能需要管理员权限
- GPU 信息为基础信息（可通过 WMI 查询扩展）

### Android

- 需要 Android API level 21（Android 5.0）或更高版本
- 某些信息需要特定权限
- 电池信息包含温度和电压

## 扩展插件

本插件设计为易于扩展。添加新硬件信息：

1. 在 `HardwareInfo` 类中添加新方法
2. 创建对应的数据模型
3. 在 `windows/` 和 `android/` 目录实现平台特定代码
4. 更新 method channel 处理器

详见 [CONTRIBUTING.md](CONTRIBUTING.md)。

## 性能

- 所有方法都是异步非阻塞的
- 信息获取速度快（大多数系统 < 100ms）
- 建议缓存静态信息（CPU 型号等）

## 故障排查

### Windows

**问题**：找不到插件错误

**解决**：运行 `flutter clean` 并重新构建项目。

**问题**：编译错误

**解决**：确保安装了 Visual Studio 2019 或更高版本及 C++ 桌面开发工具。

### Android

**问题**：权限拒绝错误

**解决**：在 `AndroidManifest.xml` 中添加所需权限：

```xml
<uses-permission android:name="android.permission.BATTERY_STATS"/>
```

## 贡献

欢迎贡献！请阅读 [CONTRIBUTING.md](CONTRIBUTING.md) 了解详情。

## 许可证

MIT License - 详见 [LICENSE](LICENSE) 文件。

## 致谢

灵感来自 [hwinfo](https://github.com/lfreist/hwinfo) C++ 库。

## 更新日志

查看 [CHANGELOG.md](CHANGELOG.md) 了解版本历史。

## 文档

- [使用指南](USAGE_GUIDE.md) - 详细使用示例
- [API 文档](doc/API.md) - 完整 API 参考
- [贡献指南](CONTRIBUTING.md) - 如何贡献代码
- [提交计划](COMMIT_PLAN.md) - Git 提交策略
