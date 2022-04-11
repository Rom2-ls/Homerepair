import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:homerepair/main.dart';
import 'package:homerepair/model/user_model.dart';

class DisplayDemandes extends StatefulWidget {
  const DisplayDemandes({Key? key, required this.status}) : super(key: key);

  final String status;

  @override
  State<DisplayDemandes> createState() => _DisplayDemandesState();
}

class _DisplayDemandesState extends State<DisplayDemandes> {
  TextEditingController searchController = TextEditingController();

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedUser = UserModel();

  late String _filterValue;
  @override
  void initState() {
    super.initState();
    _filterValue = "";
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }

  filter(value) {
    return StreamBuilder<QuerySnapshot>(
        stream: firestore
            .collection("demandes")
            .where("status", isEqualTo: widget.status)
            .where("id_client", isEqualTo: user!.uid)
            .orderBy('name')
            .startAt([value]).endAt([value + '\uf8ff']).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Text("Vous n'avez pas fait de demandes");
          }
          return ListView(children: getFilteredServices(snapshot));
        });
  }

  getFilteredServices(AsyncSnapshot<QuerySnapshot> snapshot) {
    return snapshot.data!.docs
        .map((doc) => Demande(
              demId: doc.id,
              name: doc["name"],
              price: doc['price'],
              nameRepair: doc['name_repair'],
              status: widget.status,
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 20, 15, 10),
          child: TextField(
            controller: searchController,
            onChanged: (value) {
              setState(() {
                _filterValue = value;
              });
            },
            decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: dRed),
                    borderRadius: BorderRadius.all(Radius.circular(30)))),
          ),
        ),
        Expanded(
          child: filter(_filterValue),
        )
      ],
    );
  }
}

class Demande extends StatelessWidget {
  Demande(
      {Key? key,
      required this.demId,
      required this.name,
      required this.nameRepair,
      required this.price,
      required this.status})
      : super(key: key);

  final String demId;
  final String name;
  final String nameRepair;
  final String price;
  final String status;

  CollectionReference demandes =
      FirebaseFirestore.instance.collection('demandes');

  Future<void> deleteDemande(demId) {
    return demandes
        .doc(demId)
        .delete()
        .then((value) => Fluttertoast.showToast(msg: "Demande supprimée"))
        .catchError((error) =>
            Fluttertoast.showToast(msg: "Une erreur est survenue : $error"));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Card(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15))),
        elevation: 7,
        color: const Color(0xFFFF595E),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 15, 15, 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text("Service proposé par $nameRepair",
                  style: const TextStyle(fontSize: 20, color: Colors.white)),
              const SizedBox(height: 20),
              Text("Service : $name",
                  style: const TextStyle(fontSize: 20, color: Colors.white)),
              const SizedBox(height: 20),
              Text(
                "Prix : $price",
                style: const TextStyle(fontSize: 20, color: Colors.white),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  deleteDemande(demId);
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  shape: StadiumBorder(),
                  elevation: 0,
                ),
                child: const Text(
                  'Supprimer la demande',
                  style: TextStyle(
                    color: Color.fromARGB(255, 109, 108, 108),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
