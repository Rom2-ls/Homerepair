import 'package:flutter/material.dart';
import '../widget/display_services.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Searchs"),
          centerTitle: true,
        ),
        body: const Center(
<<<<<<< HEAD
          child: GetService(define_collection: "Services"),
=======
          child: GetService(define_status: ""),
>>>>>>> e3293c3c03a74d1b7059225398732333b1b74b18
        ));
  }
}
