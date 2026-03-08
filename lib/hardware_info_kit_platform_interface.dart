import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'hardware_info_kit_method_channel.dart';

abstract class HardwareInfoPlusPlatform extends PlatformInterface {
  /// Constructs a HardwareInfoPlusPlatform.
  HardwareInfoPlusPlatform() : super(token: _token);

  static final Object _token = Object();

  static HardwareInfoPlusPlatform _instance = MethodChannelHardwareInfoPlus();

  /// The default instance of [HardwareInfoPlusPlatform] to use.
  ///
  /// Defaults to [MethodChannelHardwareInfoPlus].
  static HardwareInfoPlusPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [HardwareInfoPlusPlatform] when
  /// they register themselves.
  static set instance(HardwareInfoPlusPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
