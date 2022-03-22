import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../screens/service_info_screen.dart';

class DisplayServices extends StatefulWidget {
  const DisplayServices({Key? key}) : super(key: key);

  @override
  State<DisplayServices> createState() => _DisplayServicesState();
}

class _DisplayServicesState extends State<DisplayServices> {
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
  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _servicesStream =
        FirebaseFirestore.instance.collection("services").snapshots();

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
              nameRepair: data['name_repair'],
              idRepair: data['id_repair'],
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
  final String desc;
  final String price;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ServiceInfo(
                nameRepair: nameRepair,
                idRepair: idRepair,
                name: name,
                price: price,
                desc: desc,
              ),
            ),
          );
        },
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
