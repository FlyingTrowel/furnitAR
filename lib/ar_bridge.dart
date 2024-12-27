// File: ar_bridge.dart
import 'package:flutter/services.dart';

class ARBridge {
  static const platform = MethodChannel('com.example.furnitar/ar');

  static Future<void> openARScreen() async {
    try {
      await platform.invokeMethod('openARScreen');
    } on PlatformException catch (e) {
      print("Failed to open AR screen: ${e.message}");
    }
  }
}