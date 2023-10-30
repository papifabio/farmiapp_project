// ignore_for_file: prefer_const_constructors, unnecessary_brace_in_string_interps

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:FarmaEnvi/Controller/FirebaseController.dart';

class PedidosFarma extends StatefulWidget {
  const PedidosFarma({super.key});

  @override
  State<PedidosFarma> createState() => _PedidosFarmaState();
}

class _PedidosFarmaState extends State<PedidosFarma> {
  @override
  Widget build(BuildContext context) {
    return Material(
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
          final int userDocument =
              (userData as Map<String, dynamic>)['document'];

          return StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('pedidos')
                  .where('estado', isEqualTo: 'Asignado a un farmacéutico')
                  .where('documentF',
                      isEqualTo: FirebaseFirestore.instance
                          .doc('usuarios/${userDocument}'))
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

                return Stack(
                  children: [
                    Positioned.fill(
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: List.generate(
                          documents.length,
                          (index) {
                            final data = documents[index].data();
                            if (data is Map<String, dynamic>) {
                              return Container(
                                decoration: BoxDecoration(
                                  color: Color(0xcfd5e1).withOpacity(1),
                                ),
                                width: MediaQuery.of(context).size.width,
                                padding: EdgeInsets.only(top: 30),
                                child: Card(
                                  elevation: 10,
                                  margin: EdgeInsets.symmetric(horizontal: 20),
                                  child: SingleChildScrollView(
                                    child: Container(
                                      padding: EdgeInsets.only(top: 10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (_) =>
                                                      DetailScreen(data: data),
                                                ),
                                              );
                                            },
                                            child: Hero(
                                              tag: data['urlImage'],
                                              child: Container(
                                                alignment: Alignment.center,
                                                child: Image.network(
                                                  data['urlImage'],
                                                  fit: BoxFit.cover,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.25,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(25),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Center(
                                                  child: Text(
                                                      data['codigo'] ?? '',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                ),
                                                SizedBox(height: 10),
                                                Text(
                                                    'Fecha de creación de pedido: ${data['fecha']}'),
                                                SizedBox(height: 20),
                                                Center(
                                                  child: Text(
                                                      "--- Datos del solicitante ---",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        letterSpacing:
                                                            1.5, // Espaciado entre letras
                                                      )),
                                                ),
                                                SizedBox(height: 16),
                                                Text(
                                                    'Cliente: ${data['user'].toString().split('/').last.replaceAll(')', '')}'),
                                                Text(
                                                    'Documento: ${data['document'].toString().split('/').last.replaceAll(')', '')}'),
                                                Text(
                                                    'Número de contacto: ${data['phone'].toString().split('/').last.replaceAll(')', '')}'),
                                                SizedBox(height: 20),
                                                Center(
                                                  child: Text(
                                                      "--- Datos de envío ---",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        letterSpacing:
                                                            1.5, // Espaciado entre letras
                                                      )),
                                                ),
                                                SizedBox(height: 16),
                                                Text(
                                                    'Farmacia: ${data['farmacia'].toString().split('/').last.replaceAll(')', '')}'),
                                                Text(
                                                    'Sede farmacia: ${data['sede'].toString().split('/').last.replaceAll(')', '')}'),
                                                Text(
                                                    'Dirección de entrega: ${data['destino']}'),
                                                Text(
                                                  'Estado del pedido: ${data['estado']}',
                                                  style: GoogleFonts.lato(
                                                    textStyle: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Color(0xc02c20)
                                                          .withOpacity(1),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(height: 20),
                                                Center(
                                                  child: Text(
                                                      "--- Farmacéutico asociado ---",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        letterSpacing:
                                                            1.5, // Espaciado entre letras
                                                      )),
                                                ),
                                                SizedBox(height: 16),
                                                Text(
                                                    'Documento del farmacéutico: ${userData['document'].toString().split('/').last.replaceAll(')', '')}'),
                                                Text(
                                                    'Nombre del farmacéutico a cargo: ${userData['user'].toString().split('/').last.replaceAll(')', '')}'),
                                              ],
                                            ),
                                          ),
                                          Center(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                TextButton(
                                                    onPressed: () async {
                                                      final QuerySnapshot
                                                          snapshot =
                                                          await FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  'pedidos')
                                                              .where('codigo',
                                                                  isEqualTo: data[
                                                                      'codigo'])
                                                              .get();
                                                      if (snapshot.size > 0) {
                                                        final DocumentReference
                                                            pedidoRef = snapshot
                                                                .docs[0]
                                                                .reference;
                                                        print(
                                                            'Actualizando el pedido con ID: ${pedidoRef.id}');
                                                        pedidoRef.update({
                                                          'estado':
                                                              'Listo para despachar',
                                                        }).then((value) {
                                                          // Mostrar mensaje de éxito al usuario
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                            SnackBar(
                                                              content: Text(
                                                                  'El estado del pedido ha sido actualizado'),
                                                            ),
                                                          );
                                                        }).catchError((error) {
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                            SnackBar(
                                                                content: Text(
                                                                    'Error al actualizar el estado del pedido')),
                                                          );
                                                        });
                                                      } else {
                                                        // No se encontró ningún documento con el código proporcionado
                                                      }
                                                    },
                                                    child: Text("Despachar")),
                                                TextButton(
                                                    onPressed: () async {
                                                      final datos =
                                                          await obtenerDatos();
                                                      final QuerySnapshot
                                                          snapshot =
                                                          await FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  'pedidos')
                                                              .where('codigo',
                                                                  isEqualTo: data[
                                                                      'codigo'])
                                                              .get();
                                                      if (snapshot.size > 0) {
                                                        final DocumentReference
                                                            pedidoRef = snapshot
                                                                .docs[0]
                                                                .reference;
                                                        print(
                                                            'Actualizando el pedido con ID: ${pedidoRef.id}');
                                                        pedidoRef.update({
                                                          'estado':
                                                              'Pendiente por asignar',
                                                          'documentF': FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  'usuarios')
                                                              .doc('No asignado'
                                                                  .toString()),
                                                          'farmaceutico':
                                                              FirebaseFirestore
                                                                  .instance
                                                                  .collection(
                                                                      'usuarios')
                                                                  .doc(
                                                                      'No asignado'),
                                                        }).then((value) {
                                                          // Mostrar mensaje de éxito al usuario
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                            SnackBar(
                                                              content: Text(
                                                                  'El estado del pedido ha sido actualizado'),
                                                            ),
                                                          );
                                                        }).catchError((error) {
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                            SnackBar(
                                                                content: Text(
                                                                    'Error al actualizar el estado del pedido')),
                                                          );
                                                        });
                                                      } else {
                                                        // No se encontró ningún documento con el código proporcionado
                                                      }
                                                    },
                                                    child: Text(
                                                        "Reasignar pedido")),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            } else {
                              return Card(
                                elevation: 10,
                                margin: EdgeInsets.symmetric(horizontal: 25),
                                child: ListTile(
                                  title: Text('Error en los datos'),
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                );
              });
        },
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  final Map<String, dynamic> data;

  DetailScreen({required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(data['title'] ?? 'Recetario Médico'),
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Image.network(
                  data['urlImage'] ?? '',
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}