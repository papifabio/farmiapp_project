// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:FarmaEnvi/Controller/FirebaseController.dart';
import 'package:FarmaEnvi/View/Cliente/FormularioPedido.dart';
import 'package:flutter/material.dart';

class Menu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  String selectedEstado = 'Pendiente por asignar';
  List<String> estados = [
    'Pendiente por asignar',
    'Asignado a un farmacéutico',
    'Contacto con el servicio de envío',
    'Listo para despachar',
    'Entregado',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(244, 244, 242, 1),
        actions: <Widget>[
          SafeArea(
            child: Container(
              color: const Color.fromRGBO(244, 244, 242, 1),
              child: FutureBuilder<Map<String, dynamic>>(
                future: obtenerDatos(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }
                  if (snapshot.hasData) {
                    final name = snapshot.data!['user'] ?? '';
                    return Center(
                      child: Text(
                        'Hola, $name',
                        style: TextStyle(color: Color.fromRGBO(38, 58, 105, 1)),
                        textAlign: TextAlign.left,
                      ),
                    );
                  }
                  return const SizedBox(
                    width: 60,
                  );
                },
              ),
            ),
          ),
          SizedBox(height: 50),
          CircleAvatar(backgroundImage: AssetImage('assets/images/avatar.png')),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: <Widget>[
          _cardTipo1(context),
          SizedBox(height: 20),
          Align(
            alignment: Alignment.topCenter,
            child: Text(
              'MIS PEDIDOS',
              style: GoogleFonts.lato(
                textStyle: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Color(0x19274e).withOpacity(1),
                ),
              ),
            ),
          ),
          content(),
          _cardTipo2(context, selectedEstado),
        ],
      ),
    );
  }

  Widget content() {
    return Column(
      children: [
        DropdownButton<String>(
          value: selectedEstado,
          onChanged: (newValue) {
            setState(() {
              selectedEstado = newValue!;
            });
          },
          style: GoogleFonts.lato(
            textStyle: TextStyle(
              fontWeight: FontWeight.normal,
              color: Color(0x19274e).withOpacity(1),
            ),
          ),
          dropdownColor: Colors.white,
          icon: Icon(Icons.arrow_drop_down_circle_rounded),
          underline: Container(
            height: 1,
            color: Color(0xc02c20).withOpacity(1),
          ),
          items: estados.map((estado) {
            return DropdownMenuItem<String>(
              value: estado,
              child: Text(
                estado,
                style: TextStyle(
                  color: estado == 'Pendiente por asignar'
                      ? Colors.red
                      : estado == 'Asignado a un farmacéutico'
                          ? Colors.blueGrey
                          : estado == 'Contacto con el servicio de envío'
                              ? Color(0x19274e).withOpacity(1)
                              : estado == 'Listo para despachar'
                                  ? Colors.deepPurpleAccent
                                  : estado == 'Entregado'
                                      ? Colors.green
                                      : Colors.black,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

Widget _cardTipo1(BuildContext context) {
  return Card(
    elevation: 5.0,
    color: const Color(0xcfd5e1).withOpacity(1),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
    child: Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: <Widget>[
          Image.asset(
            'assets/images/menu.png',
            height: 225,
            width: 225,
          ),
          const SizedBox(width: 17),
          ListTile(
            title: Text(
              '¿Qué vas a ordenar hoy?',
              style: GoogleFonts.lato(
                textStyle: TextStyle(
                  color: Color(0x536d88).withOpacity(1),
                  fontSize: 18.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            subtitle: Text(
              'Solicita los medicamentos que necesitas y recíbelos en tu casa.',
              style: GoogleFonts.lato(
                textStyle: TextStyle(
                  color: Color(0x536d88).withOpacity(1),
                  fontSize: 14.0,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: 5.0,
              backgroundColor: Color(0xc02c20).withOpacity(1),
              padding: EdgeInsets.all(15.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FormularioPedido()),
              );
            },
            child: Text(
              'Nuevo Pedido',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _cardTipo2(BuildContext context, String selectedEstado) {
  return Card(
    child: StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('usuarios')
          .where('email', isEqualTo: FirebaseAuth.instance.currentUser?.email)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }
        if (snapshot.hasError) {
          return Text('Error al obtener los datos');
        }
        if (!snapshot.hasData) {
          return Text('No hay datos disponibles');
        }

        final userData = snapshot.data!.docs.first.data();
        final String? userNombre = (userData as Map<String, dynamic>)['user'];

        return StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('pedidos')
                .where('estado', isEqualTo: selectedEstado)
                .where('user',
                    isEqualTo: FirebaseFirestore.instance
                        .doc('usuarios/${userNombre}'))
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              }
              if (snapshot.hasError) {
                return Text('Error al obtener los datos');
              }
              if (!snapshot.hasData) {
                return Text('No hay datos disponibles');
              }
              final List<DocumentSnapshot> documents = snapshot.data!.docs;
              return ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: documents.length,
                itemBuilder: (context, index) {
                  final datos = documents[index].data();
                  if (datos is Map<String, dynamic>) {
                    return ListTile(
                      title: Text(
                        datos['codigo'] ?? '',
                        style: GoogleFonts.lato(
                          textStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0x19274e).withOpacity(1),
                          ),
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 5),
                          Text(
                            'Fecha de creación de pedido: ${datos['fecha']}',
                            style: GoogleFonts.lato(
                              textStyle: TextStyle(
                                fontWeight: FontWeight.normal,
                                color: Color(0x19274e).withOpacity(1),
                              ),
                            ),
                          ),
                          Text(
                            'Cliente: ${datos['user'].toString().split('/').last.replaceAll(')', '')}',
                            style: GoogleFonts.lato(
                              textStyle: TextStyle(
                                fontWeight: FontWeight.normal,
                                color: Color(0x19274e).withOpacity(1),
                              ),
                            ),
                          ),
                          Text(
                            'Sede farmacia: ${datos['sede'].toString().split('/').last.replaceAll(')', '')}',
                            style: GoogleFonts.lato(
                              textStyle: TextStyle(
                                fontWeight: FontWeight.normal,
                                color: Color(0x19274e).withOpacity(1),
                              ),
                            ),
                          ),
                          Text(
                            'Estado del pedido: ${datos['estado'].toString().split('/').last.replaceAll(')', '')}',
                            style: GoogleFonts.lato(
                              textStyle: TextStyle(
                                fontWeight: FontWeight.normal,
                                color: Color(0xc02c20).withOpacity(1),
                              ),
                            ),
                          ),
                          Divider(
                            color: Colors.grey, // Color del divisor
                            thickness: 1.0, // Grosor del divisor
                            indent: 10.0, // Sangría izquierda del divisor
                            endIndent: 10.0, // Sangría derecha del divisor
                          ),
                        ],
                      ),
                    );
                  } else {
                    return ListTile(
                      title: Text('Error en los datos'),
                    );
                  }
                },
              );
            });
      },
    ),
  );
}
