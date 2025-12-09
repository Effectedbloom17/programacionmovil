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
      ruta: 'listview1',
      icono: Icons.label_important_outline,
      nombre: "List View 1",
      pantalla: Listview1(),
    ),
    OpcionesModelo(
      ruta: 'listview2',
      icono: Icons.airline_seat_legroom_extra_outlined,
      nombre: "List View 2",
      pantalla: Listview2(),
    ),
    OpcionesModelo(
      ruta: 'cardview',
      icono: Icons.card_giftcard,
      nombre: "CardViews",
      pantalla: CardV(),
    ),
    OpcionesModelo(
      ruta: 'alerta',
      icono: Icons.accessible_forward_sharp,
      nombre: "Alerta",
      pantalla: Alerta(),
    ),
    OpcionesModelo(
      ruta: 'avatar',
      icono: Icons.align_vertical_bottom_sharp,
      nombre: "Avatar Circle",
      pantalla: Avatar(),
    ),
    OpcionesModelo(
      ruta: 'animacion',
      icono: Icons.account_circle_sharp,
      nombre: "Animacion",
      pantalla: Animacion(),
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
        return Listview1();
      },
    );
  }
}
