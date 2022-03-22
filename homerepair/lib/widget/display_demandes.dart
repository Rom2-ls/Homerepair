import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DisplayDemandes extends StatefulWidget {
  const DisplayDemandes({Key? key, required this.status}) : super(key: key);

  final String status;

  @override
  State<DisplayDemandes> createState() => _DisplayDemandesState();
}

class _DisplayDemandesState extends State<DisplayDemandes> {
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
        Expanded(
          child: GenerateDemandeList(status: widget.status),
        )
      ],
    );
  }
}

class GenerateDemandeList extends StatefulWidget {
  const GenerateDemandeList({Key? key, required this.status}) : super(key: key);

  final String status;

  @override
  _GenerateDemandeListState createState() => _GenerateDemandeListState();
}

class _GenerateDemandeListState extends State<GenerateDemandeList> {
  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _servicesStream = FirebaseFirestore.instance
        .collection("demandes")
        .where('status', isEqualTo: widget.status)
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
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data =
                document.data()! as Map<String, dynamic>;
            return Demande(
              name: data['name'],
              nameRepair: data['name_repair'],
              price: data['price'],
              desc: data['desc'],
              status: data['status'],
            );
          }).toList(),
        );
      },
    );
  }
}

class Demande extends StatelessWidget {
  const Demande(
      {Key? key,
      required this.name,
      required this.nameRepair,
      required this.price,
      required this.status,
      required this.desc})
      : super(key: key);

  final String nameRepair;
  final String name;
  final String price;
  final String status;
  final String desc;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Card(
        color: const Color(0xFF507EBA),
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
              Text(
                "Description : $desc",
                style: const TextStyle(fontSize: 20, color: Colors.white),
              ),
              const SizedBox(height: 20),
              const Text(
                "Je dois trouver un moyen d'ajouter une date de reservation",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
