import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:homerepair/model/user_model.dart';

class CreateServiceScreen extends StatefulWidget {
  const CreateServiceScreen({Key? key}) : super(key: key);

  @override
  _CreateServiceScreenState createState() => _CreateServiceScreenState();
}

class _CreateServiceScreenState extends State<CreateServiceScreen> {
  final TextEditingController serviceController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController descController = TextEditingController();

  UserModel loggedUser = UserModel();
  User? user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    _uploadNewService() async {
      FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

      await firebaseFirestore.collection("services").add({
        'id_repair': user!.uid,
        'name_repair': loggedUser.firstname,
        'name': serviceController.text,
        'price': priceController.text.toString(),
        'description': descController.text,
      });
      Fluttertoast.showToast(msg: "Service créé");
    }

    final _formKey = GlobalKey<FormState>();

    // service field
    final service = TextFormField(
      autofocus: false,
      controller: serviceController,
      keyboardType: TextInputType.text,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Entrer un nom de service");
        }
        return null;
      },
      onSaved: (value) {
        serviceController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.home_repair_service),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Service",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );

    // price field
    final price = TextFormField(
      autofocus: false,
      controller: priceController,
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Entrer un prix");
        }
        return null;
      },
      onSaved: (value) {
        priceController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.monetization_on),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Prix",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );

    // description field
    final description = TextFormField(
      autofocus: false,
      minLines: 4,
      maxLines: 5,
      controller: descController,
      keyboardType: TextInputType.text,
      onSaved: (value) {
        descController.text = value!;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.description),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Description",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );

    // upload button
    final uploadButton = ElevatedButton(
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          _uploadNewService();
        }
      },
      child: const Text("Créer le service"),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("Créer un service"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  service,
                  const SizedBox(height: 10),
                  price,
                  const SizedBox(height: 10),
                  description,
                  const SizedBox(height: 10),
                  const SizedBox(height: 10),
                  uploadButton,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
