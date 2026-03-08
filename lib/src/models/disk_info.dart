/// Disk/Storage information
class DiskInfo {
  DiskInfo({
    this.totalSpace,
    this.freeSpace,
    this.usedSpace,
    this.driveCount,
  });

  factory DiskInfo.fromJson(Map<String, dynamic> json) {
    int? parseSpace(dynamic value) {
      if (value == null) return null;
      if (value is int) return value;
      if (value is String) {
        final match = RegExp(r'([\d.]+)\s*GB').firstMatch(value);
        if (match != null) {
          final gb = double.tryParse(match.group(1)!);
          if (gb != null) return (gb * 1024 * 1024 * 1024).toInt();
        }
        return int.tryParse(value);
      }
      return null;
    }

    return DiskInfo(
      totalSpace:
          parseSpace(json['C: Total'] ?? json['totalSpace'] ?? json['总容量']),
      freeSpace:
          parseSpace(json['C: Free'] ?? json['freeSpace'] ?? json['可用空间']),
      usedSpace: parseSpace(json['usedSpace'] ?? json['已用空间']),
      driveCount: json['Drive Count'] ?? json['driveCount'] ?? json['驱动器数量'],
    );
  }

  final int? totalSpace; // in bytes
  final int? freeSpace; // in bytes
  final int? usedSpace; // in bytes
  final int? driveCount;

  /// Total space in GB
  double? get totalSpaceGB =>
      totalSpace != null ? totalSpace! / (1024 * 1024 * 1024) : null;

  /// Free space in GB
  double? get freeSpaceGB =>
      freeSpace != null ? freeSpace! / (1024 * 1024 * 1024) : null;

  /// Used space in GB
  double? get usedSpaceGB =>
      usedSpace != null ? usedSpace! / (1024 * 1024 * 1024) : null;

  /// Usage percentage
  double? get usagePercentage {
    if (totalSpace != null && usedSpace != null && totalSpace! > 0) {
      return (usedSpace! / totalSpace!) * 100;
    }
    return null;
  }

  Map<String, dynamic> toJson() {
    return {
      'totalSpace': totalSpace,
      'freeSpace': freeSpace,
      'usedSpace': usedSpace,
      'driveCount': driveCount,
    };
  }

  @override
  String toString() {
    return 'DiskInfo(total: ${totalSpaceGB?.toStringAsFixed(2)} GB, free: ${freeSpaceGB?.toStringAsFixed(2)} GB, used: ${usedSpaceGB?.toStringAsFixed(2)} GB, drives: $driveCount)';
  }
}
