# hardware_info_kit 代码风格指南

本文档定义了 hardware_info_kit 项目的代码风格规范。

## 基本原则

1. **一致性**: 保持代码风格一致
2. **可读性**: 代码应该易于理解
3. **简洁性**: 避免不必要的复杂性
4. **可维护性**: 便于后续维护和扩展

---

## Dart 代码风格

### 命名规范

#### 文件命名

使用 `snake_case`（小写下划线）:

```
✅ 好的示例
cpu_info.dart
memory_info.dart
hardware_info_kit.dart

❌ 不好的示例
CpuInfo.dart
cpuInfo.dart
CPU_Info.dart
```

#### 类命名

使用 `PascalCase`（大驼峰）:

```dart
✅ 好的示例
class CpuInfo {}
class MemoryInfo {}
class HardwareInfo {}

❌ 不好的示例
class cpuInfo {}
class cpu_info {}
class CPUINFO {}
```

#### 变量和方法命名

使用 `camelCase`（小驼峰）:

```dart
✅ 好的示例
final cpuInfo = await HardwareInfo.getCpuInfo();
final totalMemoryGB = memoryInfo.totalMemoryGB;

Future<CpuInfo> getCpuInfo() async { }

❌ 不好的示例
final CPUInfo = await HardwareInfo.GetCPUInfo();
final TotalMemoryGB = memoryInfo.TotalMemoryGB;

Future<CpuInfo> GetCpuInfo() async { }
```

#### 常量命名

使用 `lowerCamelCase`:

```dart
✅ 好的示例
const defaultTimeout = Duration(seconds: 30);
const maxRetries = 3;

❌ 不好的示例
const DEFAULT_TIMEOUT = Duration(seconds: 30);
const MAX_RETRIES = 3;
```

### 代码格式

#### 缩进

使用 2 个空格缩进:

```dart
✅ 好的示例
class CpuInfo {
  final String? model;
  
  CpuInfo({this.model});
}

❌ 不好的示例
class CpuInfo {
    final String? model;  // 4 个空格
    
    CpuInfo({this.model});
}
```

#### 行长度

每行最多 80 个字符，超过时适当换行:

```dart
✅ 好的示例
final cpuInfo = CpuInfo(
  model: 'Intel Core i7',
  vendor: 'Intel',
  logicalCores: 8,
);

❌ 不好的示例
final cpuInfo = CpuInfo(model: 'Intel Core i7', vendor: 'Intel', logicalCores: 8, physicalCores: 4);
```

#### 尾随逗号

多行参数列表使用尾随逗号:

```dart
✅ 好的示例
return CpuInfo(
  model: model,
  vendor: vendor,
  logicalCores: logicalCores,  // 尾随逗号
);

❌ 不好的示例
return CpuInfo(
  model: model,
  vendor: vendor,
  logicalCores: logicalCores  // 缺少尾随逗号
);
```

### 类型注解

#### 公共 API

必须显式声明返回类型和参数类型:

```dart
✅ 好的示例
static Future<CpuInfo> getCpuInfo() async {
  // ...
}

❌ 不好的示例
static getCpuInfo() async {
  // ...
}
```

#### 局部变量

可以使用类型推断:

```dart
✅ 好的示例
final cpuInfo = await HardwareInfo.getCpuInfo();
final model = cpuInfo.model;

✅ 也可以
final CpuInfo cpuInfo = await HardwareInfo.getCpuInfo();
final String? model = cpuInfo.model;
```

### 文档注释

#### 公共 API

所有公共类、方法、属性必须有文档注释:

```dart
✅ 好的示例
/// CPU/处理器信息
///
/// 包含 CPU 的型号、厂商、架构、核心数等信息。
class CpuInfo {
  /// CPU 型号
  ///
  /// 例如: "Intel Core i7-9700K"
  final String? model;
  
  /// 获取 CPU 信息
  ///
  /// 返回包含 CPU 详细信息的 [CpuInfo] 对象。
  ///
  /// 示例:
  /// ```dart
  /// final cpuInfo = await HardwareInfo.getCpuInfo();
  /// print('CPU: ${cpuInfo.model}');
  /// ```
  static Future<CpuInfo> getCpuInfo() async {
    // ...
  }
}
```

#### 私有成员

使用行内注释:

```dart
✅ 好的示例
// 解析内存大小字符串
int? _parseMemory(dynamic value) {
  // 尝试解析 "XX.XX GB" 格式
  if (value is String) {
    final match = RegExp(r'([\d.]+)\s*GB').firstMatch(value);
    // ...
  }
}
```

### 构造函数顺序

构造函数必须在字段定义之前:

```dart
✅ 好的示例
class CpuInfo {
  CpuInfo({this.model, this.vendor});
  
  factory CpuInfo.fromJson(Map<String, dynamic> json) {
    return CpuInfo(model: json['model']);
  }
  
  final String? model;
  final String? vendor;
}

❌ 不好的示例
class CpuInfo {
  final String? model;
  final String? vendor;
  
  CpuInfo({this.model, this.vendor});  // 应该在字段之前
}
```

---

## C++ 代码风格 (Windows)

### 命名规范

#### 类和函数命名

使用 `PascalCase`:

```cpp
✅ 好的示例
class HardwarePlugin {
  flutter::EncodableMap GetCpuInfo();
  flutter::EncodableMap GetMemoryInfo();
};

