import 'package:flutter/material.dart';
import 'package:furnitar/pages/get_started_page.dart';
import 'package:furnitar/pages/home_page.dart';
import 'package:furnitar/pages/ar_page.dart';

void main() {

  runApp( MyApp() );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        //set the scaffold background colour throughout the app
        scaffoldBackgroundColor: Colors.white
      ),
      title: 'furnitAR',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => GetStartedPage(),
        '/home': (context) => HomePage(),
        '/ar': (context) => ARPage(),
      },
    );
  }
}


