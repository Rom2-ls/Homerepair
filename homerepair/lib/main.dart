import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:homerepair/welcome/welcome_page.dart';
import 'firebase_options.dart';

const d_red = Color(0xFFFF595E);
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: 'homerepair', home: WelcomePage());
  }
}
