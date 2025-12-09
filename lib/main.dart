import 'package:flutter/material.dart';
import 'package:flutter_application_2/pantallas/pantallainicio.dart';
import 'package:flutter_application_2/pantallas/pantallas.dart';
import 'package:flutter_application_2/rutas/router.dart';
import 'package:flutter_application_2/theme/tema.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await initializeDateFormatting('es', null);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: PantallaInicio(),
      initialRoute: AppRouter.initialRoute,
      routes: AppRouter.routes(),
      onGenerateRoute: (settings) => AppRouter.onGenerateRoute1(settings),
      theme: Tema.lighttheme,
    );
  }
}
