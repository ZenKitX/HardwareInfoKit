# hardware_info_kit 架构设计

本文档描述 hardware_info_kit 项目的架构设计原则和实现方案。

## 目录

1. [设计原则](#设计原则)
2. [目录结构](#目录结构)
3. [模块划分](#模块划分)
4. [平台实现](#平台实现)
5. [扩展指南](#扩展指南)

---

## 设计原则

### 1. 简单易用

提供简单直观的 API，开发者可以快速集成和使用。

**优势**:
- 快速上手
- 减少学习成本
- 降低出错概率

**示例**:
```dart
// 一行代码获取所有硬件信息
final systemInfo = await HardwareInfo.getSystemInfo();
```

### 2. 跨平台一致性

所有平台提供统一的 API 接口，返回相同的数据结构。

**实现**:
- 统一的 Dart API 层
- 统一的数据模型
- 平台特定的实现细节被封装

### 3. 类型安全

使用强类型的数据模型，避免运行时错误。

**实现**:
- 所有数据模型都有明确的类型定义
- 使用可空类型处理可能缺失的数据
- 提供便捷的 getter 方法（如 GB 转换）

### 4. 异步非阻塞

所有 API 都是异步的，不会阻塞 UI 线程。

**实现**:
- 使用 `Future` 返回结果
- 使用 MethodChannel 与平台通信
- 平台代码在后台线程执行

### 5. 可扩展性

易于添加新的硬件信息类型和新的平台支持。

**实现**:
- 模块化的代码结构
- 清晰的接口定义
- 详细的扩展文档

---

## 目录结构

```
hardware_info_kit/
├── lib/                                    # Dart 代码
│   ├── hardware_info_kit.dart             # 主导出文件
│   ├── hardware_info_kit_method_channel.dart
│   ├── hardware_info_kit_platform_interface.dart
│   └── src/
│       ├── hardware_info_kit.dart         # 核心 API 实现
│       ├── enums/                         # 枚举定义
│       └── models/                        # 数据模型
│           ├── system_info.dart
│           ├── cpu_info.dart
│           ├── memory_info.dart
│           ├── gpu_info.dart
│           ├── disk_info.dart
│           ├── os_info.dart
│           ├── battery_info.dart
│           └── network_info.dart
├── windows/                               # Windows 平台实现
│   ├── hardware_plugin.cpp                # 核心实现
│   ├── hardware_plugin.h
│   ├── hardware_info_kit_plugin.cpp       # 插件接口
│   └── CMakeLists.txt
├── android/                               # Android 平台实现
│   └── src/main/kotlin/.../
│       └── HardwareInfoKitPlugin.kt       # Kotlin 实现
├── test/                                  # 单元测试
├── example/                               # 示例应用
├── benchmark/                             # 性能测试
└── doc/                                   # 文档
```

---

## 模块划分

### Dart API 层

**职责**:
- 提供公共 API 接口
- 处理 MethodChannel 通信
- 数据模型的序列化和反序列化
- 异常处理

**核心类**:

#### HardwareInfo

主 API 类，提供所有硬件信息获取方法。

```dart
class HardwareInfo {
  static Future<SystemInfo> getSystemInfo();
  static Future<CpuInfo> getCpuInfo();
  static Future<MemoryInfo> getMemoryInfo();
  static Future<GpuInfo> getGpuInfo();
  static Future<DiskInfo> getDiskInfo();
  static Future<OsInfo> getOsInfo();
  static Future<BatteryInfo?> getBatteryInfo();
  static Future<NetworkInfo> getNetworkInfo();
}
```

### 数据模型层

**职责**:
- 定义硬件信息的数据结构
- 提供 JSON 序列化/反序列化
- 提供便捷的 getter 方法

**核心模型**:

#### SystemInfo
完整的系统信息，包含所有硬件信息。

#### CpuInfo
CPU 信息：型号、厂商、架构、核心数、频率等。

#### MemoryInfo
内存信息：总量、可用、已用、使用率等。

#### GpuInfo
GPU 信息：型号、厂商、显存、驱动版本等。

#### DiskInfo
磁盘信息：总空间、可用空间、已用空间、使用率等。

#### OsInfo
操作系统信息：名称、版本、架构、计算机名等。

#### BatteryInfo
电池信息：电量、充电状态、健康状态、温度等。

#### NetworkInfo
网络信息：IP 地址、MAC 地址、接口名称等。

---

## 平台实现

### Windows 平台

**技术栈**: C++

**实现方式**:
- 使用 Windows API 获取硬件信息
- 使用 WMI (Windows Management Instrumentation) 查询系统信息
- 通过 MethodChannel 与 Dart 通信

**核心文件**:
- `hardware_plugin.cpp`: 核心实现，包含所有硬件信息获取逻辑
- `hardware_plugin.h`: 头文件
- `hardware_info_kit_plugin.cpp`: Flutter 插件接口

**获取信息的方法**:

```cpp
// CPU 信息
SYSTEM_INFO sysInfo;
GetSystemInfo(&sysInfo);

// 内存信息
MEMORYSTATUSEX memInfo;
GlobalMemoryStatusEx(&memInfo);

// 磁盘信息
GetDiskFreeSpaceEx(...)

// 操作系统信息
GetVersionEx(...)
```

### Android 平台

**技术栈**: Kotlin

**实现方式**:
- 使用 Android API 获取硬件信息
- 使用系统服务（ActivityManager, BatteryManager 等）
- 通过 MethodChannel 与 Dart 通信

**核心文件**:
- `HardwareInfoKitPlugin.kt`: 完整的 Android 实现

**获取信息的方法**:

```kotlin
// CPU 信息
Build.HARDWARE
Build.SUPPORTED_ABIS

// 内存信息
ActivityManager.MemoryInfo

// 电池信息
BatteryManager

// 操作系统信息
Build.VERSION
```

---

## 数据流

```
┌─────────────┐
│   Flutter   │
│     App     │
└──────┬──────┘
       │
       │ 调用 API
       ▼
┌─────────────────┐
│  HardwareInfo   │
│   (Dart API)    │
└──────┬──────────┘
       │
       │ MethodChannel
       ▼
┌─────────────────┐
│  Platform Code  │
│  (C++ / Kotlin) │
└──────┬──────────┘
       │
       │ 系统 API
       ▼
┌─────────────────┐
│  Operating      │
│    System       │
└─────────────────┘
```

---

## 扩展指南

### 添加新的硬件信息类型

假设要添加 "传感器信息"：

#### 步骤 1: 创建数据模型

在 `lib/src/models/` 创建 `sensor_info.dart`:

```dart
/// 传感器信息
class SensorInfo {
  SensorInfo({
    this.accelerometer,
    this.gyroscope,
    this.magnetometer,
  });

  factory SensorInfo.fromJson(Map<String, dynamic> json) {
    return SensorInfo(
      accelerometer: json['accelerometer'],
      gyroscope: json['gyroscope'],
      magnetometer: json['magnetometer'],
    );
  }

  final bool? accelerometer;
  final bool? gyroscope;
  final bool? magnetometer;

  Map<String, dynamic> toJson() {
    return {
      'accelerometer': accelerometer,
      'gyroscope': gyroscope,
      'magnetometer': magnetometer,
    };
  }
}
```

#### 步骤 2: 添加 API 方法

在 `lib/src/hardware_info_kit.dart` 添加:

```dart
/// 获取传感器信息
static Future<SensorInfo> getSensorInfo() async {
  try {
    final result = await _channel.invokeMethod('getSensorInfo');
    return SensorInfo.fromJson(Map<String, dynamic>.from(result));
  } on PlatformException catch (e) {
    throw HardwareInfoException('Failed to get sensor info: ${e.message}');
  }
}
```

#### 步骤 3: 实现 Windows 平台

在 `windows/hardware_plugin.cpp` 添加:

```cpp
flutter::EncodableMap HardwarePlugin::GetSensorInfo() {
  flutter::EncodableMap result;
  
  // 实现传感器检测逻辑
  result[flutter::EncodableValue("accelerometer")] = 
      flutter::EncodableValue(false);
  result[flutter::EncodableValue("gyroscope")] = 
      flutter::EncodableValue(false);
  result[flutter::EncodableValue("magnetometer")] = 
      flutter::EncodableValue(false);
  
  return result;
}
```

并在 `HandleMethodCall` 中添加处理:

```cpp
if (method_call.method_name() == "getSensorInfo") {
  result->Success(flutter::EncodableValue(GetSensorInfo()));
}
```

#### 步骤 4: 实现 Android 平台

在 `android/.../HardwareInfoKitPlugin.kt` 添加:

```kotlin
private fun getSensorInfo(): Map<String, Any?> {
  val sensorManager = context.getSystemService(Context.SENSOR_SERVICE) as SensorManager
  
  return mapOf(
    "accelerometer" to (sensorManager.getDefaultSensor(Sensor.TYPE_ACCELEROMETER) != null),
    "gyroscope" to (sensorManager.getDefaultSensor(Sensor.TYPE_GYROSCOPE) != null),
    "magnetometer" to (sensorManager.getDefaultSensor(Sensor.TYPE_MAGNETIC_FIELD) != null)
  )
}
```

并在 `onMethodCall` 中添加处理:

```kotlin
"getSensorInfo" -> {
  result.success(getSensorInfo())
}
```

#### 步骤 5: 添加测试

在 `test/` 目录添加测试文件。

#### 步骤 6: 更新文档

更新 README.md 和 API.md 文档。

### 添加新平台支持

假设要添加 iOS 平台支持：

#### 步骤 1: 创建平台目录

```bash
flutter create --template=plugin --platforms=ios .
```

#### 步骤 2: 实现 Swift/Objective-C 代码

在 `ios/Classes/` 创建实现文件。

#### 步骤 3: 更新 pubspec.yaml

```yaml
flutter:
  plugin:
    platforms:
      ios:
        pluginClass: HardwareInfoKitPlugin
```

#### 步骤 4: 实现所有 API 方法

参考 Android 实现，使用 iOS API 获取硬件信息。

---

## 性能优化

### 1. 缓存策略

对于不变的信息（如 CPU 型号），可以实现缓存：

```dart
class HardwareInfo {
  static CpuInfo? _cachedCpuInfo;
  
  static Future<CpuInfo> getCpuInfo({bool forceRefresh = false}) async {
    if (!forceRefresh && _cachedCpuInfo != null) {
      return _cachedCpuInfo!;
    }
    
    final result = await _channel.invokeMethod('getCpuInfo');
    _cachedCpuInfo = CpuInfo.fromJson(Map<String, dynamic>.from(result));
    return _cachedCpuInfo!;
  }
}
```

### 2. 批量获取

使用 `getSystemInfo()` 一次性获取所有信息，比多次调用单个方法更高效。

### 3. 异步处理

所有平台代码都应该在后台线程执行，避免阻塞主线程。

---

## 错误处理

### 异常类型

```dart
class HardwareInfoException implements Exception {
  HardwareInfoException(this.message);
  final String message;
}
```

### 错误处理策略

1. **平台异常**: 捕获 PlatformException 并转换为 HardwareInfoException
2. **数据解析错误**: 使用可空类型，避免崩溃
3. **不支持的平台**: 返回默认值或 null

---

## 测试策略

### 单元测试

测试数据模型的序列化和反序列化：

```dart
test('CpuInfo.fromJson 正确解析数据', () {
  final json = {'model': 'Intel Core i7', 'logicalCores': 8};
  final cpuInfo = CpuInfo.fromJson(json);
  
  expect(cpuInfo.model, 'Intel Core i7');
  expect(cpuInfo.logicalCores, 8);
});
```

### 集成测试

测试实际的硬件信息获取：

```dart
testWidgets('getSystemInfo 返回有效数据', (tester) async {
  final systemInfo = await HardwareInfo.getSystemInfo();
  
  expect(systemInfo, isNotNull);
  expect(systemInfo.cpu, isNotNull);
  expect(systemInfo.memory, isNotNull);
});
```

### 性能测试

使用 benchmark 测试性能：

```dart
void main() {
  benchmark('getSystemInfo', () async {
    await HardwareInfo.getSystemInfo();
  });
}
```

---

## 最佳实践

### 1. 使用类型安全的 API

```dart
// 好的做法
final cpuInfo = await HardwareInfo.getCpuInfo();
print('CPU: ${cpuInfo.model}');

// 不好的做法
final result = await methodChannel.invokeMethod('getCpuInfo');
print('CPU: ${result['model']}');
```

### 2. 处理可空值

```dart
// 好的做法
final batteryInfo = await HardwareInfo.getBatteryInfo();
if (batteryInfo != null) {
  print('Battery: ${batteryInfo.level}%');
}

// 不好的做法
final batteryInfo = await HardwareInfo.getBatteryInfo();
print('Battery: ${batteryInfo!.level}%'); // 可能崩溃
```

### 3. 使用便捷 getter

```dart
// 好的做法
print('Memory: ${memoryInfo.totalMemoryGB?.toStringAsFixed(2)} GB');

// 不好的做法
print('Memory: ${(memoryInfo.totalMemory! / 1024 / 1024 / 1024).toStringAsFixed(2)} GB');
```

### 4. 异常处理

```dart
// 好的做法
try {
  final systemInfo = await HardwareInfo.getSystemInfo();
  // 使用 systemInfo
} on HardwareInfoException catch (e) {
  print('Error: ${e.message}');
}

// 不好的做法
final systemInfo = await HardwareInfo.getSystemInfo(); // 可能抛出未捕获的异常
```

---

## 总结

hardware_info_kit 的架构设计遵循以下原则：

1. **简单易用**: 提供直观的 API
2. **跨平台一致**: 统一的接口和数据结构
3. **类型安全**: 强类型的数据模型
4. **高性能**: 异步非阻塞调用
5. **可扩展**: 易于添加新功能和新平台

这种设计为项目的长期发展和维护奠定了坚实的基础。

---

**文档版本**: 1.0  
**创建日期**: 2026-03-08  
**项目**: hardware_info_kit
