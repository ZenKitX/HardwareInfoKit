// This is a basic Flutter integration test.
//
// Since integration tests run in a full Flutter application, they can interact
// with the host side of a plugin implementation, unlike Dart unit tests.
//
// For more information about Flutter integration tests, please see
// https://flutter.dev/to/integration-testing

import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:hardware_info_kit/hardware_info_kit.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('getSystemInfo test', (WidgetTester tester) async {
    final systemInfo = await HardwareInfo.getSystemInfo();

    // Verify that we got some system information
    expect(systemInfo, isNotNull);
    expect(systemInfo.os, isNotNull);
    expect(systemInfo.cpu, isNotNull);
    expect(systemInfo.memory, isNotNull);
  });

  testWidgets('getCpuInfo test', (WidgetTester tester) async {
    final cpuInfo = await HardwareInfo.getCpuInfo();

    // Verify that we got CPU information
    expect(cpuInfo, isNotNull);
    // At least one of these should be non-null
    expect(
      cpuInfo.model != null ||
          cpuInfo.vendor != null ||
          cpuInfo.logicalCores != null,
      true,
    );
  });

  testWidgets('getMemoryInfo test', (WidgetTester tester) async {
    final memoryInfo = await HardwareInfo.getMemoryInfo();

    // Verify that we got memory information
    expect(memoryInfo, isNotNull);
    expect(memoryInfo.totalMemory, isNotNull);
    expect(memoryInfo.totalMemory! > 0, true);
  });
}
