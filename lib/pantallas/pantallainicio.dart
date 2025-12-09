import 'package:flutter/material.dart';
import 'package:flutter_application_2/pantallas/formulario.dart';
import 'package:flutter_application_2/widgets/post_card.dart';
import 'package:flutter_application_2/servicios/firabase_con.dart';

class PantallaInicio extends StatelessWidget {
  const PantallaInicio({super.key});

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;
    final Color cardBackground = Colors.grey[100]!;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Alerta MX'),
        actions: [
          IconButton(icon: const Icon(Icons.search), onPressed: () {}),
          IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: () {},
          ),
        ],
      ),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Widget de Propósito de la Aplicación (Fijo)
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10.0,
              vertical: 8.0,
            ),
            child: Card(
              color: cardBackground,
              elevation: 1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
                side: BorderSide(
                  color: primaryColor.withOpacity(0.5),
                  width: 1,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.warning_amber, color: primaryColor, size: 24),
                    const SizedBox(width: 10),
                    const Expanded(
                      child: Text(
                        'Esta aplicación tiene como objetivo advertir a los ciudadanos sobre los percances más actuales, y que ustedes mismos puedan participar con reportes en tiempo real.',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                          fontWeight: FontWeight.w500,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

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
      ),floatingActionButton: Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        FloatingActionButton(
          heroTag: 'alertaBtn',
          onPressed: () {},
          child: const Icon(Icons.add_alert),
        ),
        const SizedBox(height: 10), 
        FloatingActionButton( heroTag: 'Agregar',
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
        ),],),
    );
  }
}
