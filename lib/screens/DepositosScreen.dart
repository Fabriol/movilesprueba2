import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Depositosscreen extends StatelessWidget {
  const Depositosscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Historial de Depósitos")),
      body: const ListaDepositos(),
    );
  }
}

Future<List<dynamic>> leerAPI() async {
  final response = await http.get(Uri.parse('https://jritsqmet.github.io/web-api/depositos.json'));
  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    // Si la API devuelve un mapa con una lista adentro o la lista directa
    return data is List ? data : data['depositos'] ?? [];
  } else {
    throw Exception('Error al cargar la API');
  }
}

class ListaDepositos extends StatelessWidget {
  const ListaDepositos({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: leerAPI(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return const Center(child: Text("ERROR AL CARGAR DATOS"));
        }
        if (snapshot.hasData) {
          final data = snapshot.data!;
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              final item = data[index];
              return ListTile(
                leading: Image.network(item['detalles']['imagen_comprobante'], width: 50, height: 50, errorBuilder: (c, e, s) => const Icon(Icons.image)),
                title: Text("Banco: ${item['banco']}"),
                subtitle: Text("Monto: \$${item['monto']}"),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text("Detalle del Depósito"),
                      content: Text("Se realizó un depósito en ${item['banco']} por la cantidad de \$${item['monto']}"),
                    ),
                  );
                },
              );
            },
          );
        } else {
          return const Center(child: Text("No hay datos"));
        }
      },
    );
  }
}