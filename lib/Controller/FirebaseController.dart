// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:FarmaEnvi/View/Admin/AdminHome.dart';
import 'package:FarmaEnvi/View/login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:FarmaEnvi/View/Cliente/HomePageCli.dart';
import 'package:FarmaEnvi/View/Delivery/HomePageDel.dart';
import 'package:FarmaEnvi/View/Farma/HomePageFarma.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class AuthUser extends StatelessWidget {
  const AuthUser({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Direccionar();
          } else {
            return Login();
          }
        },
      ),
    );
  }
}

class Direccionar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection('usuarios')
          .where('email', isEqualTo: FirebaseAuth.instance.currentUser?.email)
          .snapshots()
          .map((querySnapshot) => querySnapshot.docs.first),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          // Error al obtener los datos, redirigir al login
          return FutureBuilder<void>(
            future: Future.delayed(
                Duration(seconds: 3)), // Esperar 3 segundos antes de redirigir
            builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Login(); // Redirigir al login
              }
              return Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            },
          );
        }

        if (!snapshot.hasData) {
          return SpinKitFadingCircle(
            color: Colors.blue,
            size: 50.0,
          );
        }

        final userRole = snapshot.data!['rol'];
        if (userRole == 'Administrador') {
          // redirect to admin page
          return AdminHome();
        } else if (userRole == "Cliente") {
          // redirect to client page
          return HomePageCli();
        } else if (userRole == "Farmaceutico") {
          // redirect to client page
          return HomePageFarma();
        } else if (userRole == "Delivery") {
          // redirect to client page
          return HomePageDel();
        }

        return Container();
      },
    );
  }
}

void saveEstado(String estado) {
  FirebaseFirestore.instance.collection('pedidos').doc('estadoPedido').update({
    'array_estados': FieldValue.arrayUnion([estado])
  }).then((_) {
    print('Estado guardado exitosamente');
  }).catchError((error) {
    print('Error al guardar el estado: $error');
  });
}

Future<Map<String, dynamic>> obtenerDatos() async {
  final User? user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    final String email = user.email!;
    final DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('usuarios')
        .where('email', isEqualTo: email)
        .get()
        .then((querySnapshot) => querySnapshot.docs.first);
    final String name = snapshot['user'];
    final int documentCli = snapshot['document'];
    final int phoneCli = snapshot['phone'];
    final String clave = snapshot['password'];
    return {
      'user': name,
      'document': documentCli,
      'phone': phoneCli,
      'email': email,
      'password': clave
    };
  }
  return {};
}
