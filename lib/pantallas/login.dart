import 'package:flutter/material.dart';
import 'package:flutter_application_2/widgets/entrada.dart';
import 'package:flutter_application_2/servicios/firabase_con.dart';
import 'package:flutter_application_2/pantallas/pantallas.dart'; // Para PantallaInicio

class Login extends StatelessWidget {
  const Login({super.key});

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

    final Map<String, String> credenciales = {"correo": "", "password": ""};

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Iniciar Sesión",
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
                  'Accede a tu cuenta de Alerta MX',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),

                // Campo CORREO
                Entrada(
                  label: "Correo Electrónico",
                  hint: "ejemplo@dominio.com",
                  iconoSuf: Icons.check,
                  iconFuera: Icons.email,
                  tipo: TextInputType.emailAddress,
                  llavemapa: "correo",
                  mapa: credenciales,
                  // Nota: En el widget Entrada, asegúrate que guarda los valores correctamente.
                ),
                const SizedBox(height: 20),

                // Campo CONTRASEÑA
                Entrada(
                  label: "Contraseña",
                  hint: "Tu contraseña",
                  iconoSuf: Icons.visibility_off,
                  iconFuera: Icons.lock,
                  tipo: TextInputType.visiblePassword,
                  llavemapa: "password",
                  mapa: credenciales,
                  // Nota: Asume que Entrada maneja obscureText
                ),
                const SizedBox(height: 40),

                // 🔑 Botón INICIAR SESIÓN
                ElevatedButton.icon(
                  onPressed: () async {
                    if (llaveGlobal.currentState!.validate()) {
                      llaveGlobal.currentState!.save();

                      final resultado = await iniciarSesion(
                        credenciales["correo"]!,
                        credenciales["password"]!,
                      );

                      if (resultado == null) {
                        // Éxito en el inicio de sesión
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("¡Inicio de sesión exitoso!"),
                            backgroundColor: Colors.green,
                          ),
                        );

                        // Navegar a PantallaInicio y limpiar la pila de navegación
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (context) => const PantallaInicio(),
                          ),
                          (Route<dynamic> route) => false,
                        );
                      } else {
                        // Error de autenticación (ej: wrong-password, user-not-found)
                        String mensajeError = "Error de inicio de sesión";
                        if (resultado == 'user-not-found') {
                          mensajeError = "No existe un usuario con ese correo.";
                        } else if (resultado == 'wrong-password') {
                          mensajeError = "Contraseña incorrecta.";
                        } else if (resultado == 'invalid-email') {
                          mensajeError = "Formato de correo inválido.";
                        }

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(mensajeError),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    }
                  },
                  style: primaryButtonStyle,
                  icon: const Icon(Icons.login),
                  label: const Text("INICIAR SESIÓN"),
                ),

                const SizedBox(height: 30),

                // 📝 Botón REGISTRARSE
                TextButton(
                  onPressed: () {
                    // Navegar a la pantalla de Registro (si ya la creaste)
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const Registro()),
                    );
                  },
                  child: Text(
                    "¿No tienes cuenta? Regístrate aquí",
                    style: TextStyle(
                      color: primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
