// ignore_for_file: prefer_const_constructors, use_full_hex_values_for_flutter_colors, library_private_types_in_public_api

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EstadoPedido extends StatefulWidget {
  const EstadoPedido({Key? key});

  @override
  _EstadoPedidoState createState() => _EstadoPedidoState();
}

class _EstadoPedidoState extends State<EstadoPedido>
    with TickerProviderStateMixin {
  List<String> estados = [
    'Pendiente por asignar',
    'Asignado a un farmacéutico',
    'Contacto con el servicio de envío',
    'Listo para despachar',
    'Entregado',
  ];
  String selectedEstado = 'Pendiente por asignar';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: <Widget>[
          content(),
          _cardTipo2(context),
        ],
      ),
    );
  }

  Widget content() {
    return Column(
      children: [
        Container(
          height: 280,
          decoration: BoxDecoration(
            color: Color(0xa6aec1).withOpacity(1),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(50),
              bottomRight: Radius.circular(50),
            ),
          ),
          child: Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: Column(children: [
                Image.asset(
                  'assets/images/Delivery.png',
                  height: 180,
                ),
                Text(
                  "ESTADO DE ENVÍO",
                  style: GoogleFonts.lato(
                    textStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: Colors.white,
                    ),
                  ),
                )
              ]),
            ),
          ),
        ),
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
            color: Color(0xa6aec1).withOpacity(1),
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
                                        : Colors.black),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _cardTipo2(BuildContext context) {
    return Card(
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('pedidos')
            .where('estado', isEqualTo: selectedEstado)
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
                        color: Color(0x6c788e).withOpacity(1),
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
                        'Localidad: ${datos['sede'].toString().split('/').last.replaceAll(')', '')}',
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
                            color: Color(0x19274e).withOpacity(1),
                          ),
                        ),
                      ),
                      Divider(
                        color: Colors.grey,
                        thickness: 1.0,
                        indent: 10.0,
                        endIndent: 10.0,
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
        },
      ),
    );
  }
}
