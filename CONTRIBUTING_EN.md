# Contributing to hardware_info_kit

Thank you for your interest in contributing! This guide will help you extend the plugin with new features.

## Architecture Overview

```
hardware_info_kit/
├── lib/
│   ├── hardware_info_kit.dart          # Main export file
│   └── src/
│       ├── hardware_info_kit.dart      # Main API class
│       ├── models/                      # Data models
│       │   ├── system_info.dart
│       │   ├── cpu_info.dart
│       │   ├── memory_info.dart
│       │   └── ...
│       └── enums/                       # Enumerations
│           └── enums.dart
│
├── windows/                             # Windows platform code (C++)
│   ├── hardware_plugin.h
│   ├── hardware_plugin.cpp
│   └── CMakeLists.txt
│
├── android/                             # Android platform code (Kotlin)
│   └── src/main/kotlin/
│       └── HardwareInfoKitPlugin.kt
│
└── example/                             # Example app
    └── lib/main.dart
```

## Adding New Hardware Information

### Step 1: Define the Data Model

Create a new model in `lib/src/models/`:

```dart
// lib/src/models/new_hardware_info.dart
class NewHardwareInfo {
  final String? property1;
  final int? property2;

  NewHardwareInfo({
    this.property1,
    this.property2,
  });

  factory NewHardwareInfo.fromJson(Map<String, dynamic> json) {
    return NewHardwareInfo(
      property1: json['property1'] as String?,
      property2: json['property2'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'property1': property1,
      'property2': property2,
    };
  }
}
```

### Step 2: Add to SystemInfo

Update `lib/src/models/system_info.dart`:

```dart
class SystemInfo {
  final OsInfo os;
  final CpuInfo cpu;
  final MemoryInfo memory;
  final GpuInfo gpu;
  final DiskInfo disk;
  final BatteryInfo? battery;
  final NetworkInfo? network;
  final NewHardwareInfo? newHardware; // Add this

  SystemInfo({
    required this.os,
    required this.cpu,
    required this.memory,
    required this.gpu,
    required this.disk,
    this.battery,
    this.network,
    this.newHardware, // Add this
  });

  factory SystemInfo.fromJson(Map<String, dynamic> json) {
    return SystemInfo(
      os: OsInfo.fromJson(json['os'] as Map<String, dynamic>),
      cpu: CpuInfo.fromJson(json['cpu'] as Map<String, dynamic>),
      memory: MemoryInfo.fromJson(json['memory'] as Map<String, dynamic>),
      gpu: GpuInfo.fromJson(json['gpu'] as Map<String, dynamic>),
      disk: DiskInfo.fromJson(json['disk'] as Map<String, dynamic>),
      battery: json['battery'] != null
          ? BatteryInfo.fromJson(json['battery'] as Map<String, dynamic>)
          : null,
      network: json['network'] != null
          ? NetworkInfo.fromJson(json['network'] as Map<String, dynamic>)
          : null,
      newHardware: json['newHardware'] != null // Add this
          ? NewHardwareInfo.fromJson(json['newHardware'] as Map<String, dynamic>)
          : null,
    );
  }
}
```

### Step 3: Add API Method

Update `lib/src/hardware_info_kit.dart`:

```dart
class HardwareInfo {
  static const MethodChannel _channel = MethodChannel('hardware_info_kit');

  // Add new method
  static Future<NewHardwareInfo> getNewHardwareInfo() async {
    try {
      final result = await _channel.invokeMethod('getNewHardwareInfo');
      return NewHardwareInfo.fromJson(Map<String, dynamic>.from(result));
    } on PlatformException catch (e) {
      throw HardwareInfoException(
        message: e.message ?? 'Failed to get new hardware info',
        code: e.code,
        details: e.details,
      );
    }
  }
}
```

### Step 4: Implement Windows Platform Code

Update `windows/hardware_plugin.cpp`:

```cpp
// Add new method to get hardware info
std::map<std::string, flutter::EncodableValue> GetNewHardwareInfo() {
  std::map<std::string, flutter::EncodableValue> info;
  
  // Implement your Windows-specific code here
  info["property1"] = flutter::EncodableValue("value1");
  info["property2"] = flutter::EncodableValue(123);
  
  return info;
}

// Add to HandleMethodCall
void HardwarePlugin::HandleMethodCall(
    const flutter::MethodCall<flutter::EncodableValue>& method_call,
    std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result) {
  
  if (method_call.method_name() == "getNewHardwareInfo") {
    auto info = GetNewHardwareInfo();
    result->Success(flutter::EncodableValue(info));
  }
  // ... other methods
}
```

### Step 5: Implement Android Platform Code

Update `android/src/main/kotlin/.../HardwareInfoKitPlugin.kt`:

```kotlin
private fun getNewHardwareInfo(): Map<String, Any?> {
  return mapOf(
    "property1" to "value1",
    "property2" to 123
  )
}

override fun onMethodCall(call: MethodCall, result: Result) {
  when (call.method) {
    "getNewHardwareInfo" -> {
      try {
        result.success(getNewHardwareInfo())
      } catch (e: Exception) {
        result.error("ERROR", e.message, null)
      }
    }
    // ... other methods
  }
}
```

### Step 6: Add Tests

