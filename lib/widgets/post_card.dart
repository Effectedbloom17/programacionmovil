// post_card.dart (Modificado)
import 'package:flutter/material.dart';

class PostCard extends StatelessWidget {
  final Map<String, dynamic> postData;

  const PostCard({super.key, required this.postData});

  @override
  Widget build(BuildContext context) {
    final String? imageUrl = postData['imagenUrl'];
    print(
      'PostCard loading image for user: ${postData['usuario']} URL: $imageUrl',
    );
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),

      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Encabezado del Post
            ListTile(
              leading: const CircleAvatar(
                backgroundColor: Colors.blueGrey,
                child: Icon(Icons.person, color: Colors.white),
              ),
              title: Text(
                postData['usuario'],
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                '${postData['tipo']} · Hace ${postData['tiempo']}',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              trailing: const Icon(Icons.more_vert),
            ),

            // 2. Contenido/Descripción
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 4.0,
              ),
              child: Text(
                postData['descripcion'],
                style: const TextStyle(fontSize: 16),
              ),
            ),

            // 3. Imagen (Si existe) - Ahora con recorte de borde
            if (imageUrl != null && imageUrl.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(
                  top: 8.0,
                  bottom: 8.0,
                  left: 1.0,
                  right: 1.0,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: Image.network(
                    postData['imagenUrl'],
                    fit: BoxFit.cover,
                    height: 220,
                    width: double.infinity,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Container(
                        // Placeholder mientras carga
                        height: 220,
                        color: Colors.grey[200],
                        alignment: Alignment.center,
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                              : null,
                          color: Theme.of(context).primaryColor,
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) => Container(
                      height: 220,
                      color: Colors.grey[300],
                      alignment: Alignment.center,
                      child: const Text(
                        'Imagen no disponible',
                        style: TextStyle(color: Colors.black54),
                      ),
                    ),
                  ),
                ),
              ),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.thumb_up_alt_outlined, size: 20),
                  Text('150 Reportes'),
                  Icon(Icons.comment_outlined, size: 20),
                  Text('23 Comentarios'),
                  Icon(Icons.share_outlined, size: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
