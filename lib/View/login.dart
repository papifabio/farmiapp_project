// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../utilities/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Login extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<Login> {
  bool passToggle = true;
  bool _rememberMe = false;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void singUserIn() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailController.text,
      password: passwordController.text,
    );
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
          child: TextField(
            controller: emailController,
            keyboardType: TextInputType.text,
            style: GoogleFonts.lato(
              textStyle: TextStyle(
                color: Color.fromARGB(255, 0, 0, 0),
              ),
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.person_add_alt_1_outlined,
                color: Color.fromARGB(255, 14, 12, 12),
              ),
              hintText: 'Correo',
              hintStyle: kHintTextStyle,
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
          child: TextField(
            controller: passwordController,
            obscureText: passToggle,
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
                child:
                    Icon(passToggle ? Icons.visibility_off : Icons.visibility),
              ),
              hintText: 'Contraseña',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLoginBtn(context) {
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
          singUserIn();
        },
        child: Text(
          'INGRESAR',
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
        alignment: Alignment.center,
        child: TextButton(
          onPressed: () => {Navigator.pushNamed(context, 'registro')},
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '¿No tiene cuenta? ',
                  style: GoogleFonts.lato(
                    textStyle: TextStyle(
                      color: Color(0x536d88).withOpacity(1),
                      fontSize: 18.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                TextSpan(
                  text: 'Registrese!',
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
                    horizontal: 30.0,
                    vertical: 100.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 30.0),
                        child: Container(
                          child: Image.asset(
                            'assets/images/login.png',
                            //height: 300,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      SizedBox(height: 30.0),
                      _buildUsuarioTF(),
                      SizedBox(height: 30.0),
                      _buildPasswordTF(),
                      _buildLoginBtn(context),
                      _buildSignupBtn(),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
