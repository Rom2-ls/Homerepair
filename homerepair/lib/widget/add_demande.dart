import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddDemande extends StatelessWidget {
  const AddDemande(this.name, this.status, {Key? key}) : super(key: key);

  final String name;
  final String status;

  @override
  Widget build(BuildContext context) {
    CollectionReference demandes =
        FirebaseFirestore.instance.collection('demandes');

    Future<void> addDemande() {
      return demandes
          .add({
            'name': name,
            'status': status,
          })
          .then((value) => Fluttertoast.showToast(msg: "Reservation envoyé"))
          .catchError((error) =>
              Fluttertoast.showToast(msg: "Failed to add demande: $error"));
    }

    return ElevatedButton(
      onPressed: addDemande,
      child: const Text(
        "Reserver",
      ),
    );
  }
}
