import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:FarmaEnvi/View/Farma/ConsultaPedidos.dart';
import 'package:FarmaEnvi/View/login.dart';
import 'package:FarmaEnvi/main.dart' as app;

/**
void main() {
  testWidgets('Prueba de Widget para el widget build', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: build(), // Sustituye 'YourWidget' con el nombre de tu widget
      ),
    ));

    // Verifica que el widget principal esté presente
    expect(find.byType(MaterialApp), findsOneWidget);

    // Verifica que el widget StreamBuilder esté presente
    expect(find.byType(StreamBuilder), findsOneWidget);

    // Realiza otras aserciones según sea necesario para tus widgets dentro de StreamBuilder

    // Ejemplo: Verifica que haya un CircularProgressIndicator
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    // Ejemplo: Toca un botón dentro de tu widget
    // await tester.tap(find.widgetWithText(TextButton, 'Tomar pedido'));
    // await tester.pump();

    // Agrega más aserciones y pruebas según tus necesidades.
  });
}
void main() {
  testWidgets('Test de integración para _buildLoginBtn', (WidgetTester tester) async {
    // Construye un widget que contiene _buildLoginBtn
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: _ singUserIn(); 
    ));

    // Busca el botón en la pantalla
    final loginBtn = find.text('INGRESAR');

    // Verifica que el botón esté presente en la pantalla
    expect(loginBtn, findsOneWidget);

    // Toca el botón
    await tester.tap(loginBtn);
    await tester.pump();

    // Puedes agregar aserciones adicionales aquí según lo necesites
  });
}

*/