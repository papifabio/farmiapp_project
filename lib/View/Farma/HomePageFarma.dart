import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:FarmaEnvi/View/Farma/ConsultaPedidos.dart';
import 'package:FarmaEnvi/View/Farma/PedidosFarma.dart';
import 'package:FarmaEnvi/View/Perfil.dart';

class HomePageFarma extends StatefulWidget {
  const HomePageFarma({super.key});

  @override
  State<HomePageFarma> createState() => _HomePageFarmaState();
}

class _HomePageFarmaState extends State<HomePageFarma> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xD4CDC5),
      body: IndexedStack(
        index: _currentIndex,
        children: [
          // Página 1 (Inicio)
          ConsultarPedidos(),
          // Página 2 (Pedidos)
          PedidosFarma(),
          // Página 3 (Mi Perfil)
          Perfil(),
        ],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Color(0xD4CDC5),
        color: Color(0xc02c20).withOpacity(1),
        animationDuration: Duration(milliseconds: 300),
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          Icon(
            Icons.home,
            color: Colors.white,
          ),
          Icon(
            Icons.supervised_user_circle,
            color: Colors.white,
          ),
          Icon(
            Icons.account_circle_outlined,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
