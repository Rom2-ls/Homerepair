import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddDemande extends StatelessWidget {
  const AddDemande(this.name, this.status, {Key? key}) : super(key: key);

  final String name;
  final String status;

  @override
  Widget build(BuildContext context) {
    // Create a CollectionReference called users that references the firestore collection
    CollectionReference demandes =
        FirebaseFirestore.instance.collection('demandes');

    Future<void> addDemande() {
      // Call the user's CollectionReference to add a new user
      return demandes
          .add({
            'name': name, // John Doe
            'status': status, // Stokes and Sons
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

class ServiceInfo extends StatelessWidget {
  const ServiceInfo({Key? key, required this.name}) : super(key: key);
  final name;
  final status = "pending";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Service Info")),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [Text(name), AddDemande(name, status)],
          ),
        ),
      ),
    );
  }
}
