// Archivo: pantallainicio.dart

import 'package:flutter/material.dart';
import 'package:flutter_application_2/widgets/post_card.dart';
import 'package:flutter_application_2/servicios/firabase_con.dart';
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

  void _handleProfileButton(BuildContext context) {
    if (_userData != null) {
      Scaffold.of(context).openEndDrawer();
    } else {
      _showAccessOptions(context);
    }
  }

  Route _createSlideRoute(Widget page) {
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 500), 
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0); 
        const end = Offset.zero;      
        const curve = Curves.easeOut; 

        var tween = Tween(begin: begin, end: end).chain(
          CurveTween(curve: curve),
        );

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

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
                Navigator.of(dialogContext).pop();
                Navigator.push(
                  context,
                  _createSlideRoute(const Registro()),
                ).then((_) => _loadUserData());
              },
            ),
            ElevatedButton(
              child: const Text('INICIAR SESIÓN'),
              onPressed: () {
                Navigator.of(dialogContext).pop();
                Navigator.push(
                  context,
                  _createSlideRoute(const Login()),
                ).then((_) => _loadUserData());
              },
            ),
          ],
        );
      },
    );
  }

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
                Navigator.of(dialogContext).pop();
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
          IconButton(
            icon: const Icon(Icons.help_outline),
            tooltip: 'Propósito de la aplicación',
            onPressed: () => _showPurposeAlert(context),
          ),

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

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
                      _createSlideRoute(const Formulario()),
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