import 'package:FarmaEnvi/Controller/FirebaseController.dart';
import 'package:flutter/material.dart';
import 'package:FarmaEnvi/View/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:FarmaEnvi/firebase_options.dart';
import 'View/Cliente/menu.dart';
import 'View/registrar_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light()
          .copyWith(scaffoldBackgroundColor: Color.fromRGBO(226, 227, 217, 1)),
      initialRoute: 'auth',
      debugShowCheckedModeBanner: false,
      routes: {
        'auth': (_) => const AuthUser(),
        'login': (_) => Login(),
        'registro': (_) => RegistrarPage(),
        'menu': (_) => Menu(),
      },
    );
  }
}
