// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, use_key_in_widget_constructors, library_private_types_in_public_api, use_build_context_synchronously, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:FarmaEnvi/Controller/FirebaseController.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../utilities/constants.dart';

class Perfil extends StatefulWidget {
  @override
  _PerfilScreenState createState() => _PerfilScreenState();
}

class _PerfilScreenState extends State<Perfil> {
  final _nombreController = TextEditingController();
  final _telefonoController = TextEditingController();
  final _correoController = TextEditingController();
  final _passwordController = TextEditingController();
  bool passToggle = true;

  @override
  void dispose() {
    _nombreController.text.trim();
    _telefonoController.text.trim();
    _correoController.text.trim();
    _passwordController.text.trim();
    super.dispose();
  }

  Future actualizarUsuarios() async {
    actualizar(
        _nombreController.text.trim(),
        int.parse(_telefonoController.text.trim()),
        _correoController.text.trim(),
        _passwordController.text.trim());
  }

  Future<void> actualizar(String nombreUsuarioAc, int telefonoUsuarioAc,
      String correoUsuarioAc, String claveUsuarioAc) async {
    try {
      final User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final QuerySnapshot snapshot = await FirebaseFirestore.instance
            .collection('usuarios')
            .where('email', isEqualTo: user.email)
            .get();
        if (snapshot.size > 0) {
          final DocumentReference usuarioRef = snapshot.docs[0].reference;
          print('Actualizando los datos del usuario: ${usuarioRef.id}');

          // Actualizar los datos en Firestore
          await usuarioRef.update({
            'user': nombreUsuarioAc,
            'phone': telefonoUsuarioAc,
            'email': correoUsuarioAc,
            'password': claveUsuarioAc,
          });

          // Actualizar los datos de autenticación
          await user.updateEmail(correoUsuarioAc);
          await user.updatePassword(claveUsuarioAc);

          print('Los datos del usuario han sido actualizados');
        } else {
          print('No se encontró ningún documento con el email proporcionado');
        }
      }
    } catch (error) {
      print('Error al actualizar los datos del usuario: $error');
    }
  }

  Widget _buildUsuarioTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: FutureBuilder<Map<String, dynamic>>(
              future: obtenerDatos(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  //return CircularProgressIndicator();
                }
                if (snapshot.hasData) {
                  final name = snapshot.data!['user'] ?? '';
                  return TextField(
                    controller: _nombreController,
                    keyboardType: TextInputType.name,
                    style: GoogleFonts.lato(
                      textStyle: TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(top: 14.0),
                      prefixIcon: Icon(
                        Icons.person,
                        color: Colors.black,
                      ),
                      hintText: '$name',
                      hintStyle: kHintTextStyle,
                    ),
                  );
                }
                return const SizedBox();
              }),
        ),
      ],
    );
  }

  Widget _buildTelefonoTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: FutureBuilder<Map<String, dynamic>>(
              future: obtenerDatos(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  //return CircularProgressIndicator();
                }
                if (snapshot.hasData) {
                  final tel = snapshot.data!['phone'] ?? '';
                  return TextField(
                    controller: _telefonoController,
                    keyboardType: TextInputType.phone,
                    style: GoogleFonts.lato(
                      textStyle: TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(top: 14.0),
                      prefixIcon: Icon(
                        Icons.phone_android,
                        color: Colors.black,
                      ),
                      hintText: '$tel',
                      hintStyle: kHintTextStyle,
                    ),
                  );
                }
                return const SizedBox();
              }),
        ),
      ],
    );
  }

  Widget _buildCedulaTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 10.0),
        Container(
            alignment: Alignment.centerLeft,
            decoration: kBoxDecorationStyle,
            height: 60.0,
            child: FutureBuilder<Map<String, dynamic>>(
                future: obtenerDatos(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    //return CircularProgressIndicator();
                  }
                  if (snapshot.hasData) {
                    final doc = snapshot.data!['document'] ?? '';
                    return TextField(
                      keyboardType: TextInputType.number,
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                      enabled: false,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(top: 14.0),
                        prefixIcon: Icon(
                          Icons.assignment_ind_rounded,
                          color: Colors.black,
                        ),
                        hintText: '$doc',
                        hintStyle: kHintTextStyle,
                      ),
                    );
                  }
                  return const SizedBox();
                })),
      ],
    );
  }

  Widget _buildEmailTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 10.0),
        Container(
            alignment: Alignment.centerLeft,
            decoration: kBoxDecorationStyle,
            height: 60.0,
            child: FutureBuilder<Map<String, dynamic>>(
                future: obtenerDatos(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    //return CircularProgressIndicator();
                  }
                  if (snapshot.hasData) {
                    final email = snapshot.data!['email'] ?? '';
                    return TextField(
                      controller: _correoController,
                      keyboardType: TextInputType.emailAddress,
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(top: 14.0),
                        prefixIcon: Icon(
                          Icons.email,
                          color: Colors.black,
                        ),
                        hintText: '$email',
                        hintStyle: kHintTextStyle,
                      ),
                    );
                  }
                  return const SizedBox();
                })),
      ],
    );
  }

  Widget _buildPasswordTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 10.0),
        Container(
            alignment: Alignment.centerLeft,
            decoration: kBoxDecorationStyle,
            height: 60.0,
            child: FutureBuilder<Map<String, dynamic>>(
                future: obtenerDatos(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    //return CircularProgressIndicator();
                  }
                  if (snapshot.hasData) {
                    final clave = snapshot.data!['password'] ?? '';
                    return TextField(
                      obscureText: passToggle,
                      controller: _passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(top: 14.0),
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Colors.black,
                        ),
                        suffixIcon: InkWell(
                          onTap: () {
                            setState(() {
                              passToggle = !passToggle;
                            });
                          },
                          child: Icon(passToggle
                              ? Icons.visibility_off
                              : Icons.visibility),
                        ),
                        hintText: '************',
                        hintStyle: kHintTextStyle,
                      ),
                    );
                  }
                  return const SizedBox();
                })),
      ],
    );
  }

  void singUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 400;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.70;

    return Container(
      decoration: BoxDecoration(
        color: Color(0xcfd5e1).withOpacity(1),
      ),
      width: double.infinity,
      height: double.infinity,
      child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(
          horizontal: 30.0,
          vertical: 100.0,
        ),
        child: Column(
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: Text(
                'Datos del usuario',
                style: GoogleFonts.lato(
                  textStyle: TextStyle(
                    wordSpacing: 2,
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: Color(0x19274e).withOpacity(1),
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(
                  106 * fem, 12 * fem, 22.5 * fem, 13 * fem),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 30),
                  Container(
                    margin:
                        EdgeInsets.fromLTRB(7 * fem, 0 * fem, 0 * fem, 0 * fem),
                    width: double.infinity,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(
                              0 * fem, 0 * fem, 15.5 * fem, 0 * fem),
                          width: 120 * fem,
                          height: 120 * fem,
                          child: Image.asset(
                            'assets/login/images/rectangle-61.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                        IconButton(
                          onPressed: singUserOut,
                          icon: Icon(Icons.logout_rounded),
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            backgroundColor: Color.fromRGBO(36, 58, 105, 1),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5 * fem,
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(
                        0 * fem, 0 * fem, 84.5 * fem, 0 * fem),
                    child: TextButton(
                      onPressed: () async {
                        actualizarUsuarios();
                      },
                      child: Text(
                        'Modificar datos',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.lato(
                          textStyle: TextStyle(
                            fontSize: 20 * ffem,
                            fontWeight: FontWeight.w300,
                            height: 1.2 * ffem / fem,
                            color: Color(0x536d88).withOpacity(1),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Form(
                child: Column(
              children: [
                _buildUsuarioTF(),
                SizedBox(height: 5.0),
                _buildCedulaTF(),
                SizedBox(height: 5.0),
                _buildTelefonoTF(),
                SizedBox(height: 5.0),
                _buildEmailTF(),
                SizedBox(height: 5.0),
                _buildPasswordTF(),
              ],
            )),
          ],
        ),
      ),
    );
  }
}
