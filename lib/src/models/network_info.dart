/// Network information
class NetworkInfo {
  NetworkInfo({
    this.ipv4,
    this.ipv6,
    this.macAddress,
    this.interfaceName,
  });

  factory NetworkInfo.fromJson(Map<String, dynamic> json) {
    return NetworkInfo(
      ipv4: json['IPv4'] ?? json['ipv4'] ?? json['IP地址'],
      ipv6: json['IPv6'] ?? json['ipv6'],
      macAddress: json['MAC Address'] ?? json['macAddress'] ?? json['MAC地址'],
      interfaceName: json['Interface'] ?? json['interfaceName'] ?? json['接口名称'],
    );
  }

  final String? ipv4;
  final String? ipv6;
  final String? macAddress;
  final String? interfaceName;

  Map<String, dynamic> toJson() {
    return {
      'ipv4': ipv4,
      'ipv6': ipv6,
      'macAddress': macAddress,
      'interfaceName': interfaceName,
    };
  }

  @override
  String toString() {
    return 'NetworkInfo(ipv4: $ipv4, ipv6: $ipv6, macAddress: $macAddress, interface: $interfaceName)';
  }
}
