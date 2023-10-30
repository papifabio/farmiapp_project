// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, no_logic_in_create_state

import 'package:FarmaEnvi/View/registrar_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminiUsers extends StatefulWidget {
  const AdminiUsers({Key? key}) : super(key: key);

  @override
  _AdminiUsersState createState() => _AdminiUsersState();
}

class _AdminiUsersState extends State<AdminiUsers> {
  String selectedRol = 'Cliente';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 100,
          decoration: BoxDecoration(
            color: Color(0xcfd5e1).withOpacity(1),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(50),
              bottomRight: Radius.circular(50),
            ),
          ),
          child: Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(top: 60.0),
              child: Column(
                children: [
                  Text(
                    "Administración de usuarios",
                    style: GoogleFonts.lato(
                      textStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Color(0x6c788e).withOpacity(1),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: 20),
        DropdownButton<String>(
          value: selectedRol,
          onChanged: (newValue) {
            setState(() {
              selectedRol = newValue!;
            });
          },
          items: ['Cliente', 'Farmaceutico', 'Administrador', 'Delivery']
              .map((rol) {
            return DropdownMenuItem<String>(
              value: rol,
              child: Text(rol),
            );
          }).toList(),
          style: GoogleFonts.lato(
            textStyle: TextStyle(
              fontSize: 15,
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
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => RegistrarPage()),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xc02c20).withOpacity(1),
          ),
          child: Text('Registrar nuevo usuario'),
        ),
        SizedBox(height: 5),
        Expanded(
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('usuarios')
                .where('rol', isEqualTo: selectedRol)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return CircularProgressIndicator();
              }

              final List<DocumentSnapshot> documents = snapshot.data!.docs;

              return ListView.builder(
                itemCount: documents.length,
                itemBuilder: (context, index) {
                  final data = documents[index].data();
                  if (data is Map<String, dynamic>) {
                    return ListTile(
                      title: Text(
                        data['user'] ?? '',
                        style: GoogleFonts.lato(
                          textStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xc02c20).withOpacity(1),
                          ),
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Documento de Identidad: ${data['document'].toString()}',
                            style: GoogleFonts.lato(
                              textStyle: TextStyle(
                                fontWeight: FontWeight.normal,
                                color: Color(0x19274e).withOpacity(1),
                              ),
                            ),
                          ),
                          Text(
                            'Correo: ${data['email']}',
                            style: GoogleFonts.lato(
                              textStyle: TextStyle(
                                fontWeight: FontWeight.normal,
                                color: Color(0x19274e).withOpacity(1),
                              ),
                            ),
                          ),
                          Text(
                            'Número de contacto: ${data['phone'].toString()}',
                            style: GoogleFonts.lato(
                              textStyle: TextStyle(
                                fontWeight: FontWeight.normal,
                                color: Color(0x19274e).withOpacity(1),
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
            },
          ),
        ),
      ],
    );
  }
}
