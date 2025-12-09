import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

Future<List<Map<String, dynamic>>> getPublicaciones() async {
  List<Map<String, dynamic>> publicaciones = [];

  CollectionReference cr = db.collection("publicaciones");

  QuerySnapshot query = await cr.get();

  for (var action in query.docs) {
    final Map<String, dynamic> data = action.data() as Map<String, dynamic>;
    final post = {
      "descripcion": data["descripcion"] ?? "Sin descripción",
      "imagenUrl": data["imagenUrl"] as String? ?? '',
      "tiempo": data["tiempo"] ?? "Desconocido",
      "tipo": data["tipo"] ?? "Evento",
      "usuario": data["usuario"] ?? "Anónimo",
      "id": action.id,
    };

    publicaciones.add(post);
  }

  return publicaciones;
}
