import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:homerepair/main.dart';

class RepairServiceScreen extends StatefulWidget {
  const RepairServiceScreen({Key? key}) : super(key: key);

  @override
  State<RepairServiceScreen> createState() => _RepairServiceScreenState();
}

class _RepairServiceScreenState extends State<RepairServiceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFEDECF2),
        appBar: AppBar(
          backgroundColor: Colors.white.withOpacity(0),
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
              size: 30,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text(
            "Mes services",
            style: TextStyle(color: dBlue),
          ),
          centerTitle: true,
        ),
        body: const Center(
          child: DisplayRepairServices(),
        ));
  }
}

class DisplayRepairServices extends StatefulWidget {
  const DisplayRepairServices({Key? key}) : super(key: key);

  @override
  State<DisplayRepairServices> createState() => _DisplayRepairServicesState();
}

class _DisplayRepairServicesState extends State<DisplayRepairServices> {
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
          child: GenerateServiceList(),
        )
      ],
    );
  }
}

class GenerateServiceList extends StatefulWidget {
  const GenerateServiceList({Key? key}) : super(key: key);

  @override
  _GenerateServiceListState createState() => _GenerateServiceListState();
}

class _GenerateServiceListState extends State<GenerateServiceList> {
  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _servicesStream = FirebaseFirestore.instance
        .collection("services")
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
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data =
                document.data()! as Map<String, dynamic>;
            return Service(
              name: data['name'],
              price: data['price'],
              desc: data['description'],
            );
          }).toList(),
        );
      },
    );
  }
}

class Service extends StatelessWidget {
  const Service(
      {Key? key, required this.name, required this.price, required this.desc})
      : super(key: key);

  final String name;
  final String desc;
  final String price;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Card(
        elevation: 7,
        color: const Color(0xFF507EBA),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 15, 15, 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
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
            ],
          ),
        ),
      ),
    );
  }
}
