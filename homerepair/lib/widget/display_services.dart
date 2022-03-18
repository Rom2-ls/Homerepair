import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GetService extends StatefulWidget {
  const GetService({Key? key, this.define_status}) : super(key: key);

  final define_status;
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
            onChanged: (value) {
              print(value);
            },
            decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)))),
          ),
        ),
        Expanded(
          child: DisplayServices(
            define_status: widget.define_status,
          ),
        )
      ],
    );
  }
}

class DisplayServices extends StatefulWidget {
  final define_status;

  const DisplayServices({Key? key, this.define_status}) : super(key: key);
  @override
  _DisplayServicesState createState() => _DisplayServicesState();
}

class _DisplayServicesState extends State<DisplayServices> {
  final Stream<QuerySnapshot> _servicesStream =
      FirebaseFirestore.instance.collection('Services').snapshots();

  @override
  Widget build(BuildContext context) {
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
            //return DisplayCards(list: [data]);
            return Service(
              name: data['name'],
              status: data['status'],
              define_status: widget.define_status,
            );
          }).toList(),
        );
      },
    );
  }
}

class Service extends StatelessWidget {
  const Service({Key? key, this.name, this.status, this.define_status})
      : super(key: key);
  final name;
  final status;
  final define_status;

  @override
  Widget build(BuildContext context) {
    if (status == define_status) {
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
                Text("Service : $name",
                    style: const TextStyle(fontSize: 20, color: Colors.white)),
                const SizedBox(height: 20),
                Text("Status : $status",
                    style: const TextStyle(fontSize: 20, color: Colors.white)),
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
      );
    } else {
      return Container();
    }
  }
}
