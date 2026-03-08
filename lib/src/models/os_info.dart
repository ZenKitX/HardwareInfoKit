/// Operating System information
class OsInfo {
  OsInfo({
    this.name,
    this.version,
    this.architecture,
    this.computerName,
    this.kernel,
  });

  factory OsInfo.fromJson(Map<String, dynamic> json) {
    return OsInfo(
      name: json['System'] ?? json['name'] ?? json['系统'],
      version: json['Version'] ?? json['version'] ?? json['版本'],
      architecture: json['Architecture'] ?? json['architecture'] ?? json['架构'],
      computerName:
          json['Computer Name'] ?? json['computerName'] ?? json['计算机名'],
      kernel: json['Kernel'] ?? json['kernel'] ?? json['内核'],
    );
  }

  final String? name;
  final String? version;
  final String? architecture;
  final String? computerName;
  final String? kernel;

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'version': version,
      'architecture': architecture,
      'computerName': computerName,
      'kernel': kernel,
    };
  }

  @override
  String toString() {
    return 'OsInfo(name: $name, version: $version, architecture: $architecture, computerName: $computerName, kernel: $kernel)';
  }
}
