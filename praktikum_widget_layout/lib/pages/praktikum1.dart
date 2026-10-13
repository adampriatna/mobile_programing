import 'package:flutter/material.dart';

class Praktikum1Page extends StatelessWidget {
  const Praktikum1Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[800],
        leading: const Icon(Icons.home),
        title: const Text('Flutter Widget Sederhana'),
      ),
      body: Container(),
    );
  }
}