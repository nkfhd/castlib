import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:castlib/castlib.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _castlibPlugin = Castlib();
  bool connected = false;

  @override
  void initState() {
    super.initState();
    _checkConnection();
  }

  _showConnectionDialog() async {
    var result = await _castlibPlugin.showConnectionDialog();
    if (kDebugMode) {
      print("result: $result");
    }
  }

  _checkConnection() async {
    var result = await _castlibPlugin.isConnected();
    if (kDebugMode) {
      print("result: $result");
    }
    setState(() {
      connected = result;
    });
  }

  _showControlDialog() async {
    var result = await _castlibPlugin.showControlDialog();
    if (kDebugMode) {
      print("result: $result");
    }
  }

  _startCasting() async {
    var result = await _castlibPlugin.startCasting({
      "title": "title",
      "description": "here is the description",
      "posterPhoto":
          'https://thekee-m.gcdn.co/images06012022/uploads/media/series/posters/2022-09-27/0ObHcBVUnfpzbtIB.jpg',
      "mediaUrl":
          "https://thekee.gcdn.co/video/m-159n/English/Animation&Family/Baby.Shark.Best.Kids.Song/S01/01.mp4",
      "playPosition": "50",
    });
    if (kDebugMode) {
      print("result: $result");
    }
  }

  _stopCasting() async {
    var result = await _castlibPlugin.stopCasting();
    if (kDebugMode) {
      print("result: $result");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Column(
          children: [
            ElevatedButton(
              onPressed: _checkConnection,
              child: const Text('Check Connection'),
            ),
            Center(
              child: Text('connected to cast device: $connected'),
            ),
            ElevatedButton(
              onPressed: _showConnectionDialog,
              child: const Text('Show Dialog'),
            ),
            ElevatedButton(
              onPressed: _startCasting,
              child: const Text('Start Casting'),
            ),
            ElevatedButton(
              onPressed: _stopCasting,
              child: const Text('Stop Casting'),
            ),
            ElevatedButton(
              onPressed: _showControlDialog,
              child: const Text('Show Control Dialog'),
            ),
          ],
        ),
      ),
    );
  }
}
