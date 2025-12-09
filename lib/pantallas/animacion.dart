import 'dart:math';

import 'package:flutter/material.dart';

class Animacion extends StatefulWidget {
  const Animacion({super.key});

  @override
  State<Animacion> createState() => _AnimacionState();
}

class _AnimacionState extends State<Animacion> {
  double ancho = 100;
  double alto = 100;
  Color colores = Colors.red;

  void cambiarConte() {
    final random = Random();
    ancho = random.nextInt(300) + 10;
    alto = random.nextInt(300) + 10;
    colores = Color.fromRGBO(
      random.nextInt(255),
      random.nextInt(255),
      random.nextInt(255),
      1,
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Animacion")),
      body: Center(
        child: AnimatedContainer(
          duration: Duration(milliseconds: 500),
          curve: Curves.bounceInOut,
          width: ancho,
          height: alto,
          decoration: BoxDecoration(
            color: colores,
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          cambiarConte();
        },
        child: Icon(Icons.vape_free),
      ),
    );
  }
}
