# hardware_info_kit API 参考

本文档提供 hardware_info_kit 的完整 API 参考。

## 目录

- [hardware\_info\_kit API 参考](#hardware_info_kit-api-参考)
  - [目录](#目录)
  - [HardwareInfo](#hardwareinfo)
    - [静态方法](#静态方法)
      - [getSystemInfo](#getsysteminfo)
      - [getCpuInfo](#getcpuinfo)
      - [getMemoryInfo](#getmemoryinfo)
      - [getGpuInfo](#getgpuinfo)
      - [getDiskInfo](#getdiskinfo)
      - [getOsInfo](#getosinfo)
      - [getBatteryInfo](#getbatteryinfo)
      - [getNetworkInfo](#getnetworkinfo)
  - [数据模型](#数据模型)
    - [SystemInfo](#systeminfo)
    - [CpuInfo](#cpuinfo)
    - [MemoryInfo](#memoryinfo)
    - [GpuInfo](#gpuinfo)
    - [DiskInfo](#diskinfo)
    - [OsInfo](#osinfo)
    - [BatteryInfo](#batteryinfo)
    - [NetworkInfo](#networkinfo)
  - [异常处理](#异常处理)
    - [HardwareInfoException](#hardwareinfoexception)
  - [完整示例](#完整示例)

---

## HardwareInfo

主类，用于访问硬件信息。

### 静态方法

#### getSystemInfo

```dart
static Future<SystemInfo> getSystemInfo()
```

获取所有硬件信息。

**返回:** `Future<SystemInfo>` - 包含所有硬件信息的对象

**示例:**
```dart
final systemInfo = await HardwareInfo.getSystemInfo();
print('CPU: ${systemInfo.cpu.model}');
print('Memory: ${systemInfo.memory.totalMemoryGB} GB');
```

#### getCpuInfo

```dart
static Future<CpuInfo> getCpuInfo()
```

获取 CPU 信息。

**返回:** `Future<CpuInfo>` - CPU 信息对象

**示例:**
```dart
final cpuInfo = await HardwareInfo.getCpuInfo();
print('CPU Model: ${cpuInfo.model}');
print('Cores: ${cpuInfo.logicalCores}');
```

#### getMemoryInfo

```dart
static Future<MemoryInfo> getMemoryInfo()
```

获取内存信息。

**返回:** `Future<MemoryInfo>` - 内存信息对象

**示例:**
```dart
final memoryInfo = await HardwareInfo.getMemoryInfo();
print('Total: ${memoryInfo.totalMemoryGB?.toStringAsFixed(2)} GB');
print('Available: ${memoryInfo.availableMemoryGB?.toStringAsFixed(2)} GB');
```

#### getGpuInfo

```dart
static Future<GpuInfo> getGpuInfo()
```

获取 GPU 信息。

**返回:** `Future<GpuInfo>` - GPU 信息对象

**示例:**
```dart
final gpuInfo = await HardwareInfo.getGpuInfo();
print('GPU: ${gpuInfo.model}');
print('Memory: ${gpuInfo.memoryGB?.toStringAsFixed(2)} GB');
```

#### getDiskInfo

```dart
static Future<DiskInfo> getDiskInfo()
```

获取磁盘信息。

**返回:** `Future<DiskInfo>` - 磁盘信息对象

**示例:**
```dart
final diskInfo = await HardwareInfo.getDiskInfo();
print('Total: ${diskInfo.totalSpaceGB?.toStringAsFixed(2)} GB');
print('Free: ${diskInfo.freeSpaceGB?.toStringAsFixed(2)} GB');
```

#### getOsInfo

```dart
static Future<OsInfo> getOsInfo()
```

获取操作系统信息。

**返回:** `Future<OsInfo>` - 操作系统信息对象

**示例:**
```dart
final osInfo = await HardwareInfo.getOsInfo();
print('OS: ${osInfo.name} ${osInfo.version}');
print('Architecture: ${osInfo.architecture}');
```

#### getBatteryInfo

```dart
static Future<BatteryInfo?> getBatteryInfo()
```

获取电池信息（如果设备有电池）。

**返回:** `Future<BatteryInfo?>` - 电池信息对象，如果没有电池则返回 null

**示例:**
```dart
final batteryInfo = await HardwareInfo.getBatteryInfo();
if (batteryInfo != null) {
  print('Battery: ${batteryInfo.level}%');
  print('Charging: ${batteryInfo.isCharging}');
}
```

#### getNetworkInfo

```dart
static Future<NetworkInfo> getNetworkInfo()
```

获取网络信息。

**返回:** `Future<NetworkInfo>` - 网络信息对象

**示例:**
```dart
final networkInfo = await HardwareInfo.getNetworkInfo();
print('IPv4: ${networkInfo.ipv4}');
print('MAC: ${networkInfo.macAddress}');
```

---

## 数据模型

### SystemInfo

完整的系统硬件信息。

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

### CpuInfo

CPU/处理器信息。

```dart
class CpuInfo {
  final String? model;           // CPU 型号
  final String? vendor;          // 制造商
  final String? architecture;    // 架构（x86_64, ARM 等）
  final int? logicalCores;       // 逻辑核心数
  final int? physicalCores;      // 物理核心数
  final double? frequency;       // 频率（MHz）
  final int? cacheSize;          // 缓存大小（bytes）
}
```

### MemoryInfo

内存（RAM）信息。

```dart
class MemoryInfo {
  final int? totalMemory;        // 总内存（bytes）
  final int? availableMemory;    // 可用内存（bytes）
  final int? usedMemory;         // 已用内存（bytes）
  final double? usagePercentage; // 使用率（%）
  
  // 便捷 getter
  double? get totalMemoryGB;     // 总内存（GB）
  double? get availableMemoryGB; // 可用内存（GB）
  double? get usedMemoryGB;      // 已用内存（GB）
}
```

### GpuInfo

GPU/显卡信息。

```dart
class GpuInfo {
  final String? model;           // GPU 型号
  final String? vendor;          // 制造商
  final int? memory;             // 显存（bytes）
  final String? driverVersion;   // 驱动版本
  
  // 便捷 getter
  double? get memoryGB;          // 显存（GB）
}
```

### DiskInfo

磁盘/存储信息。

```dart
class DiskInfo {
  final int? totalSpace;         // 总空间（bytes）
  final int? freeSpace;          // 可用空间（bytes）
  final int? usedSpace;          // 已用空间（bytes）
  final int? driveCount;         // 驱动器数量
  
  // 便捷 getter
  double? get totalSpaceGB;      // 总空间（GB）
  double? get freeSpaceGB;       // 可用空间（GB）
  double? get usedSpaceGB;       // 已用空间（GB）
  double? get usagePercentage;   // 使用率（%）
}
```

### OsInfo

操作系统信息。

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

电池信息。

```dart
class BatteryInfo {
  final int? level;              // 电量（0-100）
  final bool? isCharging;        // 是否充电中
  final String? health;          // 健康状态
  final double? temperature;     // 温度（摄氏度）
  final double? voltage;         // 电压（伏特）
}
```

### NetworkInfo

网络信息。

```dart
class NetworkInfo {
  final String? ipv4;            // IPv4 地址
  final String? ipv6;            // IPv6 地址
  final String? macAddress;      // MAC 地址
  final String? interfaceName;   // 网络接口名称
}
```

---

## 异常处理

### HardwareInfoException

当获取硬件信息失败时抛出。

```dart
class HardwareInfoException implements Exception {
  final String message;
  final String? code;
  final dynamic details;
}
```

**示例:**
```dart
try {
  final systemInfo = await HardwareInfo.getSystemInfo();
  // 使用 systemInfo
} on HardwareInfoException catch (e) {
  print('Error: ${e.message}');
  print('Code: ${e.code}');
} catch (e) {
  print('Unexpected error: $e');
}
```

---

## 完整示例

```dart
import 'package:flutter/material.dart';
import 'package:hardware_info_kit/hardware_info_kit.dart';

class HardwareInfoPage extends StatefulWidget {
  const HardwareInfoPage({super.key});

  @override
  State<HardwareInfoPage> createState() => _HardwareInfoPageState();
}

class _HardwareInfoPageState extends State<HardwareInfoPage> {
  SystemInfo? _systemInfo;
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadHardwareInfo();
  }

  Future<void> _loadHardwareInfo() async {
    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      final systemInfo = await HardwareInfo.getSystemInfo();
      setState(() {
        _systemInfo = systemInfo;
        _loading = false;
      });
    } on HardwareInfoException catch (e) {
      setState(() {
        _error = e.message;
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _error = 'Unexpected error: $e';
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_error != null) {
      return Center(child: Text('Error: $_error'));
    }

    final info = _systemInfo!;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildSection('Operating System', [
          _buildItem('Name', info.os.name),
          _buildItem('Version', info.os.version),
          _buildItem('Architecture', info.os.architecture),
        ]),
        _buildSection('CPU', [
          _buildItem('Model', info.cpu.model),
          _buildItem('Vendor', info.cpu.vendor),
          _buildItem('Cores', '${info.cpu.logicalCores}'),
        ]),
        _buildSection('Memory', [
          _buildItem('Total', '${info.memory.totalMemoryGB?.toStringAsFixed(2)} GB'),
          _buildItem('Available', '${info.memory.availableMemoryGB?.toStringAsFixed(2)} GB'),
          _buildItem('Usage', '${info.memory.usagePercentage?.toStringAsFixed(1)}%'),
        ]),
      ],
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildItem(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
            child: Text(value ?? 'N/A'),
          ),
        ],
      ),
    );
  }
}
```

---

**文档版本**: 1.0  
**更新日期**: 2026-03-08  
**项目**: hardware_info_kit
