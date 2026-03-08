// ignore_for_file: avoid_print

/// Benchmark tests for hardware_info_kit.
///
/// Run with: dart run benchmark/hardware_info_benchmark.dart
library;

import 'dart:async';
import 'package:hardware_info_kit/hardware_info_kit.dart';

void main() async {
  print('=== hardware_info_kit Performance Benchmark ===\n');

  // Run benchmarks
  await benchmarkSystemInfoRetrieval();
  await benchmarkIndividualInfoRetrieval();
  await benchmarkRepeatedCalls();
  await benchmarkConcurrentCalls();

  print('\n=== Benchmark Complete ===');
}

/// Benchmark: 获取完整系统信息的性能
Future<void> benchmarkSystemInfoRetrieval() async {
  print('--- System Info Retrieval Benchmark ---');

  final stopwatch = Stopwatch()..start();
  const iterations = 100;

  for (int i = 0; i < iterations; i++) {
    try {
      await HardwareInfo.getSystemInfo();
    } catch (e) {
      // 忽略错误（在非平台环境中可能失败）
    }
  }

  stopwatch.stop();
  final avgTime = stopwatch.elapsedMilliseconds / iterations;
  print(
    '  Get system info: ${avgTime.toStringAsFixed(2)} ms/op ($iterations iterations)',
  );
  print('');
}

/// Benchmark: 获取单个硬件信息的性能
Future<void> benchmarkIndividualInfoRetrieval() async {
  print('--- Individual Info Retrieval Benchmark ---');

  const iterations = 100;

  // CPU Info
  var stopwatch = Stopwatch()..start();
  for (int i = 0; i < iterations; i++) {
    try {
      await HardwareInfo.getCpuInfo();
    } catch (e) {
      // 忽略错误
    }
  }
  stopwatch.stop();
  print(
    '  Get CPU info: ${(stopwatch.elapsedMilliseconds / iterations).toStringAsFixed(2)} ms/op',
  );

  // Memory Info
  stopwatch = Stopwatch()..start();
  for (int i = 0; i < iterations; i++) {
    try {
      await HardwareInfo.getMemoryInfo();
    } catch (e) {
      // 忽略错误
    }
  }
  stopwatch.stop();
  print(
    '  Get memory info: ${(stopwatch.elapsedMilliseconds / iterations).toStringAsFixed(2)} ms/op',
  );

  // GPU Info
  stopwatch = Stopwatch()..start();
  for (int i = 0; i < iterations; i++) {
    try {
      await HardwareInfo.getGpuInfo();
    } catch (e) {
      // 忽略错误
    }
  }
  stopwatch.stop();
  print(
    '  Get GPU info: ${(stopwatch.elapsedMilliseconds / iterations).toStringAsFixed(2)} ms/op',
  );

  // Disk Info
  stopwatch = Stopwatch()..start();
  for (int i = 0; i < iterations; i++) {
    try {
      await HardwareInfo.getDiskInfo();
    } catch (e) {
      // 忽略错误
    }
  }
  stopwatch.stop();
  print(
    '  Get disk info: ${(stopwatch.elapsedMilliseconds / iterations).toStringAsFixed(2)} ms/op',
  );

  // OS Info
  stopwatch = Stopwatch()..start();
  for (int i = 0; i < iterations; i++) {
    try {
      await HardwareInfo.getOsInfo();
    } catch (e) {
      // 忽略错误
    }
  }
  stopwatch.stop();
  print(
    '  Get OS info: ${(stopwatch.elapsedMilliseconds / iterations).toStringAsFixed(2)} ms/op',
  );

  print('');
}

/// Benchmark: 重复调用的性能（测试缓存效果）
Future<void> benchmarkRepeatedCalls() async {
  print('--- Repeated Calls Benchmark ---');

  const iterations = 1000;

  final stopwatch = Stopwatch()..start();
  for (int i = 0; i < iterations; i++) {
    try {
      await HardwareInfo.getCpuInfo();
    } catch (e) {
      // 忽略错误
    }
  }
  stopwatch.stop();

  final avgTime = stopwatch.elapsedMilliseconds / iterations;
  print(
    '  Repeated CPU info calls: ${avgTime.toStringAsFixed(3)} ms/op ($iterations iterations)',
  );
  print('');
}

/// Benchmark: 并发调用的性能
Future<void> benchmarkConcurrentCalls() async {
  print('--- Concurrent Calls Benchmark ---');

  const concurrentCalls = 10;

  final stopwatch = Stopwatch()..start();

  try {
    await Future.wait([
      for (int i = 0; i < concurrentCalls; i++) HardwareInfo.getSystemInfo(),
    ]);
  } catch (e) {
    // 忽略错误
  }

  stopwatch.stop();

  final avgTime = stopwatch.elapsedMilliseconds / concurrentCalls;
  print(
    '  Concurrent system info calls: ${avgTime.toStringAsFixed(2)} ms/call ($concurrentCalls concurrent)',
  );
  print('  Total time: ${stopwatch.elapsedMilliseconds} ms');
  print('');
}
