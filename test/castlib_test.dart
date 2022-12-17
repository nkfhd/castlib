import 'package:flutter_test/flutter_test.dart';
import 'package:castlib/castlib.dart';
import 'package:castlib/castlib_platform_interface.dart';
import 'package:castlib/castlib_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockCastlibPlatform
    with MockPlatformInterfaceMixin
    implements CastlibPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final CastlibPlatform initialPlatform = CastlibPlatform.instance;

  test('$MethodChannelCastlib is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelCastlib>());
  });

  test('getPlatformVersion', () async {
    Castlib castlibPlugin = Castlib();
    MockCastlibPlatform fakePlatform = MockCastlibPlatform();
    CastlibPlatform.instance = fakePlatform;

    expect(await castlibPlugin.getPlatformVersion(), '42');
  });
}
