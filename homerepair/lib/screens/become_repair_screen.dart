import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:homerepair/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BecomeRepairScreen extends StatefulWidget {
  const BecomeRepairScreen({Key? key}) : super(key: key);

  @override
  _BecomeRepairScreenState createState() => _BecomeRepairScreenState();
}

class _BecomeRepairScreenState extends State<BecomeRepairScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  UserModel loggedUser = UserModel();
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    becomeRepair() async {
      if (isChecked == true) {
        await firestore
            .collection("users")
            .doc(user!.uid)
            .update({'repair': true});
        Navigator.pop(context);
      } else {
        Fluttertoast.showToast(
            msg: "Accepter les conditions générals d'utilisation");
      }
    }

    final checkbox = Checkbox(
      value: isChecked,
      onChanged: (bool? value) {
        setState(() {
          isChecked = value!;
        });
      },
    );

    final button = OutlinedButton(
      onPressed: () => {becomeRepair()},
      child: const Text("Je souhaite devenir un réparateur"),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("become repair"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const Text("le super texte des conditions d'utilisation"),
              Form(
                  child: Column(
                children: [
                  checkbox,
                  button,
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
