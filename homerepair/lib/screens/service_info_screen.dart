import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ServiceInfo extends StatelessWidget {
  const ServiceInfo({Key? key, required this.data}) : super(key: key);

  final Map data;
  final status = "pending";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Service Info")),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              AddDemande(
                data: data,
                status: status,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class AddDemande extends StatelessWidget {
  const AddDemande({Key? key, required this.data, required this.status})
      : super(key: key);

  final Map data;
  final String status;

  @override
  Widget build(BuildContext context) {
    CollectionReference demandes =
        FirebaseFirestore.instance.collection('demandes');

    Future<void> addDemande() {
      return demandes
          .add({
            'id_repair': data['id_repair'],
            'name_repair': data['name_repair'],
            'name': data['name'],
            'price': data['price'],
            'desc': data['description'],
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
