# Hardware Info Kit - Usage Guide

## Quick Start

### 1. Installation

Add the dependency to your Flutter project's `pubspec.yaml`:

```yaml
dependencies:
  hardware_info_kit: ^1.0.0
```

Then run:

```bash
flutter pub get
```

### 2. Import

```dart
import 'package:hardware_info_kit/hardware_info_kit.dart';
```

### 3. Usage

```dart
// Get all hardware information
final systemInfo = await HardwareInfo.getSystemInfo();

// Or get specific information only
final cpuInfo = await HardwareInfo.getCpuInfo();
final memoryInfo = await HardwareInfo.getMemoryInfo();
```

## Detailed Examples

### Example 1: Display System Overview

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
      print('Error loading system info: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_systemInfo == null) {
      return const Center(child: Text('Failed to load system information'));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('CPU: ${_systemInfo!.cpu.model ?? "Unknown"}'),
        Text('Memory: ${_systemInfo!.memory.totalMemoryGB?.toStringAsFixed(2) ?? "Unknown"} GB'),
        Text('OS: ${_systemInfo!.os.name ?? "Unknown"}'),
      ],
    );
  }
}
```

### Example 2: Memory Monitor

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
      print('Error updating memory info: $e');
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
              'Memory Usage',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            LinearProgressIndicator(
              value: usagePercent / 100,
              minHeight: 10,
            ),
            const SizedBox(height: 8),
            Text('${usagePercent.toStringAsFixed(1)}% used'),
            const SizedBox(height: 16),
            Text('Total: $totalGB GB'),
            Text('Used: $usedGB GB'),
            Text('Available: $availableGB GB'),
          ],
        ),
      ),
    );
  }
}
```

### Example 3: CPU Information Display

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
              'CPU Information',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            _buildInfoRow('Model', cpuInfo.model),
            _buildInfoRow('Vendor', cpuInfo.vendor),
            _buildInfoRow('Architecture', cpuInfo.architecture),
            _buildInfoRow('Logical Cores', cpuInfo.logicalCores?.toString()),
            _buildInfoRow('Physical Cores', cpuInfo.physicalCores?.toString()),
            _buildInfoRow(
              'Frequency',
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
            width: 140,
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

### Example 4: Battery Status

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
      print('Error loading battery info: $e');
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
          child: Text('No battery detected'),
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
                  'Battery',
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
            Text('Status: ${isCharging ? "Charging" : "Discharging"}'),
            if (_batteryInfo!.health != null)
              Text('Health: ${_batteryInfo!.health}'),
            if (_batteryInfo!.temperature != null)
              Text('Temperature: ${_batteryInfo!.temperature!.toStringAsFixed(1)}°C'),
          ],
        ),
      ),
    );
  }
}
```

### Example 5: Complete Hardware Dashboard

```dart
import 'package:flutter/material.dart';
import 'package:hardware_info_kit/hardware_info_kit.dart';

class HardwareDashboard extends StatefulWidget {
  const HardwareDashboard({super.key});

  @override
  State<HardwareDashboard> createState() => _HardwareDashboardState();
}

