import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
         backgroundColor: Colors.white,
         title: Text('Choose furniture'),
         centerTitle: true,
       ),
      body: Container(
        margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: Column(
          children: [],
        ),
      ),
    );
  }
}
