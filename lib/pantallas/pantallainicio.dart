import 'package:flutter/material.dart';
import 'package:flutter_application_2/pantallas/pantallas.dart';
import 'package:flutter_application_2/rutas/router.dart';

class PantallaInicio extends StatelessWidget {
  const PantallaInicio({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Componentes de Flutter'), elevation: 10),
      body: ListView.separated(
        itemBuilder: (context, index) => ListTile(
          title: Text(AppRouter.menuOp[index].nombre),
          leading: Icon(AppRouter.menuOp[index].icono),
          onTap: () {
            final route = MaterialPageRoute(
              builder: (BuildContext c) {
                return Listview2();
              },
            );
            Navigator.pushNamed(context, AppRouter.menuOp[index].ruta);
          },
        ),
        separatorBuilder: (context, index) => Divider(),
        itemCount: AppRouter.menuOp.length,
      ),
    );
  }
}
