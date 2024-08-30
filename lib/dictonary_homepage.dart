import 'package:flutter/material.dart';

class DictonaryHomepage extends StatefulWidget {
  const DictonaryHomepage({super.key});

  @override
  State<DictonaryHomepage> createState() => _DictonaryHomepageState();
}

class _DictonaryHomepageState extends State<DictonaryHomepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dictonary"),
        centerTitle: true,
      ),
    );
  }
}