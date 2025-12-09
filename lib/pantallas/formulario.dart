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
      "descripcion": null,
      "imagenUrl": null,
      "tiempo": null,
      "tipo": null,
      "usuario": null,

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
                  label: "Usuario",
                  hint: "Escribe tu usuario",
                  iconoSuf: Icons.edit,
                  iconFuera: Icons.person,
                  tipo: TextInputType.name,
                  llavemapa: "usuario",
                  mapa: datos,
                ),
                SizedBox(height: 20),
                Entrada(
                  label: "ImagenURL",
                  hint: "Ingrea el URL de tu Imagen",
                  tipo: TextInputType.name,
                  iconoSuf: Icons.drive_file_rename_outline,
                  iconFuera: Icons.badge,
                  llavemapa: "imagenUrl",
                  mapa: datos,
                ),
                SizedBox(height: 20),
                Entrada(
                  label: "Tiempo",
                  hint: "Escribe tu tiempo",
                  tipo: TextInputType.emailAddress,
                  iconoSuf: Icons.lock_clock,
                  iconFuera: Icons.timer,
                  llavemapa: "tiempo",
                  mapa: datos,
                ),
                SizedBox(height: 20),
                Entrada(
                  label: "Descripcion",
                  hint: "Escribe tu Descripcion",
                  iconoSuf: Icons.vpn_key,
                  iconFuera: Icons.lock,
                  llavemapa: "descripcion",
                  mapa: datos,
                ),
                SizedBox(height: 20),
                DropdownButtonFormField(
                  icon: Icon(Icons.label),
                  items: [
                    DropdownMenuItem(value: "Desastre", child: Text("Desastre")),
                    DropdownMenuItem(
                      value: "Sismo",
                      child: Text("Sismo"),
                    ),
                    DropdownMenuItem(
                      value: "Contaminacion",
                      child: Text("Contaminacion"),
                    ),DropdownMenuItem(
                      value: "Finalizado",
                      child: Text("Finalizado"),
                    ),
                  ],
                  onChanged: (dato) {
                    datos["tipo"] = dato;
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    if (llaveGlobal.currentState!.validate()) {
                      llaveGlobal.currentState!.save();

                      print("Formulario Válido, enviando datos...");
                      print(datos);

                      await agregarPublicacion(datos).then((_) {
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
                      MaterialPageRoute(builder: (context) => Consultar()),
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
                    await actualizar(datos["usuario"], datos["descripcion"],datos["tipo"]);
                  },
                  child: SizedBox(
                    width: double.infinity,
                    child: Center(child: Text("Actualizar")),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    await borrarDatos(datos["usuario"]);
                  },
                  child: SizedBox(
                    width: double.infinity,
                    child: Center(child: Text("Borrar")),
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
