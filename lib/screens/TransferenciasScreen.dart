import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class Transferenciasscreen extends StatelessWidget {
  const Transferenciasscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Realizar Transferencia")),
      body: Center(
        child: SingleChildScrollView(
          child: Container(width: 300, child: formularioTransferencia(context)),
        ),
      ),
    );
  }
}

Widget formularioTransferencia(BuildContext context) {
  TextEditingController idTrans = TextEditingController();
  TextEditingController destinatario = TextEditingController();
  TextEditingController monto = TextEditingController();

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      TextField(
        controller: idTrans,
        decoration: const InputDecoration(hintText: "ID Transferencia", border: OutlineInputBorder()),
      ),
      const SizedBox(height: 15),
      TextField(
        controller: destinatario,
        decoration: const InputDecoration(hintText: "Destinatario", border: OutlineInputBorder()),
      ),
      const SizedBox(height: 15),
      TextField(
        controller: monto,
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(hintText: "Monto", border: OutlineInputBorder()),
      ),
      const SizedBox(height: 20),
      FilledButton.icon(
        onPressed: () => guardarTransferencia(context, idTrans, destinatario, monto),
        label: const Text("Guardar"),
        icon: const Icon(Icons.save),
      ),
    ],
  );
}

Future<void> guardarTransferencia(context, idTrans, destinatario, monto) async {
  try {
    await FirebaseDatabase.instance.ref('transferencias').child(idTrans.text).set({
      'id': idTrans.text,
      'destinatario': destinatario.text,
      'monto': double.parse(monto.text),
    });
    
    showDialog(
      context: context,
      builder: (context) => const AlertDialog(
        title: Text("Éxito"),
        content: Text("Transferencia guardada correctamente."),
      ),
    );
  } catch (e) {
    showDialog(
      context: context,
      builder: (context) => const AlertDialog(
        title: Text("Error"),
        content: Text("No se pudo guardar la transferencia."),
      ),
    );
  }
}