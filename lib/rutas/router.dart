import 'package:flutter/material.dart';
import 'package:flutter_application_2/modelo/opcionesModelo.dart';
import 'package:flutter_application_2/pantallas/pantallas.dart';

class AppRouter {
  static const initialRoute = "pantallainicio";
  static final menuOp = <OpcionesModelo>[
    OpcionesModelo(
      ruta: 'pantallainicio',
      icono: Icons.home,
      nombre: "Principal",
      pantalla: PantallaInicio(),
    ),
    OpcionesModelo(
      ruta: 'pantallainicio',
      icono: Icons.home,
      nombre: "Principal",
      pantalla: PantallaInicio(),
    ),
  ];
  static Map<String, Widget Function(BuildContext)> routes() {
    Map<String, Widget Function(BuildContext)> appR = {};
    for (final opcion in menuOp) {
      appR.addAll({opcion.ruta: (BuildContext context) => opcion.pantalla});
    }
    return appR;
  }

  static Route<dynamic>? onGenerateRoute1(RouteSettings s) {
    return MaterialPageRoute(
      builder: (context) {
        return PantallaInicio();
      },
    );
  }
}
