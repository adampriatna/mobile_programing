import 'package:flutter/material.dart';

import 'pages/praktikum1.dart';
import 'pages/praktikum2.dart';
import 'pages/praktikum3.dart';
import 'pages/praktikum4.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Praktikum Widget Flutter',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
        ),
        useMaterial3: true,
      ),
      home: const MenuPraktikum(),
    );
  }
}

class MenuPraktikum extends StatelessWidget {
  const MenuPraktikum({super.key});

  void bukaHalaman(BuildContext context, Widget halaman) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => halaman,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu Praktikum Flutter'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.school,
                size: 70,
                color: Colors.blue,
              ),
              const SizedBox(height: 12),
              const Text(
                'Widget dan Layout di Flutter',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () => bukaHalaman(
                    context,
                    const Praktikum1Page(),
                  ),
                  icon: const Icon(Icons.widgets),
                  label: const Text(
                    'Praktikum 1 - Widget Sederhana',
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.all(16),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () => bukaHalaman(
                    context,
                    const Praktikum2Page(),
                  ),
                  icon: const Icon(Icons.dashboard),
                  label: const Text(
                    'Praktikum 2 - Mengatur Tata Letak',
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.all(16),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () => bukaHalaman(
                    context,
                    const Praktikum3Page(),
                  ),
                  icon: const Icon(Icons.account_tree),
                  label: const Text(
                    'Praktikum 3 - Widget Bertingkat',
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.all(16),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () => bukaHalaman(
                    context,
                    const Praktikum4Page(),
                  ),
                  icon: const Icon(Icons.login),
                  label: const Text(
                    'Praktikum 4 - Tampilan Login',
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.all(16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}