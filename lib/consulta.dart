import 'package:flutter/material.dart';
import 'package:flutter_application_2/servicios/firabase_con.dart';

class Consultar extends StatefulWidget {

  const Consultar({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ConsultarState();
  }
}

class _ConsultarState extends State<Consultar> {
  List<dynamic> todosLosUsuarios = [];
  List<dynamic> usuariosFiltrados = [];
  TextEditingController searchController = TextEditingController();

  bool cargando = true;

  @override
  void initState() {
    super.initState();
    cargarDatos();
  }
  void cargarDatos() async {
    var datos = await getPublicaciones();

    if (datos == null) {
      datos = [];
    }

    setState(() {
      todosLosUsuarios = datos;
      usuariosFiltrados = datos;
      cargando = false;
    });
  }

  void filtrarBusqueda(String consulta) {
    List<dynamic> resultados = [];
    if (consulta.isEmpty) {
      resultados = todosLosUsuarios;
    } else {

      String input = consulta.toLowerCase();

      for (var usuario in todosLosUsuarios) {
        String nombre = "";
        if (usuario.containsKey("usuario") && usuario["usuario"] != null) {
          nombre = usuario["usuario"].toString().toLowerCase();
        }
        if (nombre.contains(input)) {
          resultados.add(usuario);
        }
      }
    }
    setState(() {
      usuariosFiltrados = resultados;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Consulta de Personal"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextField(
              controller: searchController,
              onChanged: (String value) {
                filtrarBusqueda(value);
              },
              decoration: const InputDecoration(
                labelText: "Filtrar por usuario",
                hintText: "Escribe un usuario...",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25.0)),
                ),
              ),
            ),
          ),

          Expanded(
            child: _construirCuerpoLista(),
          ),
        ],
      ),
    );
  }

  Widget _construirCuerpoLista() {
    if (cargando) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else if (usuariosFiltrados.isEmpty) {
      return Center(
        child: Text("No se encontraron resultados"),
      );
    } else {
      return ListView.builder(
        itemCount: usuariosFiltrados.length,
        itemBuilder: (BuildContext context, int index) {
          final usuario = usuariosFiltrados[index];

          String Usuario = usuario['usuario'].toString();
          String Tipo = "Tipo: " + usuario['tipo'].toString();
          String Tiempo = "Tiempo: " + usuario['tiempo'].toString();
          String ImagenUrl = "ImagenUrl: " + usuario['imagenUrl'].toString();
          String Descripcion = "Descripcion: " + usuario['descripcion'].toString();

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
                        Usuario,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const Divider(),
                  Text(Tipo),
                  const SizedBox(height: 5),
                  Text(Tiempo),
                  const SizedBox(height: 5),
                  Text(ImagenUrl),
                  const SizedBox(height: 5),
                  Text(Descripcion),
                  const SizedBox(height: 5),
                ],
              ),
            ),
          );
        },
      );
    }
  }
}