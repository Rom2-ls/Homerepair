import 'package:flutter/material.dart';
import 'package:homerepair/screens/home_screen.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

const d_red = Color(0xFFFF595E);
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: 'homerepair', home: HomeScreen());
  }
}
