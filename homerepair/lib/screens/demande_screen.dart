import 'package:flutter/material.dart';
import 'package:homerepair/widget/display_cards.dart';

class DemandeScreen extends StatefulWidget {
  const DemandeScreen({Key? key}) : super(key: key);

  @override
  State<DemandeScreen> createState() => _DemandeScreenState();
}

class _DemandeScreenState extends State<DemandeScreen> {
  final upperTab = const TabBar(tabs: <Tab>[
    Tab(child: Text("En attente")),
    Tab(child: Text("Acceptée")),
    Tab(child: Text("Refusée")),
  ]);

  final List<Map<String, dynamic>> _pendingDemandes = [
    {"name": "Andy", "status": "pending"},
    {"name": "Aragon", "status": "pending"},
    {"name": "Bob", "status": "pending"},
    {"name": "Barbara", "status": "pending"},
  ];

  final List<Map<String, dynamic>> _acceptedDemandes = [
    {"name": "Candy", "status": "accepted"},
    {"name": "Colin", "status": "accepted"},
  ];

  final List<Map<String, dynamic>> _rejectedDemandes = [
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
          title: const Text("Demandes"),
          centerTitle: true,
          bottom: upperTab,
        ),
        body: TabBarView(
          children: [
            DisplayCards(list: _pendingDemandes),
            DisplayCards(list: _acceptedDemandes),
            DisplayCards(list: _rejectedDemandes)
          ],
        ),
      ),
    );
  }
}
