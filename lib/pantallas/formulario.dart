import 'package:flutter/material.dart';
import 'package:flutter_application_2/consulta.dart';
import 'package:flutter_application_2/servicios/firabase_con.dart';
import 'package:flutter_application_2/widgets/entrada.dart';

class Formulario extends StatelessWidget {
  const Formulario({super.key});

  @override
  Widget build(BuildContext context) {
    final llaveGlobal = GlobalKey<FormState>();
    final Map<String, dynamic> datos = {
      "nombre": "null",
      "apellido": "null",
      "correo": "null",
      "password": "null",
      "rol": "null",
    };

    return Scaffold(
      appBar: AppBar(title: Text("Formulario")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: llaveGlobal,
            child: Column(
              children: [
                Entrada(
                  label: "Nombre",
                  hint: "Escribe tu nombre",
                  iconoSuf: Icons.edit,
                  iconFuera: Icons.person,
                  tipo: TextInputType.name,
                  llavemapa: "nombre",
                  mapa: datos,
                ),
                SizedBox(height: 20),
                Entrada(
                  label: "Apellido",
                  hint: "Escribe tu apellido",
                  tipo: TextInputType.name,
                  iconoSuf: Icons.drive_file_rename_outline,
                  iconFuera: Icons.badge,
                  llavemapa: "apellido",
                  mapa: datos,
                ),
                SizedBox(height: 20),
                Entrada(
                  label: "Correo",
                  hint: "Escribe tu correo",
                  tipo: TextInputType.emailAddress,
                  iconoSuf: Icons.alternate_email,
                  iconFuera: Icons.email,
                  llavemapa: "correo",
                  mapa: datos,
                ),
                SizedBox(height: 20),
                Entrada(
                  label: "password",
                  hint: "Escribe tu contraseña",
                  iconoSuf: Icons.vpn_key,
                  iconFuera: Icons.lock,
                  obscure: true,
                  llavemapa: "password",
                  mapa: datos,
                ),
                SizedBox(height: 20),
                DropdownButtonFormField(
                  icon: Icon(Icons.label),
                  items: [
                    DropdownMenuItem(value: "admin", child: Text("Admin")),
                    DropdownMenuItem(
                      value: "trabajador",
                      child: Text("Trabajador"),
                    ),
                    DropdownMenuItem(
                      value: "operador",
                      child: Text("Empleado"),
                    ),
                  ],
                  onChanged: (dato) {
                    datos["rol"] = dato;
                  },
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (llaveGlobal.currentState!.validate()) {
                      llaveGlobal.currentState!.save();

                      print("Formulario Válido, enviando datos...");
                      print(datos);

                      await agregarPersona(datos).then((_) {
                        print("Se Registro sin Errores");
                        // ----- Extra
                        llaveGlobal.currentState!.reset();

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("¡Registro exitoso!"),
                            backgroundColor: Colors.green,
                          ),
                        );

                        datos.updateAll((key, value) => null);
                        // ----- /Extra
                      });
                    } else {
                      // Entra aquí si hay errores (campos vacíos, etc.)
                      print(
                        "Formulario invalido, por favor corrige los errores",
                      );
                    }
                  },
                  child: SizedBox(
                    width: double.infinity,
                    child: Center(child: Text("Enviar")),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Consulta()),
                    );
                  },
                  child: SizedBox(
                    width: double.infinity,
                    child: Center(child: Text("Consultar")),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    await actualizarDatos(datos["nombre"], datos["apellido"]);
                  },
                  child: SizedBox(
                    width: double.infinity,
                    child: Center(child: Text("Actualizar")),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    await borrarDatos(datos["nombre"]);
                  },
                  child: SizedBox(
                    width: double.infinity,
                    child: Center(child: Text("Eliminar")),
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
