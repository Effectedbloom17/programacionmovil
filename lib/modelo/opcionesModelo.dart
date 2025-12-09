import 'package:flutter/material.dart';

class OpcionesModelo{
  final String ruta; //nombre de la ruta
  final IconData icono; //icono de la lista
  final String nombre; //nombre que aparece en lista
  final Widget pantalla; //la pantalla que quiero cargar

  OpcionesModelo({required this.ruta, required this.icono, required this.nombre, required this.pantalla});
}