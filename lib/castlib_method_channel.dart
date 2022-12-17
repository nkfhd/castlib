import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'castlib_platform_interface.dart';

/// An implementation of [CastlibPlatform] that uses method channels.
class MethodChannelCastlib extends CastlibPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('castlib');

  @override
  Future<dynamic> showConnectionDialog() async {
    return await methodChannel.invokeMethod('show_connection_dialog');
  }

  @override
  Future<dynamic> isConnected() async {
    return await methodChannel.invokeMethod('is_connected');
  }

  @override
  Future<dynamic> showControlDialog() async {
    return await methodChannel.invokeMethod('show_control_dialog');
  }

  @override
  Future<dynamic> startCasting(Map<String, dynamic> data) async {
    return await methodChannel.invokeMethod('start_casting', data);
  }
}
