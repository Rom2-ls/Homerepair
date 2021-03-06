import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:homerepair/main.dart';
import 'package:homerepair/screens/home_screen.dart';
import 'package:homerepair/welcome/signup_page.dart';
import 'package:homerepair/widget/delayed_animation.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white.withOpacity(0),
        leading: IconButton(
          icon: const Icon(
            Icons.close,
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
            Container(
              margin: const EdgeInsets.symmetric(
                vertical: 40,
                horizontal: 30,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  DelayedAnimation(
                    delay: 500,
                    child: Text(
                      'Connexion avec e-mail',
                      style: TextStyle(
                        color: dRed,
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(height: 22),
                  DelayedAnimation(
                    delay: 500,
                    child: Text(
                      'Il vous est recommandé de vous connecter avec un e-mail afin de mieux protéger vos informations',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(height: 35),
                  LoginForm(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final auth = FirebaseAuth.instance;
  final formKey = GlobalKey<FormState>();
  var _obscureText = true;

  @override
  Widget build(BuildContext context) {
    // fonction de connexion
    signIn(email, pwd) async {
      if (formKey.currentState!.validate()) {
        await auth
            .signInWithEmailAndPassword(email: email, password: pwd)
            .then((uid) => {
                  Fluttertoast.showToast(msg: "Login Successfull"),
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const HomeScreen()),
                    (Route<dynamic> route) => false,
                  )
                })
            .catchError((e) {
          Fluttertoast.showToast(msg: e!.message);
        });
      }
    }

    // LES TRUCS A MODIFIER SI BESOIN

    final emailField = TextFormField(
      decoration: InputDecoration(
        icon: const Icon(
          Icons.email,
          color: Colors.grey,
        ),
        labelText: 'E-mail*',
        labelStyle: TextStyle(
          color: Colors.grey[400],
        ),
      ),
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      onSaved: (value) {
        emailController.text = value!;
      },
      textInputAction: TextInputAction.next,
    );

    final passwordField = TextFormField(
      obscureText: _obscureText,
      decoration: InputDecoration(
        icon: const Icon(
          Icons.lock,
          color: Colors.grey,
        ),
        labelStyle: TextStyle(
          color: Colors.grey[400],
        ),
        labelText: 'Mot de passe*',
        suffixIcon: IconButton(
          icon: const Icon(
            Icons.visibility,
            color: Colors.black,
          ),
          onPressed: () {
            setState(
              () {
                _obscureText = !_obscureText;
              },
            );
          },
        ),
      ),
      controller: passwordController,
      validator: (value) {
        RegExp regex = RegExp(r'^.{6,}$');
        if (value!.isEmpty) {
          return ("Entrer un mot de passe");
        }
        if (!regex.hasMatch(value)) {
          return ("Minimum 6 caractères");
        }
        return null;
      },
    );

    final loginButton = ElevatedButton(
      style: ElevatedButton.styleFrom(
          shape: const StadiumBorder(),
          primary: dRed,
          padding: const EdgeInsets.symmetric(
            horizontal: 69,
            vertical: 13,
          )),
      child: const Text(
        "SE CONNECTER",
        style: TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
      onPressed: () {
        signIn(emailController.text, passwordController.text);
      },
    );

    return DelayedAnimation(
      delay: 500,
      child: Form(
        key: formKey,
        child: Column(
          children: [
            emailField,
            const SizedBox(height: 30),
            passwordField,
            const SizedBox(height: 70),
            loginButton,
            const SizedBox(height: 30),
            const Text(
              "Vous n'avez pas encore de compte ?",
              style: TextStyle(color: Colors.grey),
            ),
            InkWell(
              child: const Text(
                "S'inscrire",
                style: TextStyle(
                  color: Color.fromARGB(255, 61, 128, 188),
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SignupPage(),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
