// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_full_hex_values_for_flutter_colors

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:FarmaEnvi/View/Cliente/PedidosCliente.dart';
import 'package:FarmaEnvi/View/Perfil.dart';
import 'package:FarmaEnvi/View/Cliente/menu.dart';
import 'package:flutter/material.dart';

class HomePageCli extends StatefulWidget {
  const HomePageCli({Key? key}) : super(key: key);

  @override
  State<HomePageCli> createState() => _HomePageStateCli();
}

class _HomePageStateCli extends State<HomePageCli> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xcfd5e1),
      body: IndexedStack(
        index: _currentIndex,
        children: [
          PedidosCliente(),
          Menu(),
          Perfil(),
        ],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Color(0xcfd5e1),
        color: Color(0x536d88).withOpacity(1),
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
            Icons.add_shopping_cart_rounded,
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
