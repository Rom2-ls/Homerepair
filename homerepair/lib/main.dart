import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:homerepair/screens/home_screen.dart';
import 'package:homerepair/screens/search_screen.dart';
import 'package:homerepair/welcome/welcome_page.dart';
import 'package:homerepair/widget/display_demandes.dart';
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
    Widget? pageToDisplay;
    var user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      pageToDisplay = const HomeScreen();
    } else {
      pageToDisplay = const WelcomePage();
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'homerepair',
      home: HomeScreen(),
    );
  }
}
