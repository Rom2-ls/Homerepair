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

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  late String _filterValue;
  @override
  void initState() {
    _filterValue = "";
    super.initState();
  }

  filter(value) {
    return StreamBuilder<QuerySnapshot>(
        stream: firestore
            .collection("demandes")
            .orderBy('name')
            .startAt([value]).endAt([value + '\uf8ff']).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) return const Text("There is no expense");
          return ListView(children: getFilteredServices(snapshot));
        });
  }

  getFilteredServices(AsyncSnapshot<QuerySnapshot> snapshot) {
    return snapshot.data!.docs
        .map((doc) => Demande(
              name: doc["name"],
              price: doc['price'],
              desc: doc['desc'],
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
                    borderRadius: BorderRadius.all(Radius.circular(5.0)))),
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
