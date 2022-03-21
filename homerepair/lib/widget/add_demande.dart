import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddDemande extends StatelessWidget {
  const AddDemande(this.name, this.status, {Key? key}) : super(key: key);

  final String name;
  final String status;

  @override
  Widget build(BuildContext context) {
    CollectionReference demandes =
        FirebaseFirestore.instance.collection('demandes');

    Future<void> addDemande() {
      // Call the user's CollectionReference to add a new user
      return demandes
          .add({
            'name': name,
            'status': status,
          })
          .then((value) => print("Reservation envoyé"))
          .catchError((error) => print("Failed to add demande: $error"));
    }

    return ElevatedButton(
      onPressed: addDemande,
      child: const Text(
        "Reserver",
      ),
    );
  }
}
