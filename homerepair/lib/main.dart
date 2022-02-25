import 'package:flutter/material.dart';
import 'package:homerepair/delayed_animation.dart';
import 'package:homerepair/welcome_page.dart';
import 'package:homerepair/login_page.dart';
import 'package:homerepair/social_page.dart';

const d_red = Color(0xFFFF595E);
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'homerepair',
      home: WelcomePage(),
    );
  }
}
