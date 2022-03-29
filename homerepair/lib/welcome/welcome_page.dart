import 'package:flutter/material.dart';
import 'package:homerepair/main.dart';
import 'package:homerepair/widget/delayed_animation.dart';
import 'package:homerepair/welcome/social_page.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEDECF2),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 30,
            vertical: 60,
          ),
          child: Column(
            children: [
              DelayedAnimation(
                delay: 1500,
                child: SizedBox(
                  height: 170,
                  child: Image.asset('images/homerepairlogo.png'),
                ),
              ),
              DelayedAnimation(
                delay: 2500,
                child: SizedBox(
                  height: 400,
                  child: Image.asset('images/imageaccueil.png'),
                ),
              ),
              DelayedAnimation(
                delay: 3500,
                child: Container(
                  margin: const EdgeInsets.only(
                    top: 30,
                    bottom: 20,
                  ),
                  child: const Text(
                    "On répare vos vélos et trotinettes, chez vous, partout",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              DelayedAnimation(
                delay: 4500,
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: dRed,
                        shape: const StadiumBorder(),
                        padding: const EdgeInsets.all(13)),
                    child: const Text("C'EST PARTI"),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SocialPage(),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
