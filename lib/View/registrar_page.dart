// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, library_private_types_in_public_api, use_key_in_widget_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:FarmaEnvi/View/login.dart';
import '../../utilities/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegistrarPage extends StatefulWidget {
  @override
  _RegistrarScreenState createState() => _RegistrarScreenState();
}

class _RegistrarScreenState extends State<RegistrarPage> {
  final _userController = TextEditingController();
  final _documentController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordConfirmedController = TextEditingController();
  final _rolController = TextEditingController();
  bool passToggle = true;
  bool passToggle2 = true;

  @override
  void dispose() {
    _userController.dispose();
    _documentController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _passwordConfirmedController.dispose();
    _rolController.dispose();
    super.dispose();
  }

  final List<String> _rolOption = <String>[
    'Administrador',
    'Cliente',
    'Farmaceutico',
    'Delivery',
  ];

  Future singUp() async {
    if (passwordConfirmed()) {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      crearUsuarios(
        _userController.text.trim(),
        int.parse(_documentController.text.trim()),
        int.parse(_phoneController.text.trim()),
        _emailController.text.trim(),
        _passwordController.text.trim(),
        _rolController.text.trim(),
      );
    }
  }

  Future crearUsuarios(String user, int document, int phone, String email,
      String password, String rol) async {
    await FirebaseFirestore.instance.collection("usuarios").add({
      'user': user,
      'document': document,
      'phone': phone,
      'email': email,
      'password': password,
      'rol': rol,
    });
  }

  bool passwordConfirmed() {
    if (_passwordController.text.trim() ==
        _passwordConfirmedController.text.trim()) {
      return true;
    } else {
      return false;
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
          child: TextFormField(
            key: Key('user'),
            keyboardType: TextInputType.name,
            controller: _userController,
            style: GoogleFonts.lato(
              textStyle: TextStyle(
                color: Colors.black,
              ),
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.person,
                color: Colors.black,
              ),
              hintText: 'Usuario',
              hintStyle: kHintTextStyle,
            ),
          ),
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
          child: TextFormField(
            key: Key('tel'),
            keyboardType: TextInputType.phone,
            controller: _phoneController,
            style: GoogleFonts.lato(
              textStyle: TextStyle(
                color: Colors.black,
              ),
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.phone_android,
                color: Colors.black,
              ),
              hintText: 'Numero Telefonico',
              hintStyle: kHintTextStyle,
            ),
          ),
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
          child: TextFormField(
            key: Key('cedula'),
            keyboardType: TextInputType.number,
            controller: _documentController,
            style: GoogleFonts.lato(
              textStyle: TextStyle(
                color: Colors.black,
              ),
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.assignment_ind_rounded,
                color: Colors.black,
              ),
              hintText: 'Documento de identidad',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
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
          child: TextFormField(
            key: Key('email'),
            keyboardType: TextInputType.emailAddress,
            controller: _emailController,
            style: GoogleFonts.lato(
              textStyle: TextStyle(
                color: Colors.black,
              ),
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.email,
                color: Colors.black,
              ),
              hintText: 'Correo Electronico',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRolTF() {
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
            key: Key('rol'),
            value: _rolController.text.isEmpty ? null : _rolController.text,
            isExpanded: true,
            iconEnabledColor: Colors.black,
            items: _rolOption.map((String value) {
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
                _rolController.text = newValue!;
              });
            },
            hint: Text(
              'Rol',
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

  Widget _buildPasswordTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextFormField(
            key: Key('Pass'),
            obscureText: passToggle,
            controller: _passwordController,
            style: GoogleFonts.lato(
              textStyle: TextStyle(
                color: Colors.black,
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
                child:
                    Icon(passToggle ? Icons.visibility_off : Icons.visibility),
              ),
              hintText: 'Ingrese su contraseña',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordConfirm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextFormField(
            key: Key('PassConf'),
            obscureText: passToggle2,
            controller: _passwordConfirmedController,
            style: GoogleFonts.lato(
              textStyle: TextStyle(
                color: Colors.black,
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
                    passToggle2 = !passToggle2;
                  });
                },
                child:
                    Icon(passToggle2 ? Icons.visibility_off : Icons.visibility),
              ),
              hintText: 'Confirme la contraseña',
              hintStyle: kHintTextStyle,
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
        key: Key('BtnRegistrar'),
        style: TextButton.styleFrom(
          elevation: 5.0,
          backgroundColor: Color(0xc02c20).withOpacity(1),
          padding: EdgeInsets.all(15.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
        onPressed: () {
          singUp();
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Usuario registado correctamente")));
          Navigator.pushNamed(context, 'login');
        },
        child: Text(
          'REGISTRAR',
          style: GoogleFonts.lato(
            textStyle: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSignupBtn() {
    return Container(
        alignment: Alignment.centerRight,
        child: TextButton(
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => Login()),
            );
          },
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                    text: '¿Ya tiene cuenta? ',
                    style: GoogleFonts.lato(
                      textStyle: TextStyle(
                        color: Color(0x536d88).withOpacity(1),
                        fontSize: 18.0,
                        fontWeight: FontWeight.w400,
                      ),
                    )),
                TextSpan(
                  text: 'Inicie Sesión',
                  style: TextStyle(
                    color: Color(0x19274e).withOpacity(1),
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ));
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
                        'CREAR CUENTA',
                        style: TextStyle(
                          color: Color(0x19274e).withOpacity(1),
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 20.0),
                      Form(
                          // key: userForm.formkey,
                          // autovalidateMode: AutovalidateMode.onUserInteraction,
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
                          _buildRolTF(),
                          SizedBox(height: 5.0),
                          _buildPasswordTF(),
                          SizedBox(height: 5.0),
                          _buildPasswordConfirm(),
                          SizedBox(height: 5.0),
                          _buildRegistrarBtn(),
                          SizedBox(height: 5.0),
                          _buildSignupBtn()
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

class LabeledCheckbox extends StatelessWidget {
  const LabeledCheckbox({
    super.key,
    required this.label,
    required this.padding,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final EdgeInsets padding;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onChanged(!value);
      },
      child: Padding(
        padding: padding,
        child: Row(
          children: <Widget>[
            Expanded(
                child: Text(
              label,
              style: kLabelStyle,
            )),
            Checkbox(
              value: value,
              onChanged: (bool? newValue) {
                onChanged(newValue!);
              },
            ),
          ],
        ),
      ),
    );
  }
}
