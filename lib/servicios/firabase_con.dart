import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

FirebaseFirestore db = FirebaseFirestore.instance;
final auth = FirebaseAuth.instance;

// ----------------------------------------------------------------------
// FUNCIONES DE PUBLICACIONES (Firestore)
// ----------------------------------------------------------------------

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

Future<void> agregarPublicacion(Map<String, dynamic> dts) async {
  await db.collection("publicaciones").add(dts);
}

// ⚠️ NOTA: Esta función no es eficiente, ver sección de Optimización
Future<void> actualizar(String usuario, String descripcion, String tipo) async {
  final dts = await getPublicaciones();
  for (var d in dts) {
    if (d["usuario"] == usuario) {
      var ud = d["id"];
      await db.collection("publicaciones").doc(ud).update({
        "usuario": d["usuario"],
        "descripcion": descripcion,
        "imagenUrl": d["imagenUrl"],
        "tiempo": d["tiempo"],
        "tipo": tipo,
      });
    }
  }
}

// ⚠️ NOTA: Esta función no es eficiente, ver sección de Optimización
Future<void> borrarDatos(String usuario) async {
  final dts = await getPublicaciones();
  for (var d in dts) {
    if (d["usuario"] == usuario) {
      var ud = d["id"];
      await db.collection("publicaciones").doc(ud).delete();
    }
  }
}

// ----------------------------------------------------------------------
// FUNCIONES DE USUARIO (Auth + Firestore)
// ----------------------------------------------------------------------

Future<String?> agregarUsuario(Map<String, dynamic> dts) async {
  try {
    // 1. Crear la cuenta de usuario en Firebase Authentication
    final UserCredential userCredential = await auth
        .createUserWithEmailAndPassword(
          email: dts["correo"],
          password: dts["password"],
        );

    final String uid = userCredential.user!.uid;

    // 2. Guardar el resto de la información en la colección 'usuarios' de Firestore
    // Usamos el UID de Firebase Auth como ID del documento para vincularlos
    await db.collection("usuarios").doc(uid).set({
      "nombre": dts["nombre"],
      "apellido": dts["apellido"], // <<-- CORREGIDO
      "rol": dts["rol"],
      "correo": dts["correo"],
    });

    return uid; // Devuelve el UID del usuario registrado
  } on FirebaseAuthException catch (e) {
    return e.code;
  } catch (e) {
    return 'error_desconocido';
  }
}

Future<String?> iniciarSesion(String email, String password) async {
  try {
    await auth.signInWithEmailAndPassword(email: email, password: password);
    return null; // Éxito
  } on FirebaseAuthException catch (e) {
    return e.code;
  }
}

Future<void> cerrarSesion() async {
  await auth.signOut();
}

Future<Map<String, dynamic>?> obtenerDatosUsuarioActual() async {
  final user = auth.currentUser;
  if (user != null) {
    final doc = await db.collection("usuarios").doc(user.uid).get();
    return doc.data();
  }
  return null;
}

// Funciones placeholder que puedes desarrollar
Future<void> actualizarUsuario(String nombreUsuario, String nuevoCorreo) async {
  // Lógica de actualización de usuario si la necesitas más adelante
}

Future<void> borrarUsuario(String nombreUsuario) async {
  // Lógica de borrado de usuario si la necesitas más adelante
}
