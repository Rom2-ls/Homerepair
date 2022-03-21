import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../screens/service_info_screen.dart';

class GetService extends StatefulWidget {
  const GetService(
      {Key? key, required this.defineStatus, required this.defineCollection})
      : super(key: key);

  final String defineStatus;
  final String defineCollection;

  @override
  State<GetService> createState() => _GetServiceState();
}

class _GetServiceState extends State<GetService> {
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
          child: DisplayServices(
            defineStatus: widget.defineStatus,
            defineCollection: widget.defineCollection,
          ),
        )
      ],
    );
  }
}

class DisplayServices extends StatefulWidget {
  const DisplayServices(
      {Key? key, required this.defineStatus, required this.defineCollection})
      : super(key: key);

  final String defineStatus;
  final String defineCollection;

  @override
  _DisplayServicesState createState() => _DisplayServicesState();
}

class _DisplayServicesState extends State<DisplayServices> {
  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _servicesStream = FirebaseFirestore.instance
        .collection(widget.defineCollection)
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
              status: data['status'],
              defineStatus: widget.defineStatus,
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
      required this.status,
      required this.defineStatus})
      : super(key: key);

  final String name;
  final String status;
  final String defineStatus;

  @override
  Widget build(BuildContext context) {
    final String finalStatus;

    if (defineStatus == "") {
      finalStatus = "";
    } else {
      finalStatus = defineStatus;
    }

    if (status == finalStatus) {
      return Padding(
        padding: const EdgeInsets.all(10),
        child: GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ServiceInfo(
                          name: name,
                        )));
          },
          child: Card(
            color: const Color(0xFF507EBA),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15, 15, 15, 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Service : $name",
                      style:
                          const TextStyle(fontSize: 20, color: Colors.white)),
                  const SizedBox(height: 20),
                  Text("Status : $status",
                      style:
                          const TextStyle(fontSize: 20, color: Colors.white)),
                  const SizedBox(height: 20),
                  const Text(
                    "Description du client : desc",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      );
    } else {
      return Container();
    }
  }
}