class _HardwareDashboardState extends State<HardwareDashboard> {
  SystemInfo? _systemInfo;
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadSystemInfo();
  }

  Future<void> _loadSystemInfo() async {
    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      final info = await HardwareInfo.getSystemInfo();
      setState(() {
        _systemInfo = info;
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hardware Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadSystemInfo,
          ),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 48, color: Colors.red),
            const SizedBox(height: 16),
            Text('Error: $_error'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _loadSystemInfo,
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildSection('Operating System', [
          _buildItem('Name', _systemInfo!.os.name),
          _buildItem('Version', _systemInfo!.os.version),
          _buildItem('Architecture', _systemInfo!.os.architecture),
          _buildItem('Computer Name', _systemInfo!.os.computerName),
        ]),
        _buildSection('CPU', [
          _buildItem('Model', _systemInfo!.cpu.model),
          _buildItem('Vendor', _systemInfo!.cpu.vendor),
          _buildItem('Logical Cores', _systemInfo!.cpu.logicalCores?.toString()),
          _buildItem('Physical Cores', _systemInfo!.cpu.physicalCores?.toString()),
          _buildItem(
            'Frequency',
            _systemInfo!.cpu.frequency != null
                ? '${_systemInfo!.cpu.frequency!.toStringAsFixed(0)} MHz'
                : null,
          ),
        ]),
        _buildSection('Memory', [
          _buildItem(
            'Total',
            _systemInfo!.memory.totalMemoryGB != null
                ? '${_systemInfo!.memory.totalMemoryGB!.toStringAsFixed(2)} GB'
                : null,
          ),
          _buildItem(
            'Available',
            _systemInfo!.memory.availableMemoryGB != null
                ? '${_systemInfo!.memory.availableMemoryGB!.toStringAsFixed(2)} GB'
                : null,
          ),
          _buildItem(
            'Used',
            _systemInfo!.memory.usedMemoryGB != null
                ? '${_systemInfo!.memory.usedMemoryGB!.toStringAsFixed(2)} GB'
                : null,
          ),
          _buildItem(
            'Usage',
            _systemInfo!.memory.usagePercentage != null
                ? '${_systemInfo!.memory.usagePercentage!.toStringAsFixed(1)}%'
                : null,
          ),
        ]),
        _buildSection('GPU', [
          _buildItem('Model', _systemInfo!.gpu.model),
          _buildItem('Vendor', _systemInfo!.gpu.vendor),
          _buildItem(
            'Memory',
            _systemInfo!.gpu.memoryGB != null
                ? '${_systemInfo!.gpu.memoryGB!.toStringAsFixed(2)} GB'
                : null,
          ),
          _buildItem('Driver Version', _systemInfo!.gpu.driverVersion),
        ]),
        _buildSection('Disk', [
          _buildItem(
            'Total Space',
            _systemInfo!.disk.totalSpaceGB != null
                ? '${_systemInfo!.disk.totalSpaceGB!.toStringAsFixed(2)} GB'
                : null,
          ),
          _buildItem(
            'Free Space',
            _systemInfo!.disk.freeSpaceGB != null
                ? '${_systemInfo!.disk.freeSpaceGB!.toStringAsFixed(2)} GB'
                : null,
          ),
          _buildItem(
            'Used Space',
            _systemInfo!.disk.usedSpaceGB != null
                ? '${_systemInfo!.disk.usedSpaceGB!.toStringAsFixed(2)} GB'
                : null,
          ),
          _buildItem(
            'Usage',
            _systemInfo!.disk.usagePercentage != null
                ? '${_systemInfo!.disk.usagePercentage!.toStringAsFixed(1)}%'
                : null,
          ),
        ]),
        if (_systemInfo!.battery != null)
          _buildSection('Battery', [
            _buildItem('Level', '${_systemInfo!.battery!.level}%'),
            _buildItem(
              'Status',
              _systemInfo!.battery!.isCharging == true ? 'Charging' : 'Discharging',
            ),
            _buildItem('Health', _systemInfo!.battery!.health),
            _buildItem(
              'Temperature',
              _systemInfo!.battery!.temperature != null
                  ? '${_systemInfo!.battery!.temperature!.toStringAsFixed(1)}°C'
                  : null,
            ),
          ]),
        if (_systemInfo!.network != null)
          _buildSection('Network', [
            _buildItem('IPv4', _systemInfo!.network!.ipv4),
            _buildItem('IPv6', _systemInfo!.network!.ipv6),
            _buildItem('MAC Address', _systemInfo!.network!.macAddress),
            _buildItem('Interface', _systemInfo!.network!.interfaceName),
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
            width: 140,
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

## Error Handling

Always wrap hardware information calls in try-catch blocks:

```dart
try {
  final systemInfo = await HardwareInfo.getSystemInfo();
  // Use systemInfo
} on HardwareInfoException catch (e) {
  print('Hardware info error: ${e.message}');
  print('Error code: ${e.code}');
} catch (e) {
  print('Unexpected error: $e');
}
```

## Performance Tips

1. **Cache static information**: CPU model, total memory, etc. don't change
2. **Throttle updates**: Don't query too frequently (recommended: 1-5 seconds minimum)
3. **Use specific methods**: Only get the information you need

```dart
// Good: Only get what you need
final memoryInfo = await HardwareInfo.getMemoryInfo();

// Less efficient: Get everything when you only need memory
final systemInfo = await HardwareInfo.getSystemInfo();
final memoryInfo = systemInfo.memory;
```

## Platform-Specific Considerations

### Windows

- Some information requires administrator privileges
- GPU information is basic (can be extended with WMI queries)
- Battery information only available on laptops

### Android

- Requires appropriate permissions in AndroidManifest.xml
- Battery information includes temperature and voltage
- Some information may be restricted on newer Android versions

## More Resources

- [API Documentation](https://pub.dev/documentation/hardware_info_kit/latest/)
- [GitHub Repository](https://github.com/h1s97x/HardwareInfoKit)
- [Issue Tracker](https://github.com/h1s97x/HardwareInfoKit/issues)
- [Example App](https://github.com/h1s97x/HardwareInfoKit/tree/main/example)
