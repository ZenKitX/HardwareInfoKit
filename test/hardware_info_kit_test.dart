import 'package:flutter_test/flutter_test.dart';
import 'package:hardware_info_kit/hardware_info_kit.dart';

void main() {
  test('CpuInfo fromJson', () {
    final json = {
      'Model': 'Intel Core i5',
      'Logical Cores': 8,
      'Architecture': 'x64',
    };

    final cpuInfo = CpuInfo.fromJson(json);

    expect(cpuInfo.model, 'Intel Core i5');
    expect(cpuInfo.logicalCores, 8);
    expect(cpuInfo.architecture, 'x64');
  });

  test('MemoryInfo fromJson with GB format', () {
    final json = {
      'Total Memory': '16.00 GB',
      'Available Memory': '8.00 GB',
      'Usage': '50%',
    };

    final memoryInfo = MemoryInfo.fromJson(json);

    expect(memoryInfo.totalMemoryGB, closeTo(16.0, 0.1));
    expect(memoryInfo.availableMemoryGB, closeTo(8.0, 0.1));
    expect(memoryInfo.usagePercentage, 50.0);
  });

  test('BatteryInfo fromJson', () {
    final json = {
      'Battery Level': '80%',
      'Charging Status': 'Charging',
    };

    final batteryInfo = BatteryInfo.fromJson(json);

    expect(batteryInfo.level, 80);
    expect(batteryInfo.isCharging, true);
  });
}
