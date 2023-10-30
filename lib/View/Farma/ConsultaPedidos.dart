// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Controller/FirebaseController.dart';

class ConsultarPedidos extends StatefulWidget {
  const ConsultarPedidos({Key? key}) : super(key: key);

  @override
  _ConsultarPedidosState createState() => _ConsultarPedidosState();
}

class _ConsultarPedidosState extends State<ConsultarPedidos> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('pedidos')
            .where('estado', isEqualTo: 'Pendiente por asignar')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
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
                        padding: EdgeInsets.only(top: 30),
                        child: Card(
                          elevation: 10,
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          child: Container(
                            padding: EdgeInsets.only(top: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                            280.0, // ajusta el tamaño de la imagen pequeña
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
                                        child: Text(data['codigo'] ?? '',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold)),
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                          'Fecha de creación de pedido: ${data['fecha']}'),
                                      SizedBox(height: 18),
                                      Center(
                                        child: Text(
                                            "--- Datos del solicitante ---",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
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
                                      SizedBox(height: 18),
                                      Center(
                                        child: Text("--- Datos de envío ---",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              letterSpacing:
                                                  1.5, // Espaciado entre letras
                                            )),
                                      ),
                                      SizedBox(height: 14),
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
                                            color:
                                                Color(0xc02c20).withOpacity(1),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      TextButton(
                                          onPressed: () async {
                                            final datos = await obtenerDatos();
                                            final QuerySnapshot snapshot =
                                                await FirebaseFirestore.instance
                                                    .collection('pedidos')
                                                    .where('codigo',
                                                        isEqualTo:
                                                            data['codigo'])
                                                    .get();
                                            if (snapshot.size > 0) {
                                              final DocumentReference
                                                  pedidoRef =
                                                  snapshot.docs[0].reference;
                                              print(
                                                  'Actualizando el pedido con ID: ${pedidoRef.id}');
                                              pedidoRef.update({
                                                'estado':
                                                    'Asignado a un farmacéutico',
                                                'documentF': FirebaseFirestore
                                                    .instance
                                                    .collection('usuarios')
                                                    .doc(datos['document']
                                                        .toString()),
                                                'farmaceutico':
                                                    FirebaseFirestore.instance
                                                        .collection('usuarios')
                                                        .doc(datos['user']),
                                              }).then((value) {
                                                // Mostrar mensaje de éxito al usuario
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                    content: Text(
                                                        'El estado del pedido ha sido actualizado'),
                                                  ),
                                                );
                                              }).catchError((error) {
                                                ScaffoldMessenger.of(context)
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
                                          child: Text("Tomar pedido")),
                                    ],
                                  ),
                                )
                              ],
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
                        color:
                            _currentIndex == index ? Colors.blue : Colors.grey,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
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
