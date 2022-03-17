import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:homerepair/main.dart';
import 'package:homerepair/delayed_animation.dart';
import 'package:homerepair/welcome_page.dart';
import 'package:homerepair/login_page.dart';
import 'package:homerepair/social_page.dart';

class SocialPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white.withOpacity(0),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: 30,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            DelayedAnimation(
              delay: 1000,
              child: Container(
                height: 300,
                child: Image.asset('images/repairbike.png'),
              ),
            ),
            DelayedAnimation(
              delay: 2000,
              child: Container(
                height: 200,
                child: Container(
                  margin: EdgeInsets.symmetric(
                    vertical: 50,
                    horizontal: 30,
                  ),
                  child: Column(
                    children: [
                      Text(
                        "On s'occupe de tout",
                        style: TextStyle(
                          color: d_red,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Un réparateur ou une réparatrice vous retrouve à l'adresse indiquée !",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            DelayedAnimation(
              delay: 2500,
              child: Container(
                margin: EdgeInsets.symmetric(
                  vertical: 14,
                  horizontal: 40,
                ),
                child: Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginPage(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                          shape: StadiumBorder(),
                          primary: d_red,
                          padding: EdgeInsets.all(20)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.mail_outline_outlined),
                          SizedBox(width: 10),
                          Text(
                            'CONNEXION PAR EMAIL',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginPage(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                          shape: StadiumBorder(),
                          primary: Colors.white,
                          padding: EdgeInsets.all(20)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('images/googlelogo.png', height: 20),
                          SizedBox(width: 10),
                          Text(
                            'CONNEXION AVEC GOOGLE',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
