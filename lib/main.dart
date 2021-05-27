import 'package:flutter/material.dart';
import 'package:loginboil/screens/login.dart';
import 'package:loginboil/screens/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login',
      routes: {'/': (context) => Login(), '/home': (context) => MyHomePage()},
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
    );
  }
}
