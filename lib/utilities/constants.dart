
import 'package:flutter/material.dart';

final appName = 'Envio Medicamentos';


final kHintTextStyle = TextStyle(
  color: Colors.black87,
  fontFamily: 'OpenSans',
);

final kLabelStyle = TextStyle(
  color: Colors.black,
  fontWeight: FontWeight.bold,
  fontFamily: 'OpenSans',
);

final kBoxDecorationStyle = BoxDecoration(
  color: Color.fromRGBO(222, 222, 238, 1),
  borderRadius: BorderRadius.circular(10.0),
  boxShadow: [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 6.0,
      offset: Offset(0, 2),
    ),
  ],
);

final backgroundDecoration = BoxDecoration(
  gradient: LinearGradient(
    colors: [
      Color.fromRGBO(91, 136, 165, 1),
      Color.fromRGBO(91, 136, 165, 1),
      Color.fromARGB(255, 4, 99, 116),
      Color.fromRGBO(91, 136, 165, 1),
    ],
    stops: [0.0, 0.4, 0.7, 0.9],
    begin: Alignment(-1.0, -2.0),
    end: Alignment(1, 1.0),
  ),
);

final simpleTextStyle = TextStyle(
  color: Color.fromARGB(137, 0, 0, 0),
  fontFamily: 'OpenSans',
);

final simpleDecorationStyle = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.circular(10.0),
  boxShadow: [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 6.0,
      offset: Offset(0, 5),
    ),
  ],
);

final primaryColor = Color.fromRGBO(91, 136, 165, 1);