import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

Future<List> getDatos() async {
  List datos = [];
  CollectionReference cr = db.collection("pruebaU");
  QuerySnapshot query = await cr.get();
  query.docs.forEach((action) {
    final Map<String, dynamic> data = action.data() as Map<String, dynamic>;
    final persona = {
      "nombre": data["nombre"],
      "apellido": data["apellido"],
      "correo": data["correo"],
      "password": data["password"],
      "rol": data["rol"],
      "id": action.id,
    };
    print(action.data());
    datos.add(persona);
  });
  print(datos);
  return datos;
}

Future<void> agregarPersona(Map<String, dynamic> dts) async {
  await db.collection("pruebaU").add(dts);
}

Future<void> actualizarDatos(String nombre, String apellido) async {
  final dts = await getDatos();
  print(dts);
  for (var d in dts) {
    if (d["nombre"] == nombre) {
      var id = d["id"];
      await db.collection("pruebaU").doc(id).set({
        "nombre": d["nombre"],
        "correo": d["correo"],
        "password": d["password"],
        "rol": d["rol"],
        "apellido": apellido,
      });
    }
  }
}

Future<void> borrarDatos(String nombre) async {
  final dts = await getDatos();
  print(dts);
  for (var d in dts) {
    if (d["nombre"] == nombre) {
      var id = d["id"];
      await db.collection("pruebaU").doc(id).delete();
    }
  }
}
