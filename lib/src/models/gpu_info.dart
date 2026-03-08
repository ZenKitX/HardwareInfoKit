/// GPU/Graphics card information
class GpuInfo {
  GpuInfo({
    this.model,
    this.vendor,
    this.memory,
    this.driverVersion,
  });

  factory GpuInfo.fromJson(Map<String, dynamic> json) {
    return GpuInfo(
      model: json['Model'] ?? json['model'] ?? json['型号'],
      vendor: json['Vendor'] ?? json['vendor'] ?? json['厂商'],
      memory: json['Memory'] ?? json['memory'] ?? json['显存'],
      driverVersion:
          json['Driver Version'] ?? json['driverVersion'] ?? json['驱动版本'],
    );
  }

  final String? model;
  final String? vendor;
  final int? memory; // in bytes
  final String? driverVersion;

  /// GPU memory in GB
  double? get memoryGB =>
      memory != null ? memory! / (1024 * 1024 * 1024) : null;

  Map<String, dynamic> toJson() {
    return {
      'model': model,
      'vendor': vendor,
      'memory': memory,
      'driverVersion': driverVersion,
    };
  }

  @override
  String toString() {
    return 'GpuInfo(model: $model, vendor: $vendor, memory: ${memoryGB?.toStringAsFixed(2)} GB, driverVersion: $driverVersion)';
  }
}
