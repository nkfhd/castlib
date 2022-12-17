import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'castlib_method_channel.dart';

abstract class CastlibPlatform extends PlatformInterface {
  /// Constructs a CastlibPlatform.
  CastlibPlatform() : super(token: _token);

  static final Object _token = Object();

  static CastlibPlatform _instance = MethodChannelCastlib();

  /// The default instance of [CastlibPlatform] to use.
  ///
  /// Defaults to [MethodChannelCastlib].
  static CastlibPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [CastlibPlatform] when
  /// they register themselves.
  static set instance(CastlibPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
