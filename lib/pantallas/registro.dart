import 'package:flutter/material.dart';
import 'package:flutter_application_2/widgets/entrada.dart';
import 'package:flutter_application_2/servicios/firabase_con.dart';
import 'package:flutter_application_2/pantallas/pantallas.dart';

class Registro extends StatelessWidget {
  const Registro({super.key});

  // Estilo común para los botones
  static final ButtonStyle primaryButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: Colors.red[700],
    foregroundColor: Colors.white,
    padding: const EdgeInsets.symmetric(vertical: 16),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    elevation: 5,
    textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
  );

  @override
  Widget build(BuildContext context) {
    final llaveGlobal = GlobalKey<FormState>();
    final Color primaryColor = Colors.red[700]!;

    final Map<String, dynamic> datos = {
      "nombre": null,
      "apellido": null,
      "correo": null,
      "password": null,
      "rol": "Ciudadano",
    };

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Registrarse en Alerta MX",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: primaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: llaveGlobal,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Crea tu cuenta ciudadana',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),

                // Campos de Entrada
                Entrada(
                  label: "Nombre",
                  hint: "Escribe tu nombre",
                  iconoSuf: Icons.edit,
                  iconFuera: Icons.person,
                  tipo: TextInputType.name,
                  llavemapa: "nombre",
                  mapa: datos,
                ),
                const SizedBox(height: 20),
                Entrada(
                  label: "Apellido",
                  hint: "Escribe tu apellido",
                  iconoSuf: Icons.edit,
                  iconFuera: Icons.person_outline,
                  tipo: TextInputType.name,
                  llavemapa: "apellido",
                  mapa: datos,
                ),
                const SizedBox(height: 20),
                Entrada(
                  label: "Correo Electrónico",
                  hint: "ejemplo@dominio.com",
                  iconoSuf: Icons.check,
                  iconFuera: Icons.email,
                  tipo: TextInputType.emailAddress,
                  llavemapa: "correo",
                  mapa: datos,
                ),
                const SizedBox(height: 20),
                Entrada(
                  label: "Contraseña",
                  hint: "Mínimo 6 caracteres",
                  iconoSuf: Icons.visibility_off,
                  iconFuera: Icons.lock,
                  tipo: TextInputType.visiblePassword,
                  llavemapa: "password",
                  mapa: datos,
                ),
                const SizedBox(height: 40),

                // 🔴 Botón REGISTRAR USUARIO
                ElevatedButton.icon(
                  onPressed: () async {
                    if (llaveGlobal.currentState!.validate()) {
                      llaveGlobal.currentState!.save();
                      datos["rol"] = "Ciudadano";

                      final resultado = await agregarUsuario(datos);

                      if (resultado != null && resultado.length <= 15) {
                        // Si hay un error, el resultado es el código de error
                        // Manejo de error
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Error al registrar: $resultado"),
                            backgroundColor: Colors.red,
                          ),
                        );
                      } else {
                        // Éxito en el registro y autenticación
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("¡Usuario registrado exitosamente!"),
                            backgroundColor: Colors.green,
                          ),
                        );

                        // 🚀 NAVEGACIÓN DESPUÉS DE REGISTRO
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (context) => const PantallaInicio(),
                          ),
                          (Route<dynamic> route) =>
                              false, // Elimina todas las rutas anteriores
                        );
                      }
                    }
                  },
                  style: primaryButtonStyle,
                  icon: const Icon(Icons.person_add_alt_1),
                  label: const Text("REGISTRAR USUARIO"),
                ),

                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
