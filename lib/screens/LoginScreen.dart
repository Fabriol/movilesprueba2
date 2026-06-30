import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Center(
        child: Container(
          width: 300,
          child: formularioLogin(context),
        ),
      ),
    );
  }
}

Widget formularioLogin(BuildContext context) {
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
        onPressed: () => login(context, correo, contrasenia),
        label: const Text("Ingresar"),
        icon: const Icon(Icons.login),
      ),
    ],
  );
}

Future<void> login(context, correo, contrasenia) async {
  try {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: correo.text,
      password: contrasenia.text,
    );
    Navigator.pushReplacementNamed(context, "/home");
  } catch (e) {
    showDialog(
      context: context,
      builder: (context) => const AlertDialog(
        title: Text("Error de Autenticación"),
        content: Text("Correo o contraseña incorrectos."),
      ),
    );
  }
}