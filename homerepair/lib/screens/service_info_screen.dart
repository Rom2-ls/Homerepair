import 'package:flutter/material.dart';
import '../widget/add_demande.dart';

class ServiceInfo extends StatelessWidget {
  const ServiceInfo({Key? key, required this.name}) : super(key: key);
  final String name;
  final status = "pending";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Service Info")),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [Text(name), AddDemande(name, status)],
          ),
        ),
      ),
    );
  }
}
