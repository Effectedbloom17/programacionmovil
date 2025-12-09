import 'package:flutter/material.dart';

class Entrada extends StatelessWidget {
  final String? hint;
  final String? label;
  final IconData? iconoSuf;
  final IconData? iconFuera;
  final TextInputType? tipo;
  final bool obscure;
  final String llavemapa;
  final Map<String, dynamic> mapa;

  const Entrada({
    super.key,
    this.hint,
    this.label,
    this.iconoSuf,
    this.iconFuera,
    this.tipo,
    this.obscure = false,
    required this.llavemapa,
    required this.mapa,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: tipo,
      obscureText: obscure,
      textCapitalization: TextCapitalization.words,
      onChanged: (value) {
        mapa[llavemapa] = value;
      },
      onSaved: (value) {
        mapa[llavemapa] = value;
      },
      validator: (valor) {
        if (valor == null || valor.isEmpty) {
          return "Este campo es obligatorio";
        }
        return null;
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        hintText: hint,
        labelText: label,
        suffixIcon: Icon(iconoSuf),
        icon: Icon(iconFuera),
      ),
    );
  }
}
