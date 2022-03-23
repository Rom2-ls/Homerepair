import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ServiceInfo extends StatelessWidget {
  const ServiceInfo(
      {Key? key,
      required this.name,
      required this.nameRepair,
      required this.idRepair,
      required this.price,
      required this.desc})
      : super(key: key);

  final String nameRepair;
  final String idRepair;
  final String name;
  final String price;
  final String desc;
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
                name: name,
                idRepair: idRepair,
                nameRepair: nameRepair,
                price: price,
                desc: desc,
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
  const AddDemande(
      {Key? key,
      required this.idRepair,
      required this.name,
      required this.status,
      required this.price,
      required this.desc,
      required this.nameRepair})
      : super(key: key);

  final String idRepair;
  final String nameRepair;
  final String name;
  final String price;
  final String desc;
  final String status;

  @override
  Widget build(BuildContext context) {
    CollectionReference demandes =
        FirebaseFirestore.instance.collection('demandes');

    Future<void> addDemande() {
      return demandes
          .add({
            'id_repair': idRepair,
            'name_repair': nameRepair,
            'name': name,
            'price': price,
            'desc': desc,
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
