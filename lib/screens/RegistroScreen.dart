import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegistroScreen extends StatelessWidget {
  const RegistroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Registro ")),
      body: Center(
        child: Container(
          width: 300,
          child: formularioRegistro(context),
        ),
      ),
    );
  }
}

Widget formularioRegistro(BuildContext context) {
  TextEditingController correo = TextEditingController();
  TextEditingController contrasenia = TextEditingController();

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      TextField(
        controller: correo,
        decoration: const InputDecoration(hintText: "Correo", border: OutlineInputBorder()),
      ),
      const SizedBox(height: 15),
      TextField(
        controller: contrasenia,
        obscureText: true,
        decoration: const InputDecoration(hintText: "Contraseña", border: OutlineInputBorder()),
      ),
      const SizedBox(height: 20),
      FilledButton.icon(
        onPressed: () => registrar(context, correo, contrasenia),
        label: const Text("Registrarse"),
        icon: const Icon(Icons.save),
      ),
    ],
  );
}

Future<void> registrar(context, correo, contrasenia) async {
  try {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: correo.text,
      password: contrasenia.text,
    );
    Navigator.pushNamed(context, "/login");
  } catch (e) {
    showDialog(
      context: context,
      builder: (context) => const AlertDialog(
        title: Text("Error de Registro"),
        content: Text("No se pudo crear el usuario. Verifica los datos."),
      ),
    );
  }
}