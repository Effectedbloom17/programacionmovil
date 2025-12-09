import 'package:flutter/material.dart';

class Tema {
  // Paleta de Colores
  static const Color primary = Color(
    0xFF8B0000,
  ); // Rojo Oscuro/Granate para alerta.
  static const Color secondary = Color(
    0xFFFFB300,
  ); // Naranja Ámbar para advertencia.
  static const Color background = Color(
    0xFFF5F5F5,
  ); // Gris Claro para el fondo del feed.
  static const Color textOnPrimary =
      Colors.white; // Texto blanco en el color primario.

  static final ThemeData lighttheme = ThemeData.light().copyWith(
    // 1. Colores Base
    primaryColor: primary,
    scaffoldBackgroundColor: background, // Fondo claro para el feed
    // 2. AppBar
    appBarTheme: const AppBarTheme(
      backgroundColor: primary,
      foregroundColor: textOnPrimary, // Iconos y texto en blanco
      elevation: 3, // Menos elevación para un look más moderno
      centerTitle: false,
    ),

    // 3. Iconos
    iconTheme: const IconThemeData(color: primary),

    // 4. Botones Flotantes (Para crear nueva publicación)
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: secondary, // Color de Advertencia
      elevation: 5,
      foregroundColor: Colors.black87,
    ),

    // 5. Textos y Enlaces
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: primary),
    ),

    // 6. Botones Elevados
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primary,
        foregroundColor: textOnPrimary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),

    // 7. Estilos de Input (Opcional, si agregas formularios de login/reporte)
    inputDecorationTheme: const InputDecorationTheme(
      floatingLabelStyle: TextStyle(color: primary),
      border: OutlineInputBorder(
        borderSide: BorderSide(color: primary),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: primary, width: 2),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
    ),
  );
}
