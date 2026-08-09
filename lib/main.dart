import 'package:flutter/material.dart';
// import 'package:flutter_animations/examples/example1.dart';
// import 'package:flutter_animations/examples/example2.dart';
// import 'package:flutter_animations/examples/example3.dart';
import 'package:flutter_animations/examples/example4.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter animations',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      theme: ThemeData(brightness: .dark),
      darkTheme: ThemeData(brightness: .dark),
      home: Example4(),
    );
  }
}
