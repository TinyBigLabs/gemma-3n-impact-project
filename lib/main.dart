import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Whatever we want it to be',
      //Add theme: Jakub might want to mess around here lol
      home: SizedBox.shrink()
    );
  }
}
