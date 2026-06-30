import 'package:flutter/material.dart';
import 'TransferenciasScreen.dart';
import 'DepositosScreen.dart';

class NavegacionBottom extends StatefulWidget {
  const NavegacionBottom({super.key});

  @override
  State<NavegacionBottom> createState() => _NavegacionBottomState();
}

class _NavegacionBottomState extends State<NavegacionBottom> {
  int indice = 0;

  final List<Widget> pantallas = [
    const Transferenciasscreen(),
    const Depositosscreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pantallas[indice],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: indice,
        onTap: (valor) {
          setState(() {
            indice = valor;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.send), label: "Transferencias"),
          BottomNavigationBarItem(icon: Icon(Icons.account_balance_wallet), label: "Depósitos"),
        ],
      ),
    );
  }
}