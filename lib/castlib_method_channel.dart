import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'castlib_platform_interface.dart';

/// An implementation of [CastlibPlatform] that uses method channels.
class MethodChannelCastlib extends CastlibPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('castlib');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
