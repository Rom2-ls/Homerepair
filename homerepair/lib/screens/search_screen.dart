import 'package:flutter/material.dart';
import 'package:homerepair/screens/display_cards.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final List<Map<String, dynamic>> _allServices = [
    {"name": "Andy", "status": "pending"},
    {"name": "Aragon", "status": "pending"},
    {"name": "Bob", "status": "pending"},
    {"name": "Barbara", "status": "pending"},
    {"name": "Candy", "status": "accepted"},
    {"name": "Colin", "status": "accepted"},
    {"name": "Audra", "status": "rejected"},
    {"name": "Banana", "status": "rejected"},
    {"name": "Caversky", "status": "rejected"},
    {"name": "Becky", "status": "rejected"},
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Searchs"),
          centerTitle: true,
        ),
        body: TabBarView(
          children: [
            DisplayCards(title: "test 1", list: _allServices),
          ],
        ),
      ),
    );
  }
}
