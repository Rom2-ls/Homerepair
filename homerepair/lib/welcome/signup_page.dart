import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:homerepair/main.dart';
import 'package:homerepair/model/user_model.dart';
import 'package:homerepair/screens/home_screen.dart';
import 'package:homerepair/widget/delayed_animation.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white.withOpacity(0),
        leading: IconButton(
          icon: const Icon(
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
            Container(
              margin: const EdgeInsets.symmetric(
                vertical: 40,
                horizontal: 30,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const DelayedAnimation(
                    delay: 1000,
                    child: Text(
                      'Bienvenue chez Homerepair !',
                      style: TextStyle(
                        color: d_red,
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 22),
                  const DelayedAnimation(
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
                  const SizedBox(height: 35),
                  const DelayedAnimation(delay: 1000, child: SignupForm()),
                  const SizedBox(height: 50),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 30),
                  ),
                  const SizedBox(height: 105),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SignupForm extends StatefulWidget {
  const SignupForm({Key? key}) : super(key: key);

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  // controller --> ceux qui vont récupérer les champs qu'on rempli
  final firstnameController = TextEditingController();
  final lastnameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  var _obscureText = true;

  @override
  Widget build(BuildContext context) {
    // on appel firebase authentification pour les connexions.
    final FirebaseAuth auth = FirebaseAuth.instance;
    final formKey = GlobalKey<FormState>();

    // fonction qui va stocker le user dans la database
    postDetailsToFirestore() async {
      //call firestore
      FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

      //call usermodel
      User? user = auth.currentUser;

      //on crée un user
      UserModel userModel = UserModel();
      userModel.email = user!.email;
      userModel.firstname = firstnameController.text;
      userModel.lastname = lastnameController.text;

      try {
        // on envoie notre nouveau user dans la collection users de firebase
        await firebaseFirestore
            .collection("users")
            .doc(user.uid)
            .set(userModel.toMap());
        Fluttertoast.showToast(msg: "Votre compte a été créé");

        // et on envoie l'user connecter sur la page home
        Navigator.pushAndRemoveUntil(
            (context),
            MaterialPageRoute(builder: (context) => const HomeScreen()),
            (route) => false);
      } on FirebaseAuthException catch (e) {
        Fluttertoast.showToast(msg: e.message!);
      }
    }

    // fonction qui va créer le user
    register(email, pwd) async {
      try {
        if (formKey.currentState!.validate()) {
          await auth
              .createUserWithEmailAndPassword(email: email, password: pwd)
              .then((value) => postDetailsToFirestore());
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          Fluttertoast.showToast(msg: 'The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          Fluttertoast.showToast(
              msg: 'The account already exists for that email.');
        }
      } catch (e) {
        Fluttertoast.showToast(msg: "Oups, something went wrong");
      }
    }

    // LES TRUCS A MODIFIER SI BESOIN

    final firstnameField = TextFormField(
      decoration: InputDecoration(
        labelText: 'Prénom*',
        labelStyle: TextStyle(
          color: Colors.grey[400],
        ),
      ),
      controller: firstnameController,
      keyboardType: TextInputType.text,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Entrer votre prénom");
        }
        return null;
      },
      onSaved: (value) {
        firstnameController.text = value!;
      },
      textInputAction: TextInputAction.next,
    );

    final lastnameField = TextFormField(
      decoration: InputDecoration(
        labelText: 'Nom*',
        labelStyle: TextStyle(
          color: Colors.grey[400],
        ),
      ),
      controller: lastnameController,
      keyboardType: TextInputType.text,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Entrer votre nom");
        }
        return null;
      },
      onSaved: (value) {
        lastnameController.text = value!;
      },
      textInputAction: TextInputAction.next,
    );

    final phoneField = TextFormField(
      decoration: InputDecoration(
        labelText: 'Téléphone*',
        labelStyle: TextStyle(
          color: Colors.grey[400],
        ),
      ),
      controller: phoneController,
      keyboardType: TextInputType.number,
      validator: (value) {
        // RegExp regex = RegExp('different dun nombre on tej');
        if (value!.isEmpty) {
          return ("Entrer votre numéro de téléphone");
        }
        /*if (!regex.hasMatch(value)) {
          return ("Entrer un numéro de téléphone valide");
        }*/
        return null;
      },
      onSaved: (value) {
        phoneController.text = value!;
      },
      textInputAction: TextInputAction.next,
    );

    final emailField = TextFormField(
      decoration: InputDecoration(
        labelText: 'E-mail*',
        labelStyle: TextStyle(
          color: Colors.grey[400],
        ),
      ),
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      onSaved: (value) {
        firstnameController.text = value!;
      },
      textInputAction: TextInputAction.next,
    );

    final passwordField = TextFormField(
      obscureText: _obscureText,
      decoration: InputDecoration(
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

    final inscriptionButton = DelayedAnimation(
      delay: 2500,
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
            primary: d_red,
            padding: const EdgeInsets.symmetric(
              horizontal: 125,
              vertical: 13,
            ),
          ),
          child: const Text(
            "S'INSCRIRE",
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          onPressed: () {
            register(emailController.text, passwordController.text);
          },
        ),
      ),
    );

    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 30,
      ),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            firstnameField,
            const SizedBox(height: 30),
            lastnameField,
            const SizedBox(height: 30),
            phoneField,
            const SizedBox(height: 30),
            emailField,
            const SizedBox(height: 30),
            passwordField,
            const SizedBox(height: 30),
            inscriptionButton,
          ],
        ),
      ),
    );
  }
}
