import 'package:flutter/material.dart';

class ARPage extends StatefulWidget {

  @override
  State<ARPage> createState() => _ARPageState();
}

class _ARPageState extends State<ARPage> {

  @override
  Widget build(BuildContext context) {
    final String modelPath = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,

      ),
      body: Text(modelPath),
      );
  }
}
