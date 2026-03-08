/// CPU/Processor information
class CpuInfo {
  CpuInfo({
    this.model,
    this.vendor,
    this.architecture,
    this.logicalCores,
    this.physicalCores,
    this.frequency,
    this.cacheSize,
  });

  factory CpuInfo.fromJson(Map<String, dynamic> json) {
    return CpuInfo(
      model: json['Model'] ?? json['model'] ?? json['型号'],
      vendor: json['Vendor'] ?? json['vendor'] ?? json['厂商'],
      architecture: json['Architecture'] ?? json['architecture'] ?? json['架构'],
      logicalCores: _parseInt(
          json['Logical Cores'] ?? json['logicalCores'] ?? json['逻辑核心数']),
      physicalCores: _parseInt(
          json['Physical Cores'] ?? json['physicalCores'] ?? json['物理核心数']),
      frequency:
          _parseDouble(json['Frequency'] ?? json['frequency'] ?? json['频率']),
      cacheSize:
          _parseInt(json['Cache Size'] ?? json['cacheSize'] ?? json['缓存大小']),
    );
  }

  final String? model;
  final String? vendor;
  final String? architecture;
  final int? logicalCores;
  final int? physicalCores;
  final double? frequency; // in MHz
  final int? cacheSize; // in bytes

  Map<String, dynamic> toJson() {
    return {
      'model': model,
      'vendor': vendor,
      'architecture': architecture,
      'logicalCores': logicalCores,
      'physicalCores': physicalCores,
      'frequency': frequency,
      'cacheSize': cacheSize,
    };
  }

  static int? _parseInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    if (value is String) return int.tryParse(value);
    return null;
  }

  static double? _parseDouble(dynamic value) {
    if (value == null) return null;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value);
    return null;
  }

  @override
  String toString() {
    return 'CpuInfo(model: $model, vendor: $vendor, architecture: $architecture, logicalCores: $logicalCores, physicalCores: $physicalCores, frequency: $frequency MHz, cacheSize: $cacheSize bytes)';
  }
}
