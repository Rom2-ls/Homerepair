import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RepairDemandesScreen extends StatefulWidget {
  const RepairDemandesScreen({Key? key}) : super(key: key);

  @override
  State<RepairDemandesScreen> createState() => _RepairDemandesScreenState();
}

class _RepairDemandesScreenState extends State<RepairDemandesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Demandes en attente"),
          centerTitle: true,
        ),
        body: const Center(
          child: DisplayRepairDemandes(),
        ));
  }
}

class DisplayRepairDemandes extends StatefulWidget {
  const DisplayRepairDemandes({Key? key}) : super(key: key);

  @override
  State<DisplayRepairDemandes> createState() => _DisplayRepairDemandesState();
}

class _DisplayRepairDemandesState extends State<DisplayRepairDemandes> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 20, 15, 10),
          child: TextField(
            controller: searchController,
            onChanged: (value) {},
            decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)))),
          ),
        ),
        const Expanded(
          child: GenerateDemandeList(),
        )
      ],
    );
  }
}

class GenerateDemandeList extends StatefulWidget {
  const GenerateDemandeList({Key? key}) : super(key: key);

  @override
  _GenerateDemandeListState createState() => _GenerateDemandeListState();
}

class _GenerateDemandeListState extends State<GenerateDemandeList> {
  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _servicesStream = FirebaseFirestore.instance
        .collection("demandes")
        .where('id_repair', isEqualTo: user!.uid)
        .snapshots();

    return StreamBuilder<QuerySnapshot>(
      stream: _servicesStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading");
        }
        return ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot doc) {
            Map<String, dynamic> data = doc.data()! as Map<String, dynamic>;
            return MyDemandes(
                demId: doc.id,
                name: data['name'],
                price: data['price'],
                status: data['status']);
          }).toList(),
        );
      },
    );
  }
}

class MyDemandes extends StatelessWidget {
  MyDemandes(
      {Key? key,
      required this.name,
      required this.price,
      required this.demId,
      required this.status})
      : super(key: key);

  final String demId;
  final String name;
  final String price;
  final String status;

  CollectionReference demandes =
      FirebaseFirestore.instance.collection('demandes');

  Future<void> updateDemande(demId, status) {
    return demandes
        .doc(demId)
        .update({'status': status})
        .then((value) => Fluttertoast.showToast(msg: "Demande acceptée"))
        .catchError((error) =>
            Fluttertoast.showToast(msg: "Une erreur est survenue: $error"));
  }

  @override
  Widget build(BuildContext context) {
    Color? cardColor;

    switch (status) {
      case 'pending':
        cardColor = const Color(0xFFFF595E);
        break;
      case 'accepted':
        cardColor = const Color.fromARGB(255, 0, 106, 255);
        break;
      case 'rejected':
        cardColor = const Color.fromARGB(255, 255, 0, 0);
        break;
      default:
    }

    return Padding(
      padding: const EdgeInsets.all(10),
      child: Card(
        elevation: 7,
        color: cardColor,
        child: Column(
          children: [
            const SizedBox(
              width: double.infinity,
              height: 20,
              child: DecoratedBox(decoration: BoxDecoration(color: Colors.red)),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 15, 15, 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Service : $name",
                      style:
                          const TextStyle(fontSize: 20, color: Colors.white)),
                  const SizedBox(height: 20),
                  Text(
                    "Prix : $price",
                    style: const TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      OutlinedButton(
                          onPressed: () {
                            updateDemande(demId, 'accepted');
                          },
                          child: const Text('Accepter')),
                      OutlinedButton(
                        onPressed: () {
                          updateDemande(demId, 'rejected');
                        },
                        child: const Text("Refuser"),
                      ),
                      OutlinedButton(
                        onPressed: () {
                          updateDemande(demId, 'pending');
                        },
                        child: const Text("en attente"),
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
