import 'package:flutter/material.dart';

class Test extends StatelessWidget {
  Test({super.key});


  @override
  Widget build(BuildContext context) {
    final String arguments = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
      ),
      body: Center(
        child: Text(arguments),
      ),
    );
  }
}
