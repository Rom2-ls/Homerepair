import 'package:flutter/material.dart';

class ProfilScreen extends StatefulWidget {
  const ProfilScreen({Key? key}) : super(key: key);

  @override
  State<ProfilScreen> createState() => _ProfilScreenState();
}

class _ProfilScreenState extends State<ProfilScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profil"),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              MySwitch(),
              const Text("Nom utilisateur"),
              const Text("Nombre de demande en attente"),
              const Text("Nombre de demande accepté"),
            ],
          ),
        ),
      ),
    );
  }
}

class MySwitch extends StatefulWidget {
  bool isSwitched = false;

  MySwitch({Key? key}) : super(key: key);

  @override
  State<MySwitch> createState() => _MySwitchState();
}

class _MySwitchState extends State<MySwitch> {
  @override
  Widget build(BuildContext context) {
    return Switch(
      value: widget.isSwitched,
      onChanged: (value) {
        setState(() {
          widget.isSwitched = !widget.isSwitched;
          print(widget.isSwitched);
        });
      },
    );
  }
}
