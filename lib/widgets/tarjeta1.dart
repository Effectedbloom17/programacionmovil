import 'package:flutter/material.dart';
import 'package:flutter_application_2/theme/tema.dart';

class Tarjeta1 extends StatelessWidget {
  const Tarjeta1({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
            leading: Icon(Icons.add_comment_rounded, color: Tema.primary),
            title: Text("Esta es una tarjeta"),
            subtitle: Text("Esto es un subtítulo para la tarjeta"),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(onPressed: (){}, child: Text("Aceptar")),
                TextButton(onPressed: (){}, child: Text("Cancelar"))
              ],
            ),
          )
        ],
      ),
    );
  }
}
