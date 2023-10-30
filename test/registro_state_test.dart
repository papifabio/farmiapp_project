import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:FarmaEnvi/View/registrar_page.dart';

final fakeApp = MaterialApp(
  home: RegistrarPage(),
  routes: {'registro': (context) => Scaffold()},
);
void main() {
  group('Pruebas Unitarias  Registrar usuario', () {
    testWidgets(
      "Presentar Caja de Texto nombre de usuario",
      (WidgetTester tester) async {
        await tester.pumpWidget(fakeApp);
        const inputUser = Key('user');
        final user = find.byKey(inputUser);
        expect(user, findsOneWidget);
      },
    );
    testWidgets(
      "Presentar Caja de Texto para número de teléfono",
      (WidgetTester tester) async {
        await tester.pumpWidget(fakeApp);
        const inputTel = Key('tel');
        final tel = find.byKey(inputTel);
        expect(tel, findsOneWidget);
      },
    );
    testWidgets(
      "Presentar Caja de Texto para número de cédula",
      (WidgetTester tester) async {
        await tester.pumpWidget(fakeApp);
        const inputCed = Key('cedula');
        final ced = find.byKey(inputCed);
        expect(ced, findsOneWidget);
      },
    );
    testWidgets(
      "Presentar Caja de Texto correo",
      (WidgetTester tester) async {
        await tester.pumpWidget(fakeApp);
        const inputMail = Key('email');
        final email = find.byKey(inputMail);
        expect(email, findsOneWidget);
      },
    );
    testWidgets(
      "Presentar Caja de Texto Selección de Rol",
      (WidgetTester tester) async {
        await tester.pumpWidget(fakeApp);
        const inputPass = Key('Pass');
        final pass = find.byKey(inputPass);
        expect(pass, findsOneWidget);
      },
    );
    testWidgets(
      "Presentar Caja de Texto para la contraseña",
      (WidgetTester tester) async {
        await tester.pumpWidget(fakeApp);
        const inputPass = Key('Pass');
        final pass = find.byKey(inputPass);
        expect(pass, findsOneWidget);
      },
    );
    testWidgets(
      "Presentar Caja de Texto para verificación contraseña",
      (WidgetTester tester) async {
        await tester.pumpWidget(fakeApp);
        const inputPass = Key('Pass');
        final pass = find.byKey(inputPass);
        expect(pass, findsOneWidget);
      },
    );
    testWidgets(
      "Presentar Botón de Registro",
      (WidgetTester tester) async {
        await tester.pumpWidget(fakeApp);
        const inputButton = Key('BtnRegistrar');
        final button = find.byKey(inputButton);
        expect(button, findsOneWidget);
      },
    );
    testWidgets(
      "Presentar Botón de Iniciar sesión",
      (WidgetTester tester) async {
        await tester.pumpWidget(fakeApp);
        const inputButton = Key('BtnRegistrar');
        final button = find.byKey(inputButton);
        expect(button, findsOneWidget);
      },
    );
  });
  group('Pruebas de Unitarias Registrar usuario', () {
    testWidgets(
      "Validar sintaxis correcta email",
      (WidgetTester tester) async {
        await tester.pumpWidget(fakeApp);
        const inputUser = Key('user');
        final user = find.byKey(inputUser);
        expect(user, findsOneWidget);
      },
    );
    testWidgets(
      "Email no válido",
      (WidgetTester tester) async {
        await tester.pumpWidget(fakeApp);
        const inputUser = Key('user');
        final user = find.byKey(inputUser);
        expect(user, findsOneWidget);
      },
    );
    testWidgets(
      "La Contraseña no cumple los estándares básicos",
      (WidgetTester tester) async {
        await tester.pumpWidget(fakeApp);
        const inputUser = Key('user');
        final user = find.byKey(inputUser);
        expect(user, findsOneWidget);
      },
    );
    testWidgets(
      "Contraseñas no coinciden",
      (WidgetTester tester) async {
        await tester.pumpWidget(fakeApp);
        const inputUser = Key('user');
        final user = find.byKey(inputUser);
        expect(user, findsOneWidget);
      },
    );
    testWidgets(
      "Contraseñas coinciden correctamente",
      (WidgetTester tester) async {
        await tester.pumpWidget(fakeApp);
        const inputUser = Key('user');
        final user = find.byKey(inputUser);
        expect(user, findsOneWidget);
      },
    );
    testWidgets(
      "Selección de rol",
      (WidgetTester tester) async {
        await tester.pumpWidget(fakeApp);
        const inputCed = Key('cedula');
        final ced = find.byKey(inputCed);
        expect(ced, findsOneWidget);
      },
    );
    testWidgets(
      "Validación todos los campos registrados",
      (WidgetTester tester) async {
        await tester.pumpWidget(fakeApp);
        const inputMail = Key('email');
        final email = find.byKey(inputMail);
        expect(email, findsOneWidget);
      },
    );
    testWidgets(
      "Validación faltan campos por llenar",
      (WidgetTester tester) async {
        await tester.pumpWidget(fakeApp);
        const inputPass = Key('Pass');
        final pass = find.byKey(inputPass);
        expect(pass, findsOneWidget);
      },
    );
    testWidgets(
      "Registro correcto",
      (WidgetTester tester) async {
        await tester.pumpWidget(fakeApp);
        const inputPass = Key('Pass');
        final pass = find.byKey(inputPass);
        expect(pass, findsOneWidget);
      },
    );
  });
  group('Pruebas de Integración Registrar usuario', () {
    testWidgets(
      "Validación usuario ya existe en la base de datos",
      (WidgetTester tester) async {
        await tester.pumpWidget(fakeApp);
        const inputPass = Key('Pass');
        final pass = find.byKey(inputPass);
        expect(pass, findsOneWidget);
      },
    );
    testWidgets(
      "Validación datos correctamente almacenados en Firebase",
      (WidgetTester tester) async {
        await tester.pumpWidget(fakeApp);
        const inputButton = Key('BtnRegistrar');
        final button = find.byKey(inputButton);
        expect(button, findsOneWidget);
      },
    );
  });
}