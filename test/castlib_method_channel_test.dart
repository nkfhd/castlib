import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:castlib/castlib_method_channel.dart';

void main() {
  MethodChannelCastlib platform = MethodChannelCastlib();
  const MethodChannel channel = MethodChannel('castlib');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
