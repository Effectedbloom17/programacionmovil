// Archivo: post_card.dart (Completo y Corregido)

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:convert';

class PostCard extends StatelessWidget {
  final Map<String, dynamic> postData;

  const PostCard({super.key, required this.postData});

  // 📅 Función para formatear la cadena de tiempo
  String _formatTime(String timeString) {
    // 💡 Validación clave: Si no contiene guiones ('-'), asumimos que es un tiempo relativo
    // ("Hace 5 min", "1 hora") y lo devolvemos sin formatear.
    if (!timeString.contains('-')) {
      return timeString;
    }

    try {
      // 1. Convertir la cadena (YYYY-MM-DD HH:MM:SS) a objeto DateTime
      final DateTime dateTime = DateTime.parse(timeString);

      // 2. Definir el formato: '09/12/2025 a las 15 hrs'
      // dd/MM/yyyy: Fecha numérica
      // H: Hora en formato 24h sin ceros iniciales
      final DateFormat formatter = DateFormat(
        "dd/MM/yyyy 'a las' H 'hrs'", // 💡 PATRÓN DE FORMATO FINAL SOLICITADO
        'es', // El locale español es importante para evitar problemas futuros, aunque con este patrón no se usa MMMM.
      );

      // 3. Aplicar el formato
      return formatter.format(dateTime);
    } catch (e) {
      // Devolver la cadena original si falla el parseo
      return timeString;
    }
  }

  // 🖼️ Widget para construir la imagen (maneja URL y Base64)
  Widget _buildImageWidget(String imageUrl) {
    // Si la cadena comienza con 'data:image/...' es Base64
    if (imageUrl.startsWith('data:image/')) {
      final String base64String = imageUrl.split(',').last;

      try {
        return Image.memory(
          base64Decode(base64String),
          fit: BoxFit.cover,
          height: 220,
          width: double.infinity,
          errorBuilder: (context, error, stackTrace) =>
              _imageErrorPlaceholder(),
        );
      } catch (e) {
        return _imageErrorPlaceholder(message: 'Error al decodificar imagen.');
      }
    } else {
      // Es una URL externa, usar Image.network
      return Image.network(
        imageUrl,
        fit: BoxFit.cover,
        height: 220,
        width: double.infinity,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Container(
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
        errorBuilder: (context, error, stackTrace) => _imageErrorPlaceholder(),
      );
    }
  }

  Widget _imageErrorPlaceholder({String message = 'Imagen no disponible'}) {
    return Container(
      height: 220,
      color: Colors.grey[300],
      alignment: Alignment.center,
      child: Text(message, style: const TextStyle(color: Colors.black54)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final String? imageUrl = postData['imagenUrl'];

    // 💡 Formatear el tiempo antes de usarlo
    final String tiempoFormateado = _formatTime(postData['tiempo'] ?? '');

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
                // 💡 USAR EL TIEMPO FORMATEADO
                '${postData['tipo']} · ${tiempoFormateado}',
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

            // 3. Imagen (Si existe) - Ahora con manejo de Base64
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
                  // 💡 USAR EL WIDGET AUXILIAR QUE MANEJA Base64/URL
                  child: _buildImageWidget(imageUrl),
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
