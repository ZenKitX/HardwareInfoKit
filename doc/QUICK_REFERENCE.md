# hardware_info_kit 快速参考

本文档提供 hardware_info_kit 的快速参考指南。

## 快速开始

### 安装

```yaml
dependencies:
  hardware_info_kit: ^1.0.0
```

```bash
flutter pub get
```

### 基本使用

```dart
import 'package:hardware_info_kit/hardware_info_kit.dart';

// 获取所有硬件信息
final systemInfo = await HardwareInfo.getSystemInfo();

// 获取特定硬件信息
final cpuInfo = await HardwareInfo.getCpuInfo();
final memoryInfo = await HardwareInfo.getMemoryInfo();
```

---

## API 速查

### 主要方法

| 方法 | 返回类型 | 说明 |
|------|---------|------|
| `getSystemInfo()` | `Future<SystemInfo>` | 获取所有硬件信息 |
| `getCpuInfo()` | `Future<CpuInfo>` | 获取 CPU 信息 |
| `getMemoryInfo()` | `Future<MemoryInfo>` | 获取内存信息 |
| `getGpuInfo()` | `Future<GpuInfo>` | 获取 GPU 信息 |
| `getDiskInfo()` | `Future<DiskInfo>` | 获取磁盘信息 |
| `getOsInfo()` | `Future<OsInfo>` | 获取操作系统信息 |
| `getBatteryInfo()` | `Future<BatteryInfo?>` | 获取电池信息 |
| `getNetworkInfo()` | `Future<NetworkInfo>` | 获取网络信息 |

---

## 数据模型速查

### CpuInfo

```dart
class CpuInfo {
  final String? model;           // CPU 型号
  final String? vendor;          // 制造商
  final String? architecture;    // 架构
  final int? logicalCores;       // 逻辑核心数
  final int? physicalCores;      // 物理核心数
  final double? frequency;       // 频率 (MHz)
  final int? cacheSize;          // 缓存大小 (bytes)
}
```

### MemoryInfo

```dart
class MemoryInfo {
  final int? totalMemory;        // 总内存 (bytes)
  final int? availableMemory;    // 可用内存 (bytes)
  final int? usedMemory;         // 已用内存 (bytes)
  final double? usagePercentage; // 使用率 (%)
  
  // 便捷 getter
  double? get totalMemoryGB;
  double? get availableMemoryGB;
  double? get usedMemoryGB;
}
```

### GpuInfo

```dart
class GpuInfo {
  final String? model;           // GPU 型号
  final String? vendor;          // 制造商
  final int? memory;             // 显存 (bytes)
  final String? driverVersion;   // 驱动版本
  
  // 便捷 getter
  double? get memoryGB;
}
```

### DiskInfo

```dart
class DiskInfo {
  final int? totalSpace;         // 总空间 (bytes)
  final int? freeSpace;          // 可用空间 (bytes)
  final int? usedSpace;          // 已用空间 (bytes)
  final int? driveCount;         // 驱动器数量
  
  // 便捷 getter
  double? get totalSpaceGB;
  double? get freeSpaceGB;
  double? get usedSpaceGB;
  double? get usagePercentage;
}
```

### OsInfo

```dart
class OsInfo {
  final String? name;            // 操作系统名称
  final String? version;         // 版本号
  final String? architecture;    // 架构
  final String? computerName;    // 计算机名称
  final String? kernel;          // 内核版本
}
```

### BatteryInfo

```dart
class BatteryInfo {
  final int? level;              // 电量 (0-100)
  final bool? isCharging;        // 是否充电中
  final String? health;          // 健康状态
  final double? temperature;     // 温度 (摄氏度)
  final double? voltage;         // 电压 (伏特)
}
```

### NetworkInfo

```dart
class NetworkInfo {
  final String? ipv4;            // IPv4 地址
  final String? ipv6;            // IPv6 地址
  final String? macAddress;      // MAC 地址
  final String? interfaceName;   // 网络接口名称
}
```

---

## 常用代码片段

### 显示 CPU 信息

```dart
final cpuInfo = await HardwareInfo.getCpuInfo();
print('CPU 型号: ${cpuInfo.model}');
print('核心数: ${cpuInfo.logicalCores}');
print('频率: ${cpuInfo.frequency} MHz');
```

### 显示内存信息

```dart
final memoryInfo = await HardwareInfo.getMemoryInfo();
print('总内存: ${memoryInfo.totalMemoryGB?.toStringAsFixed(2)} GB');
print('可用内存: ${memoryInfo.availableMemoryGB?.toStringAsFixed(2)} GB');
print('使用率: ${memoryInfo.usagePercentage?.toStringAsFixed(1)}%');
```

### 显示磁盘信息

