import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:homerepair/model/user_model.dart';
import 'package:homerepair/screens/become_repair_screen.dart';
import 'package:homerepair/screens/create_service_screen.dart';
import 'package:homerepair/welcome/welcome_page.dart';
import 'package:homerepair/widget/display_repair_demandes.dart';
import 'package:homerepair/widget/display_repair_service.dart';

class ProfilScreen extends StatefulWidget {
  const ProfilScreen({Key? key}) : super(key: key);

  @override
  State<ProfilScreen> createState() => _ProfilScreenState();
}

class _ProfilScreenState extends State<ProfilScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedUser = UserModel();

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
    Widget settingList() {
      if (loggedUser.repair == true) {
        return const RepairOption();
      } else {
        return const ClientOption();
      }
    }

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

    showMenu() {
      showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        builder: (BuildContext context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              settingList(),
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
              Text("${loggedUser.firstname}"),
              Text("${loggedUser.repair}"),
            ],
          ),
        ),
      ),
    );
  }
}

class RepairOption extends StatelessWidget {
  const RepairOption({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        OutlinedButton(
            onPressed: () {
              Navigator.push(
                  (context),
                  MaterialPageRoute(
                      builder: (context) => const CreateServiceScreen()));
            },
            child: const Text("Créer un service")),
        OutlinedButton(
            onPressed: () {
              Navigator.push(
                  (context),
                  MaterialPageRoute(
                      builder: (context) => const RepairServiceScreen()));
            },
            child: const Text("Mes services en ligne")),
        OutlinedButton(
            onPressed: () {
              Navigator.push(
                  (context),
                  MaterialPageRoute(
                      builder: (context) => const RepairDemandesScreen()));
            },
            child: const Text("Mes demandes en attente")),
      ],
    );
  }
}

class ClientOption extends StatelessWidget {
  const ClientOption({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        onPressed: () {
          Navigator.push(
              (context),
              MaterialPageRoute(
                  builder: (context) => const BecomeRepairScreen()));
        },
        child: const Text("Devenir réparateur"));
  }
}
