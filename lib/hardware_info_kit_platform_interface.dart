import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'hardware_info_kit_method_channel.dart';

abstract class HardwareInfoKitPlatform extends PlatformInterface {
  /// Constructs a HardwareInfoKitPlatform.
  HardwareInfoKitPlatform() : super(token: _token);

  static final Object _token = Object();

  static HardwareInfoKitPlatform _instance = MethodChannelHardwareInfoKit();

  /// The default instance of [HardwareInfoKitPlatform] to use.
  ///
  /// Defaults to [MethodChannelHardwareInfoKit].
  static HardwareInfoKitPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [HardwareInfoKitPlatform] when
  /// they register themselves.
  static set instance(HardwareInfoKitPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
