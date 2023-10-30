// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, unused_element, use_build_context_synchronously, avoid_print

import 'dart:io';

import 'package:google_fonts/google_fonts.dart';
import 'package:FarmaEnvi/Controller/FirebaseController.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:FarmaEnvi/View/Cliente/menu.dart';
import 'dart:core';
import 'dart:math';
import '../../utilities/constants.dart';

class FormularioPedido extends StatefulWidget {
  const FormularioPedido({super.key});

  @override
  State<FormularioPedido> createState() => _FormularioPedidoState();
}

String generateCode() {
  final random = Random();
  const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
  String code = '';
  for (int i = 0; i < 6; i++) {
    code += chars[random.nextInt(chars.length)];
  }
  return code;
}

DateTime now = DateTime.now();
String formattedDate =
    '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';

class SedeFarmacia {
  final String localidad;
  final String direccion;

  SedeFarmacia({required this.localidad, required this.direccion});
}

List<SedeFarmacia> _sedesFarmaciaSeleccionada = [];

class _FormularioPedidoState extends State<FormularioPedido> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _nombreController = TextEditingController();
  final _direccionController = TextEditingController();
  final farmacia = TextEditingController();
  final storage = FirebaseStorage.instance;
  File? imagenRecetarioMedico;

  @override
  void dispose() {
    _direccionController.text.trim();
    super.dispose();
  }

  SedeFarmacia? selecionSede;
  String localidadSedeSeleccionada = '';
  String _farmaciaSeleccionada = '';
  List<String> _nombresFarmacias = [];

  @override
  void initState() {
    super.initState();
    _obtenerNombresFarmacias();
  }

  Future<void> _obtenerNombresFarmacias() async {
    final QuerySnapshot querySnapshot =
        await _firestore.collection('farmacia').get();
    setState(() {
      _nombresFarmacias =
          querySnapshot.docs.map((doc) => doc['nombre'].toString()).toList();
    });
  }

  void _obtenerSedesFarmaciaSeleccionada() async {
    print(_farmaciaSeleccionada.toString());
    print(selecionSede.toString());
    if (_farmaciaSeleccionada.isNotEmpty) {
      final QuerySnapshot querySnapshot = await _firestore
          .collection('farmacia')
          .where('nombre', isEqualTo: _farmaciaSeleccionada)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        final DocumentSnapshot documentSnapshot = querySnapshot.docs.first;
        setState(() {
          _sedesFarmaciaSeleccionada =
              (documentSnapshot['sedes'] as List<dynamic>)
                  .map((sede) => SedeFarmacia(
                        localidad: sede['localidad'] ?? '',
                        direccion: sede['direccion'] ?? '',
                      ))
                  .toList();
        });
      }
    }
  }

  // Crear un nuevo pedido
  void createPedido(
      String codigo,
      String fecha,
      String farmaciaN,
      String sedeN,
      String direccionCli,
      String imageUrl,
      String nameCliente,
      int idCliente,
      int phoneCliente,
      String estado) {
    FirebaseFirestore.instance.collection('pedidos').add({
      'codigo': codigo,
      'fecha': fecha,
      'farmacia':
          FirebaseFirestore.instance.collection('farmacia').doc(farmaciaN),
      'sede': FirebaseFirestore.instance.collection('farmacia').doc(sedeN),
      'destino': direccionCli,
      'urlImage': imageUrl,
      'user':
          FirebaseFirestore.instance.collection('usuarios').doc(nameCliente),
      'document': FirebaseFirestore.instance
          .collection('usuarios')
          .doc(idCliente.toString()),
      'phone': FirebaseFirestore.instance
          .collection('usuarios')
          .doc(phoneCliente.toString()),
      'estado': estado
    });
  }

  Widget _buildDirTF() {
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
            controller: _direccionController,
            style: GoogleFonts.lato(
              textStyle: TextStyle(
                color: Colors.black,
              ),
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.home_rounded,
                color: Colors.black,
              ),
              hintText: 'Dirección donde se llevarán los medicamentos',
              hintStyle: kHintTextStyle,
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
            items: _nombresFarmacias.map((String farmacia) {
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
                _farmaciaSeleccionada = newValue!;
                farmacia.text = _farmaciaSeleccionada;
                selecionSede = null;
                _obtenerSedesFarmaciaSeleccionada();
              });
            },
            hint: Text(
              'Seleccione una farmacia',
              style: TextStyle(
                fontFamily: 'OpenSans',
                color: Colors.black54,
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

  Widget _buildSedeTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          padding: EdgeInsets.only(left: 10.0, right: 10.0),
          child: DropdownButtonFormField<SedeFarmacia>(
            value: selecionSede,
            isExpanded: true,
            iconEnabledColor: Colors.black,
            items: _sedesFarmaciaSeleccionada.map((sede) {
              return DropdownMenuItem<SedeFarmacia>(
                value: sede,
                child: Text(
                  key: Key("addField"),
                  sede.localidad,
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
                selecionSede = newValue!;
                SedeFarmacia? sedeSeleccionada = selecionSede;
                localidadSedeSeleccionada =
                    sedeSeleccionada?.localidad ?? 'N/A';
              });
            },
            hint: Text(
              'Seleccione una Sede',
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

  //Selecciono la imagen que quiero subir
  Future<XFile?> selectImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    return image;
  }

  Future<String> uploadImage(File image) async {
    final String namefield = image.path.split("/").last;
    final Reference ref = storage.ref().child("images").child(namefield);
    final UploadTask uploadTask = ref.putFile(image);
    print(uploadTask);

    final TaskSnapshot snapshot = await uploadTask.whenComplete(() => true);
    print(snapshot);

    final String url = await snapshot.ref.getDownloadURL();
    print(url);

    if (snapshot.state == TaskState.success) {
      return url;
    } else {
      return "";
    }
  }

  Widget _buildVerImagen() {
    return Builder(builder: (context) {
      return Column(
        children: [
          if (imagenRecetarioMedico != null)
            Image.file(imagenRecetarioMedico!)
          else
            SizedBox(height: 5),
          Container(
            alignment: Alignment.center,
            height: 60.0,
            padding: EdgeInsets.only(left: 10.0, right: 10.0),
            child: Text(
              'Adjunte la imagen del Recetario Médico',
              textAlign: TextAlign.center,
              style: GoogleFonts.lato(
                textStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(10),
            height: 80,
            width: double.infinity,
            color: imagenRecetarioMedico != null ? null : Colors.transparent,
            child: IconButton(
              onPressed: () async {
                final XFile? imagen = await selectImage();
                setState(() {
                  imagenRecetarioMedico = File(imagen!.path);
                });
              },
              icon: Icon(
                Icons.cloud_upload_outlined,
                size: 60,
              ),
            ),
          ),
          //Botón para guardar los datos del pedido
          ElevatedButton(
            onPressed: () async {
              final String imageUrl = await uploadImage(imagenRecetarioMedico!);
              final datos = await obtenerDatos();
              String estadoP = "Pendiente por asignar";

              createPedido(
                  generateCode(),
                  formattedDate,
                  _farmaciaSeleccionada,
                  localidadSedeSeleccionada,
                  _direccionController.text.trim(),
                  imageUrl,
                  datos['user'],
                  datos['document'],
                  datos['phone'],
                  estadoP);
              if (imagenRecetarioMedico == null) {
                return;
              }
              if (imageUrl.isNotEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("Pedido registado correctamente")));
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => Menu()),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Error al crear el pedido")));
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xc02c20).withOpacity(1),
            ),
            child: Text(
              'Guardar',
              style: GoogleFonts.lato(
                textStyle: TextStyle(
                  color: Colors.white,
                  letterSpacing: 1.5,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      );
    });
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
                decoration: BoxDecoration(
                  color: Color(0xcfd5e1).withOpacity(1),
                ),
              ),
              Container(
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
                        'Ingrese los siguientes datos para crear el pedido',
                        style: GoogleFonts.lato(
                          textStyle: TextStyle(
                            color: Color(0xc02c20).withOpacity(1),
                            fontSize: 30.0,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                      SizedBox(height: 20.0),
                      Form(
                          child: Column(
                        children: [
                          _buildDirTF(),
                          SizedBox(height: 5.0),
                          _buildFarmaTF(),
                          SizedBox(height: 5.0),
                          _buildSedeTF(),
                          SizedBox(height: 5.0),
                          _buildVerImagen(),
                          SizedBox(height: 5.0),
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
