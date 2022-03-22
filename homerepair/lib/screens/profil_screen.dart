import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:homerepair/model/user_model.dart';
import 'package:homerepair/screens/repair_screen.dart';
import 'package:homerepair/welcome/welcome_page.dart';

class ProfilScreen extends StatefulWidget {
  const ProfilScreen({Key? key}) : super(key: key);

  @override
  State<ProfilScreen> createState() => _ProfilScreenState();
}

class _ProfilScreenState extends State<ProfilScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedUser = UserModel();

  bool isSwitched = true;

  void switched() {
    setState(() {
      isSwitched = !isSwitched;
    });
  }

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
    final logoutButton = OutlinedButton(
      style: ElevatedButton.styleFrom(primary: Colors.red),
      onPressed: () async {
        await FirebaseAuth.instance.signOut();
        Navigator.pushAndRemoveUntil(
            (context),
            MaterialPageRoute(builder: (context) => const WelcomePage()),
            (route) => false);
      },
      child: const Text("logout"),
    );

    final repairButton = OutlinedButton(
      onPressed: () async {
        Navigator.pushAndRemoveUntil(
            (context),
            MaterialPageRoute(builder: (context) => const RepairScreen()),
            (route) => false);
      },
      child: const Text("Espace Réparateur"),
    );

    showMenu() {
      showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        builder: (BuildContext context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              repairButton,
              logoutButton,
            ],
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profil"),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: IconButton(
                onPressed: () => showMenu(), icon: const Icon(Icons.settings)),
          )
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Switch(
                value: isSwitched,
                onChanged: (value) {
                  switched();
                },
              ),
              Text("${loggedUser.firstname}"),
            ],
          ),
        ),
      ),
    );
  }
}
