// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:FarmaEnvi/View/Delivery/PedidosDelive.dart';
import 'package:FarmaEnvi/View/Delivery/PedidosDespacho.dart';
import 'package:FarmaEnvi/View/Perfil.dart';
import 'package:flutter/material.dart';

class HomePageDel extends StatefulWidget {
  const HomePageDel({super.key});

  @override
  State<HomePageDel> createState() => _HomePageDelState();
}

class _HomePageDelState extends State<HomePageDel> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xD4CDC5),
      body: IndexedStack(
        index: _currentIndex,
        children: [
          // Página 1 (Inicio)
          PedidosDespacho(),
          // Página 2 (Pedidos)
          PedidosDelive(),
          //FormularioPedido(),
          // Página 3 (Mi Perfil)
          Perfil(),
        ],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Color(0xD4CDC5),
        color: Color.fromRGBO(91, 136, 165, 0).withOpacity(1),
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
