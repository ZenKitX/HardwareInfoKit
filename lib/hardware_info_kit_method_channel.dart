import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'hardware_info_kit_platform_interface.dart';

/// An implementation of [HardwareInfoPlusPlatform] that uses method channels.
class MethodChannelHardwareInfoPlus extends HardwareInfoPlusPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('hardware_info_kit');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>(
      'getPlatformVersion',
    );
    return version;
  }
}
