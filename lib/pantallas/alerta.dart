import 'package:flutter/material.dart';

class Alerta extends StatelessWidget{
  const Alerta({super.key});
  void ventana_alerta(BuildContext context){
    showDialog(context: context, 
    builder: (context){
      return AlertDialog(
        elevation: 5,
        title: Text("Ttitulo"),
        shape: RoundedRectangleBorder(borderRadius: BorderRadiusDirectional.circular(10)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Esta es una ventana de alerta"),
            SizedBox(height: 10,),
            FlutterLogo(size: 100,)
          ],
        ),
        actions: [
          TextButton(onPressed: (){
            Navigator.pop(context);
            }, 
          child: Text("Aceptar"))
        ],

      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pantalla Alerta"),
      ),
      body: Center(
        child: ElevatedButton(onPressed: (){ventana_alerta(context);},
                             child: Padding(
                               padding: const EdgeInsets.all(8.0),
                               child: Text("Mostrar alerta"),
                             )),
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){Navigator.pop(context);},
                                                child: Icon(Icons.access_alarm_rounded),),
    );
  }
}