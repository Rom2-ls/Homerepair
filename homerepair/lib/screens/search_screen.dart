import 'package:flutter/material.dart';
import 'package:homerepair/main.dart';
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
        backgroundColor: Color(0xFFEDECF2),
        appBar: AppBar(
          backgroundColor: Colors.white.withOpacity(0),
          elevation: 0,
          title: Image.asset(
            'images/homerepairlogo.png',
            height: 120,
          ),
          centerTitle: true,
        ),
        body: const Center(
          child: DisplayServices(),
        ));
  }
}
