// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_full_hex_values_for_flutter_colors

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:FarmaEnvi/View/Admin/AdministrarFarmacias.dart';
import 'package:FarmaEnvi/View/Admin/AdministrarUsuarios.dart';
import 'package:FarmaEnvi/View/EstadoEnvio.dart';
import 'package:FarmaEnvi/View/Perfil.dart';
import 'package:flutter/material.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({super.key});

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xD4CDC5),
      body: IndexedStack(
        index: _currentIndex,
        children: [
          EstadoPedido(),
          // Página 1 (Inicio)
          AdminFarmacias(),
          // Página 2 (Config usuarios)
          AdminiUsers(),
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
            Icons.local_shipping_outlined,
            color: Colors.white,
          ),
          Icon(
            Icons.medical_services_rounded,
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