❌ 不好的示例
class hardware_plugin {
  flutter::EncodableMap get_cpu_info();
};
```

#### 变量命名

使用 `camelCase`:

```cpp
✅ 好的示例
SYSTEM_INFO sysInfo;
MEMORYSTATUSEX memInfo;
std::string cpuModel;

❌ 不好的示例
SYSTEM_INFO sys_info;
std::string cpu_model;
```

### 代码格式

#### 缩进

使用 2 个空格:

```cpp
✅ 好的示例
flutter::EncodableMap HardwarePlugin::GetCpuInfo() {
  flutter::EncodableMap result;
  SYSTEM_INFO sysInfo;
  GetSystemInfo(&sysInfo);
  return result;
}
```

#### 指针和引用

`*` 和 `&` 靠近类型:

```cpp
✅ 好的示例
std::string* ptr;
const std::string& ref;

❌ 不好的示例
std::string *ptr;
const std::string &ref;
```

---

## Kotlin 代码风格 (Android)

### 命名规范

#### 类命名

使用 `PascalCase`:

```kotlin
✅ 好的示例
class HardwareInfoKitPlugin : FlutterPlugin, MethodCallHandler {
}

❌ 不好的示例
class hardwareInfoKitPlugin : FlutterPlugin {
}
```

#### 函数和变量命名

使用 `camelCase`:

```kotlin
✅ 好的示例
private fun getCpuInfo(): Map<String, Any?> {
  val cpuModel = Build.MODEL
  return mapOf("model" to cpuModel)
}

❌ 不好的示例
private fun GetCpuInfo(): Map<String, Any?> {
  val CPUModel = Build.MODEL
}
```

### 代码格式

#### 缩进

使用 2 个空格:

```kotlin
✅ 好的示例
override fun onMethodCall(call: MethodCall, result: Result) {
  when (call.method) {
    "getCpuInfo" -> {
      result.success(getCpuInfo())
    }
  }
}
```

#### 使用 when 而不是 if-else 链

```kotlin
✅ 好的示例
when (call.method) {
  "getCpuInfo" -> result.success(getCpuInfo())
  "getMemoryInfo" -> result.success(getMemoryInfo())
  else -> result.notImplemented()
}

❌ 不好的示例
if (call.method == "getCpuInfo") {
  result.success(getCpuInfo())
} else if (call.method == "getMemoryInfo") {
  result.success(getMemoryInfo())
} else {
  result.notImplemented()
}
```

---

## 最佳实践

### 1. 使用 const

尽可能使用 `const`:

```dart
✅ 好的示例
const timeout = Duration(seconds: 30);
const MethodChannel _channel = MethodChannel('hardware_info_kit');

❌ 不好的示例
final timeout = Duration(seconds: 30);
final MethodChannel _channel = MethodChannel('hardware_info_kit');
```

### 2. 空安全

正确使用可空类型:

```dart
✅ 好的示例
final String? model = cpuInfo.model;
if (model != null) {
  print('CPU: $model');
}

// 或使用 ?.
print('CPU: ${cpuInfo.model ?? "Unknown"}');

❌ 不好的示例
final String model = cpuInfo.model!;  // 可能崩溃
print('CPU: $model');
```

### 3. 异步处理

使用 async/await:

```dart
✅ 好的示例
Future<CpuInfo> getCpuInfo() async {
  final result = await _channel.invokeMethod('getCpuInfo');
  return CpuInfo.fromJson(result);
}

❌ 不好的示例
Future<CpuInfo> getCpuInfo() {
  return _channel.invokeMethod('getCpuInfo').then((result) {
    return CpuInfo.fromJson(result);
  });
}
```

### 4. 错误处理

明确处理异常:

```dart
✅ 好的示例
try {
  final result = await _channel.invokeMethod('getCpuInfo');
  return CpuInfo.fromJson(result);
} on PlatformException catch (e) {
  throw HardwareInfoException('Failed to get CPU info: ${e.message}');
}

❌ 不好的示例
final result = await _channel.invokeMethod('getCpuInfo');
return CpuInfo.fromJson(result);  // 未处理异常
```

---

## 工具

### 格式化

```bash
# 格式化所有文件
dart format .

# 检查格式（不修改）
dart format --output=none --set-exit-if-changed .
```

### 分析

```bash
# 运行代码分析
flutter analyze

# 修复可自动修复的问题
dart fix --apply
```

### 测试

```bash
# 运行所有测试
flutter test

# 运行特定测试
flutter test test/cpu_info_test.dart

# 生成覆盖率报告
flutter test --coverage
```

---

## 提交规范

遵循 `.github/COMMIT_CONVENTION.md` 中定义的规范。

### 提交消息格式

```
<类型>(<范围>): <简短描述>

[可选的详细描述]

[可选的 Footer]
```

### 示例

```
feat(models): 添加传感器信息模型

- 添加 SensorInfo 类
- 实现 JSON 序列化
- 添加单元测试

Closes #123
```

---

**文档版本**: 1.0  
**创建日期**: 2026-03-08  
**项目**: hardware_info_kit
