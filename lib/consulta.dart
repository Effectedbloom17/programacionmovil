import 'package:flutter/material.dart';
import 'package:flutter_application_2/servicios/firabase_con.dart';

class Consulta extends StatefulWidget {
  const Consulta({super.key});
  @override
  State<StatefulWidget> createState() => _ConsultarState();
}

class _ConsultarState extends State<Consulta> {
  List<dynamic> todosLosUsuarios = [];
  List<dynamic> usuariosFiltrados = [];
  TextEditingController searchController = TextEditingController();

  bool cargando = true;

  @override
  void initState() {
    super.initState();
    cargarDatos();
  }

  // Función para traer los datos una sola vez al iniciar
  void cargarDatos() async {
    var datos = await getDatos();

    setState(() {
      todosLosUsuarios = datos ?? [];
      usuariosFiltrados = datos ?? [];
      cargando = false;
    });
  }

  // Lógica para filtrar la lista
  void filtrarBusqueda(String consulta) {
    List<dynamic> resultados = [];
    if (consulta.isEmpty) {
      resultados = todosLosUsuarios;
    } else {
      resultados = todosLosUsuarios.where((usuario) {
        String nombre = usuario["nombre"].toString().toLowerCase();
        String input = consulta.toLowerCase();
        return nombre.contains(input);
      }).toList();
    }

    // Actualizamos la interfaz
    setState(() {
      usuariosFiltrados = resultados;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Consulta de Personal")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextField(
              controller: searchController,
              onChanged: (value) => filtrarBusqueda(value),
              decoration: const InputDecoration(
                labelText: "Filtrar por nombre",
                hintText: "Escribe un nombre...",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25.0)),
                ),
              ),
            ),
          ),

          Expanded(
            child: cargando
                ? const Center(child: CircularProgressIndicator())
                : usuariosFiltrados.isEmpty
                ? const Center(child: Text("No se encontraron resultados"))
                : ListView.builder(
                    itemCount: usuariosFiltrados.length,
                    itemBuilder: (context, index) {
                      final usuario = usuariosFiltrados[index];

                      return Card(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 8,
                        ),
                        elevation: 4,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Icon(Icons.person, color: Colors.blue),
                                  const SizedBox(width: 10),
                                  Text(
                                    "${usuario['nombre']} ${usuario['apellido']}",
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              const Divider(),
                              // Resto de los datos
                              Text("Correo: ${usuario['correo']}"),
                              const SizedBox(height: 5),
                              Text("Rol: ${usuario['rol']}"),
                              const SizedBox(height: 5),
                              Text(
                                "Contraseña: ${usuario['password']}",
                                style: const TextStyle(color: Colors.redAccent),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
