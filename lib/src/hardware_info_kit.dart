import 'package:flutter/services.dart';
import 'models/models.dart';

/// Main class for accessing hardware information
class HardwareInfo {
  static const MethodChannel _channel = MethodChannel('hardware_info_kit');

  /// Get all hardware information at once
  ///
  /// Returns a [SystemInfo] object containing all available hardware data
  ///
  /// Example:
  /// ```dart
  /// final info = await HardwareInfo.getSystemInfo();
  /// print('CPU: ${info.cpu.model}');
  /// print('Memory: ${info.memory.totalMemory}');
  /// ```
  static Future<SystemInfo> getSystemInfo() async {
    try {
      final Map<dynamic, dynamic> result =
          await _channel.invokeMethod('getSystemInfo');
      return SystemInfo.fromJson(Map<String, dynamic>.from(result));
    } on PlatformException catch (e) {
      throw HardwareInfoException('Failed to get system info: ${e.message}');
    }
  }

  /// Get CPU information only
  ///
  /// Returns a [CpuInfo] object with processor details
  static Future<CpuInfo> getCpuInfo() async {
    try {
      final Map<dynamic, dynamic> result =
          await _channel.invokeMethod('getCpuInfo');
      return CpuInfo.fromJson(Map<String, dynamic>.from(result));
    } on PlatformException catch (e) {
      throw HardwareInfoException('Failed to get CPU info: ${e.message}');
    }
  }

  /// Get memory (RAM) information only
  ///
  /// Returns a [MemoryInfo] object with RAM details
  static Future<MemoryInfo> getMemoryInfo() async {
    try {
      final Map<dynamic, dynamic> result =
          await _channel.invokeMethod('getMemoryInfo');
      return MemoryInfo.fromJson(Map<String, dynamic>.from(result));
    } on PlatformException catch (e) {
      throw HardwareInfoException('Failed to get memory info: ${e.message}');
    }
  }

  /// Get GPU information only
  ///
  /// Returns a [GpuInfo] object with graphics card details
  static Future<GpuInfo> getGpuInfo() async {
    try {
      final Map<dynamic, dynamic> result =
          await _channel.invokeMethod('getGpuInfo');
      return GpuInfo.fromJson(Map<String, dynamic>.from(result));
    } on PlatformException catch (e) {
      throw HardwareInfoException('Failed to get GPU info: ${e.message}');
    }
  }

  /// Get disk/storage information only
  ///
  /// Returns a [DiskInfo] object with storage details
  static Future<DiskInfo> getDiskInfo() async {
    try {
      final Map<dynamic, dynamic> result =
          await _channel.invokeMethod('getDiskInfo');
      return DiskInfo.fromJson(Map<String, dynamic>.from(result));
    } on PlatformException catch (e) {
      throw HardwareInfoException('Failed to get disk info: ${e.message}');
    }
  }

  /// Get operating system information only
  ///
  /// Returns an [OsInfo] object with OS details
  static Future<OsInfo> getOsInfo() async {
    try {
      final Map<dynamic, dynamic> result =
          await _channel.invokeMethod('getOsInfo');
      return OsInfo.fromJson(Map<String, dynamic>.from(result));
    } on PlatformException catch (e) {
      throw HardwareInfoException('Failed to get OS info: ${e.message}');
    }
  }

  /// Get battery information only (if available)
  ///
  /// Returns a [BatteryInfo] object with battery details
  /// Returns null if no battery is present
  static Future<BatteryInfo?> getBatteryInfo() async {
    try {
      final Map<dynamic, dynamic>? result =
          await _channel.invokeMethod('getBatteryInfo');
      if (result == null || result.isEmpty) return null;
      return BatteryInfo.fromJson(Map<String, dynamic>.from(result));
    } on PlatformException catch (e) {
      throw HardwareInfoException('Failed to get battery info: ${e.message}');
    }
  }

  /// Get network information only
  ///
  /// Returns a [NetworkInfo] object with network details
  static Future<NetworkInfo> getNetworkInfo() async {
    try {
      final Map<dynamic, dynamic> result =
          await _channel.invokeMethod('getNetworkInfo');
      return NetworkInfo.fromJson(Map<String, dynamic>.from(result));
    } on PlatformException catch (e) {
      throw HardwareInfoException('Failed to get network info: ${e.message}');
    }
  }
}

/// Exception thrown when hardware information cannot be retrieved
class HardwareInfoException implements Exception {
  HardwareInfoException(this.message);

  final String message;

  @override
  String toString() => 'HardwareInfoException: $message';
}
