// Archivo: pantallainicio.dart (Corregido y Actualizado)

import 'package:flutter/material.dart';
import 'package:flutter_application_2/widgets/post_card.dart';
import 'package:flutter_application_2/servicios/firabase_con.dart';
// Asegúrate de que importas Registro, Login y Formulario
import 'package:flutter_application_2/pantallas/pantallas.dart';
import 'package:flutter_application_2/pantallas/login.dart';

class PantallaInicio extends StatefulWidget {
  const PantallaInicio({super.key});

  @override
  State<PantallaInicio> createState() => _PantallaInicioState();
}

class _PantallaInicioState extends State<PantallaInicio> {
  Map<String, dynamic>? _userData;
  final List<IconData> _profileIcons = [
    Icons.person_pin,
    Icons.person_4,
    Icons.verified_user,
    Icons.shield_moon,
  ];
  IconData _userIcon = Icons.person_pin;

  // 💡 MENSAJE DE PROPÓSITO ÚNICO
  static const String _purposeMessage =
      'Esta aplicación tiene como objetivo advertir a los ciudadanos sobre los percances más actuales, y que ustedes mismos puedan participar con reportes en tiempo real.';

  @override
  void initState() {
    super.initState();
    _loadUserData();
    _userIcon =
        _profileIcons[DateTime.now().millisecond % _profileIcons.length];
  }

  Future<void> _loadUserData() async {
    final data = await obtenerDatosUsuarioActual();
    if (mounted) {
      setState(() {
        _userData = data;
      });
    }
  }

  // 🚀 FUNCIÓN MODIFICADA PARA MANEJAR PERFIL/ACCESO
  void _handleProfileButton(BuildContext context) {
    if (_userData != null) {
      // Si está logueado, abre el menú lateral (Drawer)
      Scaffold.of(context).openEndDrawer();
    } else {
      // Si NO está logueado, muestra el diálogo de opciones
      _showAccessOptions(context);
    }
  }

  // 🎁 NUEVO WIDGET: Diálogo para elegir Iniciar Sesión o Registrarse
  void _showAccessOptions(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Acceso a la Plataforma'),
          content: const Text(
            'Para acceder a tu perfil o publicar alertas, por favor Inicia Sesión o Regístrate.',
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('REGISTRARSE'),
              onPressed: () {
                Navigator.of(dialogContext).pop(); // Cierra el diálogo
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Registro()),
                ).then((_) => _loadUserData()); // Recarga al volver
              },
            ),
            ElevatedButton(
              child: const Text('INICIAR SESIÓN'),
              onPressed: () {
                Navigator.of(dialogContext).pop(); // Cierra el diálogo
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Login()),
                ).then((_) => _loadUserData()); // Recarga al volver
              },
            ),
          ],
        );
      },
    );
  }

  // ❓ NUEVA FUNCIÓN: Muestra el diálogo con el propósito de la app
  void _showPurposeAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          icon: const Icon(Icons.info_outline, size: 30),
          title: const Text('Propósito de Alerta MX'),
          content: const Text(
            _purposeMessage,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('ENTENDIDO'),
              onPressed: () {
                Navigator.of(dialogContext).pop(); // Cierra el diálogo
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;
    final bool isLoggedIn = _userData != null;

    return Scaffold(
      endDrawer: isLoggedIn ? _buildUserDrawer(context, primaryColor) : null,

      appBar: AppBar(
        title: const Text('Alerta MX'),
        actions: [
          // 💡 1. Botón de Propósito (Siempre visible, signo de interrogación)
          IconButton(
            icon: const Icon(Icons.help_outline),
            tooltip: 'Propósito de la aplicación',
            onPressed: () => _showPurposeAlert(context),
          ),

          // 💡 2. Botón de Acceso/Registro (Mantiene su función)
          Builder(
            builder: (context) {
              return IconButton(
                icon: Icon(
                  isLoggedIn ? _userIcon : Icons.person_add_alt_1,
                  color: isLoggedIn ? Colors.greenAccent[100] : Colors.white,
                ),
                tooltip: isLoggedIn ? 'Mi Perfil' : 'Acceder',
                onPressed: () => _handleProfileButton(context),
              );
            },
          ),
        ],
      ),

      // BODY: Se elimina el widget fijo de propósito y solo queda la lista
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ❌ SE QUITA EL WIDGET DE PROPÓSITO QUE ESTABA AQUÍ

          // Lista de publicaciones
          Expanded(
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: getPublicaciones(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Center(
                    child: Text('Error al cargar las publicaciones.'),
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(color: primaryColor),
                  );
                }
                if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                  final posts = snapshot.data!;
                  return ListView.builder(
                    itemCount: posts.length,
                    itemBuilder: (context, index) {
                      return PostCard(postData: posts[index]);
                    },
                  );
                }
                return const Center(
                  child: Text('No hay publicaciones de alerta disponibles.'),
                );
              },
            ),
          ),
        ],
      ),

      // Floating Action Button (Solo si está logueado)
      floatingActionButton: isLoggedIn
          ? Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FloatingActionButton(
                  heroTag: 'alertaBtn',
                  onPressed: () {},
                  child: const Icon(Icons.add_alert),
                ),
                const SizedBox(height: 10),
                FloatingActionButton(
                  heroTag: 'Agregar',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Formulario(),
                      ),
                    );
                  },
                  backgroundColor: Colors.green,
                  child: const Icon(Icons.add),
                ),
              ],
            )
          : null,
    );
  }

  // Función que construye el Drawer con la información del usuario (No necesita cambios)
  Widget _buildUserDrawer(BuildContext context, Color primaryColor) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(
              _userData?["nombre"] ?? "Nombre de Usuario",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            accountEmail: Text(_userData?["correo"] ?? "correo@ejemplo.com"),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(_userIcon, size: 50, color: primaryColor),
            ),
            decoration: BoxDecoration(color: primaryColor),
          ),
          ListTile(
            leading: const Icon(Icons.assignment_ind),
            title: Text("Rol: ${_userData?["rol"] ?? "N/A"}"),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.edit_note),
            title: const Text("Editar Perfil"),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text(
              "Cerrar Sesión",
              style: TextStyle(color: Colors.red),
            ),
            onTap: () async {
              Navigator.pop(context);
              await cerrarSesion();
              _loadUserData();
            },
          ),
        ],
      ),
    );
  }
}
