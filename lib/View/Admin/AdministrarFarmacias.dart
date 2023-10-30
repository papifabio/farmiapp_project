// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, no_logic_in_create_state

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utilities/constants.dart';

class AdminFarmacias extends StatefulWidget {
  const AdminFarmacias({super.key});

  @override
  State<AdminFarmacias> createState() => _AdminFarmaciasState();
}

class _AdminFarmaciasState extends State<AdminFarmacias> {
  final _nombreFarmaciaController = TextEditingController();
  final _localidadController = TextEditingController();
  final _farmaAsignado = TextEditingController();
  final _nombreController = TextEditingController();
  final farmacieutico = TextEditingController();

  List<String> _nombreFarmaceutico = [];
  String _farmaceuticoSeleccionado = '';

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final List<String> _localidadOption = <String>[
    'San Cristobal Sur',
    'Engativá Nor-Occidente',
  ];

  @override
  void dispose() {
    _nombreFarmaciaController.dispose();
    _localidadController.dispose();
    _farmaAsignado.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _obtenerFarmaceuticos();
  }

  Future<void> _obtenerFarmaceuticos() async {
    final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('usuarios')
        .where('rol', isEqualTo: 'Farmaceutico')
        .get();
    setState(() {
      _nombreFarmaceutico =
          querySnapshot.docs.map((doc) => doc['user'].toString()).toList();
    });
  }

  // Crear una colección de "farmacias"
  void crearColeccionDeFarmacias() async {
    try {
      // Consultar si la farmacia ya existe
      final QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('farmacia')
          .where('nombre', isEqualTo: _nombreFarmaciaController.text.trim())
          .get();

      if (snapshot.docs.isNotEmpty) {
        // La farmacia ya existe, buscar la sede correspondiente
        final DocumentSnapshot farmaciaSnapshot = snapshot.docs.first;
        final Map<String, dynamic>? data =
            farmaciaSnapshot.data() as Map<String, dynamic>?;

        if (data != null) {
          final List<dynamic>? sedes = data['sedes'] as List<dynamic>?;

          if (sedes != null) {
            bool sedeExistente = false;

            for (final sede in sedes) {
              if (sede['localidad'] == _localidadController.text.trim()) {
                sedeExistente = true;
                final List<dynamic>? farmaceuticos =
                    sede['farmaceutico'] as List<dynamic>?;

                if (farmaceuticos != null) {
                  // Verificar si el farmacéutico ya está agregado a la sede
                  if (!farmaceuticos.contains(_farmaceuticoSeleccionado)) {}
                }
              }
            }

            if (!sedeExistente) {
              // La sede no existe, crear una nueva sede con el farmacéutico
              final DocumentReference documentReference =
                  farmaciaSnapshot.reference.collection('sedes').doc();
              await documentReference.set({
                'localidad': _localidadController.text.trim(),
                'farmaceutico': [
                  FirebaseFirestore.instance
                      .collection('usuarios')
                      .doc(_farmaceuticoSeleccionado),
                ],
              });
            }
          }
        }
      } else {
        // La farmacia no existe, crear una nueva colección "farmacias" con una sede
        await FirebaseFirestore.instance.collection('farmacia').add({
          'nombre': _nombreFarmaciaController.text.trim(),
          'sedes': [
            {
              'localidad': _localidadController.text.trim(),
              'farmaceutico': [
                FirebaseFirestore.instance
                    .collection('usuarios')
                    .doc(_farmaceuticoSeleccionado),
              ],
            }
          ],
        });
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Widget _buildNombreTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            controller: _nombreFarmaciaController,
            style: GoogleFonts.lato(
              textStyle: TextStyle(
                color: Colors.black,
              ),
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.healing,
                color: Colors.black,
              ),
              hintText: 'Nombre farmacia',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLocalidadTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          padding: EdgeInsets.only(left: 10.0, right: 10.0),
          child: DropdownButtonFormField<String>(
            value: _localidadController.text.isEmpty
                ? null
                : _localidadController.text,
            isExpanded: true,
            iconEnabledColor: Colors.black,
            items: _localidadOption.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                  style: GoogleFonts.lato(
                    textStyle: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                _localidadController.text = newValue!;
              });
            },
            hint: Text(
              'Localidad',
              style: GoogleFonts.lato(
                textStyle: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.supervised_user_circle,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFarmaTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          padding: EdgeInsets.only(left: 10.0, right: 10.0),
          child: DropdownButtonFormField<String>(
            value:
                _nombreController.text.isEmpty ? null : _nombreController.text,
            isExpanded: true,
            iconEnabledColor: Colors.black,
            items: _nombreFarmaceutico.map((String farmacia) {
              return DropdownMenuItem<String>(
                value: farmacia,
                child: Text(
                  farmacia,
                  style: GoogleFonts.lato(
                    textStyle: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
              );
            }).toList(),
            onChanged: (newValue) {
              setState(() {
                _farmaceuticoSeleccionado = newValue!;
                farmacieutico.text = _farmaceuticoSeleccionado;
                _obtenerFarmaceuticos();
              });
            },
            hint: Text(
              'Farmacéutico que opera en la sede',
              style: GoogleFonts.lato(
                textStyle: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.supervised_user_circle,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRegistrarBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: TextButton(
        style: TextButton.styleFrom(
          elevation: 5.0,
          backgroundColor: Color(0xc02c20).withOpacity(1),
          padding: EdgeInsets.all(15.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
        onPressed: () {
          crearColeccionDeFarmacias();
        },
        child: Text(
          'REGISTRAR FARMACIA',
          style: GoogleFonts.lato(
            textStyle: TextStyle(
              color: Colors.white,
              letterSpacing: 1.5,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'OpenSans',
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: backgroundDecoration,
              ),
              Container(
                color: Color(0xcfd5e1).withOpacity(1),
                height: double.infinity,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: 40.0,
                    vertical: 60.0,
                  ),
                  child: Column(
                    children: <Widget>[
                      Text(
                        'CREAR FARMACIAS',
                        style: GoogleFonts.lato(
                          textStyle: TextStyle(
                            fontSize: 30,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(height: 20.0),
                      Form(
                          // key: userForm.formkey,
                          // autovalidateMode: AutovalidateMode.onUserInteraction,
                          child: Column(
                        children: [
                          _buildNombreTF(),
                          SizedBox(height: 5.0),
                          _buildLocalidadTF(),
                          SizedBox(height: 5.0),
                          _buildFarmaTF(),
                          SizedBox(height: 5.0),
                          _buildRegistrarBtn(),
                        ],
                      )),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
