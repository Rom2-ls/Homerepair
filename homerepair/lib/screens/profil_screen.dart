import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  final firstnameController = TextEditingController();
  final lastnameController = TextEditingController();
  final numberController = TextEditingController();

  late FocusNode firstnameFocus;
  late FocusNode lastnameFocus;
  late FocusNode numberFocus;

  late bool enableFN;
  late bool enableLN;
  late bool enableNB;

  late Color colorButton;
  late TextStyle styleButton;

  late String email = "";

  @override
  void initState() {
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedUser = UserModel.fromMap(value.data());
      setState(() {});
    });
    firstnameFocus = FocusNode();
    lastnameFocus = FocusNode();
    numberFocus = FocusNode();

    enableFN = false;
    enableLN = false;
    enableNB = false;

    colorButton = Colors.white;
    styleButton = const TextStyle(color: Colors.grey);

    super.initState();
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

    if (loggedUser.email != null) {
      email = loggedUser.email!;
    }
    String repair = "Vous n'êtes pas réparateur";
    if (loggedUser.repair == true) {
      repair = "Vous êtes réparateur";
    }

    final firstnameField = Row(
      children: [
        SizedBox(
          width: 200,
          height: 40,
          child: TextFormField(
            decoration: InputDecoration(
              icon: const Icon(Icons.person),
              border: InputBorder.none,
              hintText: loggedUser.firstname,
              labelStyle: TextStyle(
                color: Colors.grey[400],
              ),
            ),
            enabled: enableFN,
            focusNode: firstnameFocus,
            controller: firstnameController,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.done,
            onSaved: (value) {
              firstnameController.text = value!;
            },
            onFieldSubmitted: (value) {
              setState(() {
                enableFN = !enableFN;
              });
            },
          ),
        ),
        GestureDetector(
            child: const Icon(Icons.edit),
            onTap: () {
              setState(() {
                enableFN = !enableFN;
              });
            })
      ],
    );

    final lastnameField = Row(
      children: [
        SizedBox(
          width: 200,
          height: 40,
          child: TextFormField(
            decoration: InputDecoration(
              icon: const Icon(Icons.person),
              border: InputBorder.none,
              hintText: loggedUser.lastname,
              labelStyle: TextStyle(
                color: Colors.grey[400],
              ),
            ),
            enabled: enableLN,
            focusNode: lastnameFocus,
            controller: lastnameController,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.done,
            onSaved: (value) {
              lastnameController.text = value!;
            },
            onFieldSubmitted: (value) {
              setState(() {
                enableLN = !enableLN;
              });
            },
          ),
        ),
        GestureDetector(
            child: const Icon(Icons.edit),
            onTap: () {
              lastnameFocus.requestFocus();
              setState(() {
                enableLN = !enableLN;
              });
            })
      ],
    );

    final numberField = Row(
      children: [
        SizedBox(
          width: 200,
          height: 40,
          child: TextFormField(
            decoration: InputDecoration(
              icon: const Icon(Icons.phone_rounded),
              border: InputBorder.none,
              hintText: "number",
              labelStyle: TextStyle(
                color: Colors.grey[400],
              ),
            ),
            enabled: enableNB,
            focusNode: numberFocus,
            controller: numberController,
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.done,
            onSaved: (value) {
              numberController.text = value!;
            },
            onFieldSubmitted: (value) {
              setState(() {
                enableNB = !enableNB;
              });
            },
          ),
        ),
        GestureDetector(
            child: const Icon(Icons.edit),
            onTap: () {
              numberFocus.requestFocus();
              setState(() {
                enableNB = !enableNB;
              });
            })
      ],
    );

    final emailField = Row(
      children: [const Icon(Icons.email), Text(email)],
    );

    final repairField = Row(
      children: [const Icon(Icons.work), Text(repair)],
    );

    final updateProfil = ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          primary: colorButton,
        ),
        onPressed: () {
          if (firstnameController.text.isNotEmpty ||
              lastnameController.text.isNotEmpty ||
              numberController.text.isNotEmpty) {
            setState(() {
              colorButton = Colors.blueAccent;
              styleButton = const TextStyle(color: Colors.white);
            });
          }
        },
        child: Text(
          "Modifier",
          style: styleButton,
        ));

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
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                firstnameField,
                lastnameField,
                numberField,
                emailField,
                repairField,
                updateProfil,
              ],
            ),
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
