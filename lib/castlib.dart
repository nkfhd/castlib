import 'castlib_platform_interface.dart';

class Castlib {
  Future<dynamic> showConnectionDialog() {
    return CastlibPlatform.instance.showConnectionDialog();
  }

  Future<dynamic> isConnected() {
    return CastlibPlatform.instance.isConnected();
  }

  Future<dynamic> showControlDialog() {
    return CastlibPlatform.instance.showControlDialog();
  }

  Future<dynamic> startCasting(Map<String, dynamic> data) {
    return CastlibPlatform.instance.startCasting(data);
  }

  Future<dynamic> stopCasting() {
    return CastlibPlatform.instance.stopCasting();
  }
}
