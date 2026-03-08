# Hardware Info Kit - 使用指南

[English Version](USAGE_GUIDE_EN.md)

## 快速开始

### 1. 安装

在 `pubspec.yaml` 中添加依赖：

```yaml
dependencies:
  hardware_info_kit: ^1.0.0
```

然后运行：

```bash
flutter pub get
```

### 2. 导入

```dart
import 'package:hardware_info_kit/hardware_info_kit.dart';
```

### 3. 使用

```dart
// 获取所有硬件信息
final systemInfo = await HardwareInfo.getSystemInfo();

// 或者只获取特定信息
final cpuInfo = await HardwareInfo.getCpuInfo();
final memoryInfo = await HardwareInfo.getMemoryInfo();
```

## 详细示例

### 示例 1：显示系统概览

```dart
import 'package:flutter/material.dart';
import 'package:hardware_info_kit/hardware_info_kit.dart';

class SystemOverview extends StatefulWidget {
  const SystemOverview({super.key});

  @override
  State<SystemOverview> createState() => _SystemOverviewState();
}

class _SystemOverviewState extends State<SystemOverview> {
  SystemInfo? _systemInfo;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadSystemInfo();
  }

  Future<void> _loadSystemInfo() async {
    try {
      final info = await HardwareInfo.getSystemInfo();
      setState(() {
        _systemInfo = info;
        _loading = false;
      });
    } catch (e) {
      setState(() => _loading = false);
      print('加载系统信息失败: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_systemInfo == null) {
      return const Center(child: Text('无法加载系统信息'));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('CPU: ${_systemInfo!.cpu.model ?? "未知"}'),
        Text('内存: ${_systemInfo!.memory.totalMemoryGB?.toStringAsFixed(2) ?? "未知"} GB'),
        Text('系统: ${_systemInfo!.os.name ?? "未知"}'),
      ],
    );
  }
}
```

### 示例 2：内存监控

```dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hardware_info_kit/hardware_info_kit.dart';

class MemoryMonitor extends StatefulWidget {
  const MemoryMonitor({super.key});

  @override
  State<MemoryMonitor> createState() => _MemoryMonitorState();
}

class _MemoryMonitorState extends State<MemoryMonitor> {
  MemoryInfo? _memoryInfo;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startMonitoring();
  }

  void _startMonitoring() {
    _updateMemoryInfo();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      _updateMemoryInfo();
    });
  }

  Future<void> _updateMemoryInfo() async {
    try {
      final info = await HardwareInfo.getMemoryInfo();
      setState(() => _memoryInfo = info);
    } catch (e) {
      print('更新内存信息失败: $e');
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_memoryInfo == null) {
      return const CircularProgressIndicator();
    }

    final usagePercent = _memoryInfo!.usagePercentage ?? 0;
    final totalGB = _memoryInfo!.totalMemoryGB?.toStringAsFixed(2) ?? "0";
    final usedGB = _memoryInfo!.usedMemoryGB?.toStringAsFixed(2) ?? "0";
    final availableGB = _memoryInfo!.availableMemoryGB?.toStringAsFixed(2) ?? "0";

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '内存使用情况',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            LinearProgressIndicator(
              value: usagePercent / 100,
              minHeight: 10,
            ),
            const SizedBox(height: 8),
            Text('${usagePercent.toStringAsFixed(1)}% 已使用'),
            const SizedBox(height: 16),
            Text('总计: $totalGB GB'),
            Text('已用: $usedGB GB'),
            Text('可用: $availableGB GB'),
          ],
        ),
      ),
    );
  }
}
```

### 示例 3：CPU 信息显示

