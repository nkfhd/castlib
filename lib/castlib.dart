
import 'castlib_platform_interface.dart';

class Castlib {
  Future<String?> getPlatformVersion() {
    return CastlibPlatform.instance.getPlatformVersion();
  }
}
