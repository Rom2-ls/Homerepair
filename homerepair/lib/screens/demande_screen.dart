import 'package:flutter/material.dart';
import 'package:homerepair/widget/display_services.dart';

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
        body: const TabBarView(
          children: [
            GetService(defineStatus: "pending", defineCollection: "demandes"),
            GetService(defineStatus: "accepted", defineCollection: "demandes"),
            GetService(defineStatus: "rejected", defineCollection: "demandes")
          ],
        ),
      ),
    );
  }
}
