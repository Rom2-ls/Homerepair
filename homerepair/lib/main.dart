import 'package:flutter/material.dart';
import 'package:homerepair/screens/home_screen.dart';

const d_red = Color(0xFFFF595E);
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'homerepair',
      home: HomeScreen(),
    );
  }
}
