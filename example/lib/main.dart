import 'package:flutter/material.dart';
import 'package:hardware_info_kit/hardware_info_kit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hardware Info Kit Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const HardwareInfoDemo(),
    );
  }
}

class HardwareInfoDemo extends StatefulWidget {
  const HardwareInfoDemo({super.key});

  @override
  State<HardwareInfoDemo> createState() => _HardwareInfoDemoState();
}

class _HardwareInfoDemoState extends State<HardwareInfoDemo> {
  SystemInfo? _systemInfo;
  bool _isLoading = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadSystemInfo();
  }

  Future<void> _loadSystemInfo() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final info = await HardwareInfo.getSystemInfo();
      setState(() {
        _systemInfo = info;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hardware Info Kit'),
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
    if (_isLoading) {
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

    if (_systemInfo == null) {
      return const Center(child: Text('No data'));
    }

    return RefreshIndicator(
      onRefresh: _loadSystemInfo,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildInfoCard('Operating System', _buildOsInfo()),
          _buildInfoCard('CPU', _buildCpuInfo()),
          _buildInfoCard('Memory', _buildMemoryInfo()),
          _buildInfoCard('GPU', _buildGpuInfo()),
          _buildInfoCard('Disk', _buildDiskInfo()),
          if (_systemInfo!.battery != null)
            _buildInfoCard('Battery', _buildBatteryInfo()),
        ],
      ),
    );
  }

  Widget _buildInfoCard(String title, Widget content) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const Divider(),
            content,
          ],
        ),
      ),
    );
  }

  Widget _buildOsInfo() {
    final os = _systemInfo!.os;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildInfoRow('System', os.name),
        _buildInfoRow('Architecture', os.architecture),
        _buildInfoRow('Computer Name', os.computerName),
        _buildInfoRow('Version', os.version),
        _buildInfoRow('Kernel', os.kernel),
      ],
    );
  }

  Widget _buildCpuInfo() {
    final cpu = _systemInfo!.cpu;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildInfoRow('Model', cpu.model),
        _buildInfoRow('Vendor', cpu.vendor),
        _buildInfoRow('Architecture', cpu.architecture),
        _buildInfoRow('Logical Cores', cpu.logicalCores?.toString()),
        _buildInfoRow('Physical Cores', cpu.physicalCores?.toString()),
        _buildInfoRow(
          'Frequency',
          cpu.frequency != null ? '${cpu.frequency} MHz' : null,
        ),
      ],
    );
  }

  Widget _buildMemoryInfo() {
    final memory = _systemInfo!.memory;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildInfoRow(
          'Total',
          memory.totalMemoryGB != null
              ? '${memory.totalMemoryGB!.toStringAsFixed(2)} GB'
              : null,
        ),
        _buildInfoRow(
          'Available',
          memory.availableMemoryGB != null
              ? '${memory.availableMemoryGB!.toStringAsFixed(2)} GB'
              : null,
        ),
        _buildInfoRow(
          'Used',
          memory.usedMemoryGB != null
              ? '${memory.usedMemoryGB!.toStringAsFixed(2)} GB'
              : null,
        ),
        _buildInfoRow(
          'Usage',
          memory.usagePercentage != null
              ? '${memory.usagePercentage!.toStringAsFixed(1)}%'
              : null,
        ),
      ],
    );
  }

  Widget _buildGpuInfo() {
    final gpu = _systemInfo!.gpu;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildInfoRow('Model', gpu.model),
        _buildInfoRow('Vendor', gpu.vendor),
        _buildInfoRow(
          'Memory',
          gpu.memoryGB != null
              ? '${gpu.memoryGB!.toStringAsFixed(2)} GB'
              : null,
        ),
        _buildInfoRow('Driver Version', gpu.driverVersion),
      ],
    );
  }

  Widget _buildDiskInfo() {
    final disk = _systemInfo!.disk;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildInfoRow(
          'Total Space',
          disk.totalSpaceGB != null
              ? '${disk.totalSpaceGB!.toStringAsFixed(2)} GB'
              : null,
        ),
        _buildInfoRow(
          'Free Space',
          disk.freeSpaceGB != null
              ? '${disk.freeSpaceGB!.toStringAsFixed(2)} GB'
              : null,
        ),
        _buildInfoRow(
          'Used Space',
          disk.usedSpaceGB != null
              ? '${disk.usedSpaceGB!.toStringAsFixed(2)} GB'
              : null,
        ),
        _buildInfoRow(
          'Usage',
          disk.usagePercentage != null
              ? '${disk.usagePercentage!.toStringAsFixed(1)}%'
              : null,
        ),
        _buildInfoRow('Drive Count', disk.driveCount?.toString()),
      ],
    );
  }

  Widget _buildBatteryInfo() {
    final battery = _systemInfo!.battery!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildInfoRow(
          'Level',
          battery.level != null ? '${battery.level}%' : null,
        ),
        _buildInfoRow(
          'Charging',
          battery.isCharging != null
              ? (battery.isCharging! ? 'Yes' : 'No')
              : null,
        ),
        _buildInfoRow('Health', battery.health),
        _buildInfoRow(
          'Temperature',
          battery.temperature != null ? '${battery.temperature}°C' : null,
        ),
        _buildInfoRow(
          'Voltage',
          battery.voltage != null ? '${battery.voltage}V' : null,
        ),
      ],
    );
  }

  Widget _buildInfoRow(String label, String? value) {
    if (value == null || value.isEmpty || value == 'null') {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
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
            child: Text(value, style: const TextStyle(color: Colors.black87)),
          ),
        ],
      ),
    );
  }
}
