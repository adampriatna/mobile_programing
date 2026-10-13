import 'package:flutter/material.dart';

class Praktikum4Page extends StatefulWidget {
  const Praktikum4Page({super.key});

  @override
  State<Praktikum4Page> createState() => _Praktikum4PageState();
}

class _Praktikum4PageState extends State<Praktikum4Page> {
  final TextEditingController usernameController =
      TextEditingController();

  final TextEditingController passwordController =
      TextEditingController();

  String pesan = '';

  void login() {
    setState(() {
      if (usernameController.text.trim().isEmpty ||
          passwordController.text.isEmpty) {
        pesan = 'Username dan password harus diisi.';
      } else {
        pesan = 'Login berhasil diproses.';
      }
    });
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Sederhana'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const Icon(
                Icons.account_circle,
                size: 90,
                color: Colors.blue,
              ),
              const SizedBox(height: 16),
              const Text(
                'Selamat Datang',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),
              TextField(
                controller: usernameController,
                decoration: const InputDecoration(
                  labelText: 'Username',
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: login,
                  child: const Text('Login'),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                pesan,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}