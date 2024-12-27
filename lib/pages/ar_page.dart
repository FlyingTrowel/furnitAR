import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

class ARPage extends StatefulWidget {

  @override
  State<ARPage> createState() => _ARPageState();
}

class _ARPageState extends State<ARPage> {
  static const platform = MethodChannel('com.example.furnitar/ar');

  Widget? _nativeArView;

  @override
  void initState() {
    super.initState();
    _initializeAR();
  }

  Future<void> _initializeAR() async {
    try {
      // Call native method to initialize AR
      final result = await platform.invokeMethod('initializeAR');
      // Handle the result if needed
    } on PlatformException catch (e) {
      print("Failed to initialize AR: ${e.message}");
    }
  }

  @override
  Widget build(BuildContext context) {
    final String modelPath = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,

      ),
      body: AndroidView(
        viewType: 'ar-view',
        onPlatformViewCreated: (int id){

        },
      ),
      );
  }
}
