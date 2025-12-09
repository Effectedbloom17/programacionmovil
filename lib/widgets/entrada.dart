// Archivo: widgets/entrada.dart (Ejemplo de implementación necesaria)

import 'package:flutter/material.dart';

class Entrada extends StatelessWidget {
  final String label;
  final String hint;
  final IconData iconoSuf;
  final IconData iconFuera;
  final TextInputType tipo;
  final String llavemapa;
  final Map<String, dynamic> mapa;
  // 🚀 Nuevos parámetros agregados para el validador y las líneas
  final String? Function(String?)? validator;
  final int? maxLines;
  final bool obscureText; // Añadir si se usa en login/registro

  const Entrada({
    super.key,
    required this.label,
    required this.hint,
    required this.iconoSuf,
    required this.iconFuera,
    required this.tipo,
    required this.llavemapa,
    required this.mapa,
    // Inicialización de los nuevos parámetros
    this.validator,
    this.maxLines = 1, // Por defecto es 1, para que sea single-line
    this.obscureText = false, // Por defecto es false
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // Uso de los nuevos parámetros
      validator: validator,
      maxLines: maxLines,

      keyboardType: tipo,
      obscureText: obscureText,

      onSaved: (value) {
        mapa[llavemapa] = value;
      },

      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(iconFuera),
        suffixIcon: Icon(iconoSuf),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        filled: true,
        fillColor: Colors.grey[50],
      ),
    );
  }
}
