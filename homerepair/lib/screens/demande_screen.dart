import 'package:flutter/material.dart';
import 'package:homerepair/main.dart';
import 'package:homerepair/widget/display_demandes.dart';

class DemandeScreen extends StatefulWidget {
  const DemandeScreen({Key? key}) : super(key: key);

  @override
  State<DemandeScreen> createState() => _DemandeScreenState();
}

class _DemandeScreenState extends State<DemandeScreen> {
  final upperTab = const TabBar(
    tabs: <Tab>[
      Tab(child: Text("En attente")),
      Tab(child: Text("Acceptée")),
      Tab(child: Text("Refusée")),
    ],
    labelColor: dBlue,
    unselectedLabelColor: Colors.grey,
    indicatorColor: dBlue,
  );

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: const Color(0xFFEDECF2),
        appBar: AppBar(
          backgroundColor: Colors.white.withOpacity(0),
          elevation: 0,
          title: Image.asset(
            'images/homerepairlogo.png',
            height: 120,
          ),
          centerTitle: true,
          bottom: upperTab,
        ),
        body: const TabBarView(
          children: [
            DisplayDemandes(status: "pending"),
            DisplayDemandes(status: "accepted"),
            DisplayDemandes(status: "rejected")
          ],
        ),
      ),
    );
  }
}