```dart
import 'package:flutter/material.dart';
import 'package:hardware_info_kit/hardware_info_kit.dart';

class CpuInfoDisplay extends StatelessWidget {
  final CpuInfo cpuInfo;

  const CpuInfoDisplay({super.key, required this.cpuInfo});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'CPU 信息',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            _buildInfoRow('型号', cpuInfo.model),
            _buildInfoRow('厂商', cpuInfo.vendor),
            _buildInfoRow('架构', cpuInfo.architecture),
            _buildInfoRow('逻辑核心', cpuInfo.logicalCores?.toString()),
            _buildInfoRow('物理核心', cpuInfo.physicalCores?.toString()),
            _buildInfoRow(
              '频率',
              cpuInfo.frequency != null
                  ? '${cpuInfo.frequency!.toStringAsFixed(0)} MHz'
                  : null,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          SizedBox(
            width: 100,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
            child: Text(value ?? '未知'),
          ),
        ],
      ),
    );
  }
}
```

### 示例 4：电池状态

```dart
import 'package:flutter/material.dart';
import 'package:hardware_info_kit/hardware_info_kit.dart';

class BatteryStatus extends StatefulWidget {
  const BatteryStatus({super.key});

  @override
  State<BatteryStatus> createState() => _BatteryStatusState();
}

class _BatteryStatusState extends State<BatteryStatus> {
  BatteryInfo? _batteryInfo;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadBatteryInfo();
  }

  Future<void> _loadBatteryInfo() async {
    try {
      final info = await HardwareInfo.getBatteryInfo();
      setState(() {
        _batteryInfo = info;
        _loading = false;
      });
    } catch (e) {
      setState(() => _loading = false);
      print('加载电池信息失败: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_batteryInfo == null) {
      return const Card(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Text('未检测到电池'),
        ),
      );
    }

    final level = _batteryInfo!.level ?? 0;
    final isCharging = _batteryInfo!.isCharging ?? false;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  '电池',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const Spacer(),
                Icon(
                  isCharging ? Icons.battery_charging_full : Icons.battery_std,
                  color: level < 20 ? Colors.red : Colors.green,
                ),
              ],
            ),
            const SizedBox(height: 16),
            LinearProgressIndicator(
              value: level / 100,
              minHeight: 10,
              backgroundColor: Colors.grey[300],
              color: level < 20 ? Colors.red : Colors.green,
            ),
            const SizedBox(height: 8),
            Text('$level%'),
            const SizedBox(height: 16),
            Text('状态: ${isCharging ? "充电中" : "放电中"}'),
            if (_batteryInfo!.health != null)
              Text('健康度: ${_batteryInfo!.health}'),
            if (_batteryInfo!.temperature != null)
              Text('温度: ${_batteryInfo!.temperature!.toStringAsFixed(1)}°C'),
          ],
        ),
      ),
    );
  }
}
```

## 错误处理

始终使用 try-catch 包装硬件信息调用：

```dart
try {
  final systemInfo = await HardwareInfo.getSystemInfo();
  // 使用 systemInfo
} on HardwareInfoException catch (e) {
  print('硬件信息错误: ${e.message}');
  print('错误代码: ${e.code}');
} catch (e) {
  print('未知错误: $e');
}
```

## 性能建议

1. **缓存静态信息**：CPU 型号、总内存等不会改变的信息
2. **限制更新频率**：不要查询太频繁（建议：最少 1-5 秒间隔）
3. **使用特定方法**：只获取需要的信息

```dart
// 好的做法：只获取需要的信息
final memoryInfo = await HardwareInfo.getMemoryInfo();

// 效率较低：获取所有信息但只用内存
final systemInfo = await HardwareInfo.getSystemInfo();
final memoryInfo = systemInfo.memory;
```

## 平台特定注意事项

### Windows

- 某些信息需要管理员权限
- GPU 信息为基础信息（可通过 WMI 查询扩展）
- 电池信息仅在笔记本电脑上可用

### Android

- 需要在 AndroidManifest.xml 中添加适当权限
- 电池信息包含温度和电压
- 某些信息在较新的 Android 版本上可能受限

## 更多资源

- [API 文档](doc/API.md) - 完整 API 参考
- [GitHub 仓库](https://github.com/yourusername/hardware_info_kit)
- [问题追踪](https://github.com/yourusername/hardware_info_kit/issues)
- [示例应用](https://github.com/yourusername/hardware_info_kit/tree/main/example)
