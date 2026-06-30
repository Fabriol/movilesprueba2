import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Bienvenido")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("APP BANCARIA", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 40),
            FilledButton.icon(
              onPressed: () => Navigator.pushNamed(context, "/login"),
              icon: const Icon(Icons.login),
              label: const Text("Ir a Login"),
            ),
            const SizedBox(height: 20),
            OutlinedButton.icon(
              onPressed: () => Navigator.pushNamed(context, "/registro"),
              icon: const Icon(Icons.person_add),
              label: const Text("Ir a Registro"),
            ),
            const SizedBox(height: 60),
            const Text("Desarrollador: Fabricio Velasque"),
            const Text("GitHub: Fabriol"),
          ],
        ),
      ),
    );
  }
}