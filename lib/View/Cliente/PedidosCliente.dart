// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PedidosCliente extends StatefulWidget {
  const PedidosCliente({super.key});

  @override
  State<PedidosCliente> createState() => _PedidosClienteState();
}

class _PedidosClienteState extends State<PedidosCliente> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('usuarios')
            .where('email', isEqualTo: FirebaseAuth.instance.currentUser?.email)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
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
                  .where('estado', isEqualTo: 'Entregado')
                  .where('document',
                      isEqualTo: FirebaseFirestore.instance
                          .doc('usuarios/${userDocument}'))
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
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
                      child: PageView.builder(
                        controller: _pageController,
                        itemCount: documents.length,
                        itemBuilder: (context, index) {
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
                                                height:
                                                    300.0, // ajusta el tamaño de la imagen pequeña
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
                                                  textAlign: TextAlign.center,
                                                  style: GoogleFonts.lato(
                                                    textStyle: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 10),
                                              Text(
                                                  'Fecha de creación de pedido: ${data['fecha']}'),
                                              SizedBox(height: 20),
                                              Center(
                                                child: Text(
                                                  "--- Datos del solicitante ---",
                                                  textAlign: TextAlign.center,
                                                  style: GoogleFonts.lato(
                                                    textStyle: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      letterSpacing:
                                                          1.5, // Espaciado entre letras
                                                    ),
                                                  ),
                                                ),
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
                                                  textAlign: TextAlign.center,
                                                  style: GoogleFonts.lato(
                                                    textStyle: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      letterSpacing:
                                                          1.5, // Espaciado entre letras
                                                    ),
                                                  ),
                                                ),
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
                                                    fontWeight: FontWeight.bold,
                                                    color: Color(0xc02c20)
                                                        .withOpacity(1),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 20),
                                              Center(
                                                child: Text(
                                                    "--- Farmacéutico asociado ---",
                                                    textAlign: TextAlign.center,
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
                                                  'Documento del farmacéutico: ${data['documentF'].toString().split('/').last.replaceAll(')', '')}'),
                                              Text(
                                                  'Nombre del farmacéutico a cargo: ${data['farmaceutico'].toString().split('/').last.replaceAll(')', '')}'),
                                              SizedBox(height: 20),
                                              Center(
                                                child: Text(
                                                    "--- Repartidor asociado ---",
                                                    textAlign: TextAlign.center,
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
                                                  'Documento del repartidor: ${data['documentD'].toString().split('/').last.replaceAll(')', '')}'),
                                              Text(
                                                  'Nombre del repartidor: ${data['delivery'].toString().split('/').last.replaceAll(')', '')}'),
                                            ],
                                          ),
                                        ),
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
                        onPageChanged: (index) {
                          setState(() {
                            _currentIndex = index;
                          });
                        },
                      ),
                    ),
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 16,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          documents.length,
                          (index) => Container(
                            width: 8,
                            height: 8,
                            margin: EdgeInsets.symmetric(horizontal: 4),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _currentIndex == index
                                  ? Colors.blue
                                  : Color(0xcfd5e1).withOpacity(1),
                            ),
                          ),
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
        backgroundColor: Color(0x536d88).withOpacity(1),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Color(0xcfd5e1).withOpacity(1),
        ),
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