Create `test/new_hardware_info_test.dart`:

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:hardware_info_kit/hardware_info_kit.dart';

void main() {
  group('NewHardwareInfo', () {
    test('fromJson creates valid object', () {
      final json = {
        'property1': 'value1',
        'property2': 123,
      };

      final info = NewHardwareInfo.fromJson(json);

      expect(info.property1, 'value1');
      expect(info.property2, 123);
    });

    test('toJson returns correct map', () {
      final info = NewHardwareInfo(
        property1: 'value1',
        property2: 123,
      );

      final json = info.toJson();

      expect(json['property1'], 'value1');
      expect(json['property2'], 123);
    });
  });
}
```

### Step 7: Update Documentation

1. Add to `README.md` API reference
2. Add to `doc/API.md` with detailed documentation
3. Add example usage to `USAGE_GUIDE.md`
4. Update `CHANGELOG.md`

## Adding Support for New Platforms

### iOS Support

1. Create `ios/Classes/` directory
2. Implement Swift or Objective-C plugin code
3. Update `pubspec.yaml` to include iOS platform
4. Add iOS-specific documentation

### Linux Support

1. Create `linux/` directory
2. Implement C++ plugin code similar to Windows
3. Create `CMakeLists.txt` for Linux
4. Update `pubspec.yaml` to include Linux platform

### macOS Support

1. Create `macos/Classes/` directory
2. Implement Swift or Objective-C plugin code
3. Update `pubspec.yaml` to include macOS platform
4. Add macOS-specific documentation

## Code Style Guidelines

### Dart Code

- Follow [Effective Dart](https://dart.dev/guides/language/effective-dart) guidelines
- Use `dart format` to format code
- Run `flutter analyze` to check for issues
- Add documentation comments for public APIs

```dart
/// Gets the CPU information.
///
/// Returns a [CpuInfo] object containing CPU details like model,
/// vendor, cores, and frequency.
///
/// Throws [HardwareInfoException] if the information cannot be retrieved.
static Future<CpuInfo> getCpuInfo() async {
  // Implementation
}
```

### C++ Code (Windows)

- Follow Google C++ Style Guide
- Use meaningful variable names
- Add comments for complex logic
- Handle errors appropriately

```cpp
// Get CPU information using Windows API
std::map<std::string, flutter::EncodableValue> GetCpuInfo() {
  std::map<std::string, flutter::EncodableValue> info;
  
  // Get CPU model
  HKEY hKey;
  if (RegOpenKeyEx(HKEY_LOCAL_MACHINE, 
                   TEXT("HARDWARE\\DESCRIPTION\\System\\CentralProcessor\\0"),
                   0, KEY_READ, &hKey) == ERROR_SUCCESS) {
    // Read registry values
    // ...
    RegCloseKey(hKey);
  }
  
  return info;
}
```

### Kotlin Code (Android)

- Follow Kotlin coding conventions
- Use null safety
- Add KDoc comments for public methods

```kotlin
/**
 * Gets CPU information from Android system.
 *
 * @return Map containing CPU details
 */
private fun getCpuInfo(): Map<String, Any?> {
  return mapOf(
    "model" to Build.MODEL,
    "vendor" to Build.MANUFACTURER,
    // ...
  )
}
```

## Testing

### Unit Tests

Run unit tests:

```bash
flutter test
```

### Integration Tests

Run integration tests on a device:

```bash
cd example
flutter test integration_test/
```

### Platform-Specific Tests

Windows:
```bash
cd windows
cmake -B build
cmake --build build
ctest --test-dir build
```

Android:
```bash
cd android
./gradlew test
```

## Pull Request Process

1. Fork the repository
2. Create a feature branch: `git checkout -b feature/new-hardware-info`
3. Make your changes
4. Add tests for new functionality
5. Ensure all tests pass: `flutter test`
6. Ensure code analysis passes: `flutter analyze`
7. Format code: `dart format .`
8. Commit with descriptive message: `git commit -m "feat: add new hardware info"`
9. Push to your fork: `git push origin feature/new-hardware-info`
10. Create a Pull Request

### Commit Message Format

Follow [Conventional Commits](https://www.conventionalcommits.org/):

```
<type>(<scope>): <subject>

<body>

<footer>
```

Types:
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation changes
- `style`: Code style changes (formatting, etc.)
- `refactor`: Code refactoring
- `test`: Adding or updating tests
- `chore`: Maintenance tasks

Examples:
```
feat(windows): add GPU temperature monitoring
fix(android): correct memory calculation on Android 12+
docs: update API reference for new methods
```

## Getting Help

- Check existing [issues](https://github.com/yourusername/hardware_info_kit/issues)
- Read the [documentation](https://pub.dev/documentation/hardware_info_kit/latest/)
- Ask questions in [discussions](https://github.com/yourusername/hardware_info_kit/discussions)

## Code of Conduct

- Be respectful and inclusive
- Provide constructive feedback
- Focus on what is best for the community
- Show empathy towards other community members

## License

By contributing, you agree that your contributions will be licensed under the MIT License.

## Recognition

Contributors will be recognized in:
- `AUTHORS` file
- Release notes
- Project README

Thank you for contributing to hardware_info_kit!
