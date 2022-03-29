import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:homerepair/main.dart';
import '../screens/service_info_screen.dart';

class DisplayServices extends StatefulWidget {
  const DisplayServices({Key? key}) : super(key: key);

  @override
  State<DisplayServices> createState() => _DisplayServicesState();
}

class _DisplayServicesState extends State<DisplayServices> {
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
            .collection("services")
            .orderBy('name')
            .startAt([value]).endAt([value + '\uf8ff']).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) return const Text("There is no expense");
          return ListView(children: getFilteredServices(snapshot));
        });
  }

  getFilteredServices(AsyncSnapshot<QuerySnapshot> snapshot) {
    return snapshot.data!.docs
        .map((doc) => Service(
              name: doc["name"],
              price: doc['price'],
              desc: doc['description'],
              idRepair: doc['id_repair'],
              nameRepair: doc['name_repair'],
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
                    borderRadius: BorderRadius.all(Radius.circular(50)))),
          ),
        ),
        Expanded(
          child: filter(_filterValue),
        ),
      ],
    );
  }
}

class Service extends StatelessWidget {
  const Service(
      {Key? key,
      required this.name,
      required this.price,
      required this.desc,
      required this.idRepair,
      required this.nameRepair})
      : super(key: key);

  final String name;
  final String price;
  final String desc;
  final String idRepair;
  final String nameRepair;

  @override
  Widget build(BuildContext context) {
    Map<String, String> data = {
      'name': name,
      'price': price,
      'desc': desc,
      'id_repair': idRepair,
      'name_repair': nameRepair,
    };

    return Padding(
      padding: const EdgeInsets.all(10),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ServiceInfo(data: data),
            ),
          );
        },
        child: Card(
          elevation: 7,
          color: d_red,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15))),
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
