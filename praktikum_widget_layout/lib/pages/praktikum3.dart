import 'package:flutter/material.dart';

class Praktikum3Page extends StatelessWidget {
  const Praktikum3Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Widget Bertingkat'),
        backgroundColor: Colors.orange,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/60.jpg',
              width: 250,
              height: 250,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 20),
            const Text('Ini adalah aplikasi Flutter'),
          ],
        ),
      ),
    );
  }
}