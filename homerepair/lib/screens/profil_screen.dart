import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:homerepair/model/user_model.dart';
import 'package:homerepair/screens/home_screen.dart';
import 'package:homerepair/welcome/welcome_page.dart';

class ProfilScreen extends StatefulWidget {
  const ProfilScreen({Key? key}) : super(key: key);

  @override
  State<ProfilScreen> createState() => _ProfilScreenState();
}

class _ProfilScreenState extends State<ProfilScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedUser = UserModel();

  bool isSwitched = false;

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profil"),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Switch(
                value: isSwitched,
                onChanged: (value) {
                  setState(() {
                    isSwitched = !isSwitched;
                    print(isSwitched);
                  });
                },
              ),
              const Text("Nom utilisateur"),
              const Text("Nombre de demande en attente"),
              const Text("Nombre de demande accepté"),
              Text("${loggedUser.firstname}"),
              ElevatedButton(
                  onPressed: () async {
                    await FirebaseAuth.instance.signOut();
                    Navigator.pushAndRemoveUntil(
                        (context),
                        MaterialPageRoute(
                            builder: (context) => const WelcomePage()),
                        (route) => false);
                  },
                  child: const Text("logout"))
            ],
          ),
        ),
      ),
    );
  }
}
