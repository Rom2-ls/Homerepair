import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:homerepair/model/user_model.dart';

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

class AddDemande extends StatefulWidget {
  const AddDemande({Key? key, required this.data, required this.status})
      : super(key: key);

  final Map data;
  final String status;

  @override
  State<AddDemande> createState() => _AddDemandeState();
}

class _AddDemandeState extends State<AddDemande> {
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
    CollectionReference demandes =
        FirebaseFirestore.instance.collection('demandes');

    Future<void> addDemande() {
      return demandes
          .add({
            'id_client': user!.uid,
            'id_repair': widget.data['id_repair'],
            'name_repair': widget.data['name_repair'],
            'name': widget.data['name'],
            'price': widget.data['price'],
            'desc': widget.data['description'],
            'status': widget.status,
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
