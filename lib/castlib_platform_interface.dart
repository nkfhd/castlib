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

  Future<dynamic> showConnectionDialog() {
    throw UnimplementedError('showConnectionDialog() has not been implemented.');
  }

  Future<dynamic> isConnected() {
    throw UnimplementedError('isConnected() has not been implemented.');
  }

  Future<dynamic> showControlDialog() {
    throw UnimplementedError('showControlDialog() has not been implemented.');
  }

  Future<dynamic> startCasting(Map<String, dynamic> data) {
    throw UnimplementedError('startCasting() has not been implemented.');
  }
}
