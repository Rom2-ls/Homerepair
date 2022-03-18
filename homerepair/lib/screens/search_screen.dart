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
          child: GetService(define_status: "accepted"),
        ));
  }
}