```dart
final diskInfo = await HardwareInfo.getDiskInfo();
print('总空间: ${diskInfo.totalSpaceGB?.toStringAsFixed(2)} GB');
print('可用空间: ${diskInfo.freeSpaceGB?.toStringAsFixed(2)} GB');
print('使用率: ${diskInfo.usagePercentage?.toStringAsFixed(1)}%');
```

### 显示电池信息

```dart
final batteryInfo = await HardwareInfo.getBatteryInfo();
if (batteryInfo != null) {
  print('电量: ${batteryInfo.level}%');
  print('充电中: ${batteryInfo.isCharging}');
  print('温度: ${batteryInfo.temperature}°C');
} else {
  print('没有电池');
}
```

### 错误处理

```dart
try {
  final systemInfo = await HardwareInfo.getSystemInfo();
  // 使用 systemInfo
} on HardwareInfoException catch (e) {
  print('获取硬件信息失败: ${e.message}');
} catch (e) {
  print('未知错误: $e');
}
```

### 在 Widget 中使用

```dart
class HardwareInfoWidget extends StatefulWidget {
  @override
  State<HardwareInfoWidget> createState() => _HardwareInfoWidgetState();
}

class _HardwareInfoWidgetState extends State<HardwareInfoWidget> {
  SystemInfo? _systemInfo;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadHardwareInfo();
  }

  Future<void> _loadHardwareInfo() async {
    try {
      final systemInfo = await HardwareInfo.getSystemInfo();
      setState(() {
        _systemInfo = systemInfo;
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _loading = false;
      });
      // 处理错误
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return CircularProgressIndicator();
    }
    
    return Column(
      children: [
        Text('CPU: ${_systemInfo?.cpu.model}'),
        Text('内存: ${_systemInfo?.memory.totalMemoryGB} GB'),
      ],
    );
  }
}
```

---

## 平台支持

| 平台 | 状态 | 说明 |
|------|------|------|
| Windows | ✅ 完全支持 | Windows 10+ |
| Android | ✅ 完全支持 | API 21+ |
| iOS | 🚧 计划中 | 未来版本 |
| Linux | 🚧 计划中 | 未来版本 |
| macOS | 🚧 计划中 | 未来版本 |
| Web | ❌ 不支持 | 浏览器限制 |

---

## 性能提示

### 1. 缓存静态信息

```dart
// CPU 型号不会改变，可以缓存
CpuInfo? _cachedCpuInfo;

Future<CpuInfo> getCpuInfo() async {
  _cachedCpuInfo ??= await HardwareInfo.getCpuInfo();
  return _cachedCpuInfo!;
}
```

### 2. 批量获取

```dart
// 一次获取所有信息比多次调用更高效
final systemInfo = await HardwareInfo.getSystemInfo();

// 而不是
final cpuInfo = await HardwareInfo.getCpuInfo();
final memoryInfo = await HardwareInfo.getMemoryInfo();
final gpuInfo = await HardwareInfo.getGpuInfo();
// ...
```

### 3. 异步加载

```dart
// 在后台加载，不阻塞 UI
Future<void> loadHardwareInfo() async {
  final systemInfo = await HardwareInfo.getSystemInfo();
  // 更新 UI
}
```

---

## 常见问题

### Q: 如何判断设备是否有电池？

```dart
final batteryInfo = await HardwareInfo.getBatteryInfo();
if (batteryInfo != null) {
  print('有电池');
} else {
  print('没有电池（台式机）');
}
```

### Q: 如何获取 GB 单位的内存大小？

```dart
final memoryInfo = await HardwareInfo.getMemoryInfo();
final totalGB = memoryInfo.totalMemoryGB; // 自动转换为 GB
```

### Q: 如何处理可能为 null 的值？

```dart
// 使用 ?? 提供默认值
final model = cpuInfo.model ?? '未知';

// 使用 ?. 安全访问
print('CPU: ${cpuInfo.model?.toUpperCase()}');

// 使用 if 判断
if (cpuInfo.model != null) {
  print('CPU: ${cpuInfo.model}');
}
```

### Q: 如何在不同平台显示不同内容？

```dart
import 'dart:io';

if (Platform.isWindows) {
  // Windows 特定代码
} else if (Platform.isAndroid) {
  // Android 特定代码
}
```

---

## 相关链接

- [完整 API 文档](API.md)
- [架构设计](ARCHITECTURE.md)
- [代码风格指南](CODE_STYLE.md)
- [贡献指南](../CONTRIBUTING.md)
- [GitHub 仓库](https://github.com/yourusername/hardware_info_kit)

---

**文档版本**: 1.0  
**创建日期**: 2026-03-08  
**项目**: hardware_info_kit
