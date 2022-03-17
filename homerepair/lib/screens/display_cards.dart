import 'dart:collection';

import 'package:flutter/material.dart';

class DisplayCards extends StatefulWidget {
  DisplayCards({Key? key, required this.list}) : super(key: key);
  List<Map<String, dynamic>> list = [];

  @override
  _DisplayCardsState createState() => _DisplayCardsState();
}

class _DisplayCardsState extends State<DisplayCards> {
  TextEditingController editingController = TextEditingController();

  List<Map<String, dynamic>> _foundUsers = [];

  @override
  initState() {
    // at the beginning, all users are shown
    _foundUsers = widget.list;
    super.initState();
  }

  // This function is called whenever the text field changes
  void _runFilter(String enteredKeyword) {
    List<Map<String, dynamic>> results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = widget.list;
    } else {
      results = widget.list
          .where((user) =>
              user["name"].toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }

    // Refresh the UI
    setState(() {
      _foundUsers = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEDECF2),
      body: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 20, 15, 10),
              child: TextField(
                onChanged: (value) {
                  _runFilter(value);
                },
                controller: editingController,
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)))),
              ),
            ),
            Expanded(
              child: _foundUsers.isNotEmpty
                  ? ListView.builder(
                      itemCount: _foundUsers.length,
                      itemBuilder: (context, index) => Service(
                        name: _foundUsers[index]["name"],
                        age: _foundUsers[index]["age"].toString(),
                      ),
                    )
                  : const Text(
                      'No results found',
                      style: TextStyle(fontSize: 24),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class Service extends StatelessWidget {
  const Service({Key? key, this.name, this.age}) : super(key: key);
  final name;
  final age;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
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
                Text("Prix : $age",
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
      ),
    );
  }
}
