// Archivo: Formulario.dart (Completo y Corregido)

import 'package:flutter/material.dart';
import 'package:flutter_application_2/servicios/firabase_con.dart';
import 'package:flutter_application_2/widgets/entrada.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io'
    if (dart.library.html) 'dart:html'; // 💡 Importación condicional
import 'dart:convert'; // 💡 Importar para Base64

class Formulario extends StatefulWidget {
  const Formulario({super.key});

  @override
  State<Formulario> createState() => _FormularioState();
}

class _FormularioState extends State<Formulario> {
  final llaveGlobal = GlobalKey<FormState>();
  String _nombreUsuario = "Cargando...";
  final Map<String, dynamic> datos = {
    "descripcion": null,
    "imagenUrl": null, // Aquí se guardará el URL de Internet o la cadena Base64
    "tipo": null,
    "otroTipo": null,
  };

  // Estado para manejar la selección de imagen local y el menú "Otro"
  XFile? _imagenLocal;
  bool _mostrarOtroCampo = false;

  final List<String> tiposAlerta = [
    "Sismo",
    "Accidente Vial",
    "Actividad Volcánica",
    "Contaminación",
    "Otro",
  ];

  static final ButtonStyle publishButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: Colors.green[700],
    foregroundColor: Colors.white,
    padding: const EdgeInsets.symmetric(vertical: 18),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    elevation: 8,
    textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
  );

  @override
  void initState() {
    super.initState();
    _loadUserName();
  }

  Future<void> _loadUserName() async {
    final userData = await obtenerDatosUsuarioActual();
    if (mounted) {
      setState(() {
        _nombreUsuario = userData?["nombre"] ?? "Anónimo";
      });
    }
  }

  // 📸 FUNCIÓN PARA SELECCIONAR IMAGEN Y PREPARAR URL (O Base64)
  Future<void> _seleccionarImagen() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _imagenLocal = image;
        datos["imagenUrl"] =
            null; // Limpia el URL si se selecciona imagen local
      });
    }
  }

  // 🗑️ FUNCIÓN PARA ELIMINAR IMAGEN SELECCIONADA
  void _removerImagen() {
    setState(() {
      _imagenLocal = null;
    });
  }

  // 🖼️ Widget para mostrar la imagen seleccionada. En Web se usa la propiedad path del XFile
  Widget _buildImagePreview() {
    if (_imagenLocal == null) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Container(
            height: 200, // Aumentado ligeramente para mejor vista
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              // En web, XFile.path contiene el blob URL
              image: DecorationImage(
                image: NetworkImage(
                  _imagenLocal!.path,
                ), // 💡 Usar NetworkImage o MemoryImage
                fit: BoxFit.cover,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.cancel, color: Colors.red, size: 30),
            onPressed: _removerImagen,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Colors.red[700]!;

    return Scaffold(
      // ... (AppBar y otras partes omitidas por brevedad, son las mismas)
      appBar: AppBar(
        title: const Text(
          "🚨 Crear Nueva Alerta",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: primaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: llaveGlobal,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // ... (Secciones de Usuario, Dropdown y Descripción, son las mismas)

                // 1. Indicador de Usuario Logueado
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.red[50],
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: primaryColor.withOpacity(0.3)),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.person, color: Colors.black87),
                      const SizedBox(width: 10),
                      Text(
                        "Publicando como: $_nombreUsuario",
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 25),

                // 2. Tipo de Post (Dropdown)
                InputDecorator(
                  decoration: InputDecoration(
                    labelText: "Tipo de Alerta",
                    prefixIcon: const Icon(Icons.warning, color: Colors.red),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButtonFormField<String>(
                      isExpanded: true,
                      value: datos["tipo"],
                      hint: const Text("Selecciona el tipo de percance"),
                      items: tiposAlerta
                          .map(
                            (String value) => DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: TextStyle(color: primaryColor),
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (String? dato) {
                        setState(() {
                          datos["tipo"] = dato;
                          _mostrarOtroCampo = dato == "Otro";
                          if (!_mostrarOtroCampo) {
                            datos["otroTipo"] = null;
                          }
                        });
                      },
                      validator: (value) =>
                          value == null ? 'Por favor selecciona un tipo' : null,
                    ),
                  ),
                ),
                const SizedBox(height: 25),

                // 3. CAMPO CONDICIONAL PARA "OTRO"
                if (_mostrarOtroCampo) ...[
                  Entrada(
                    label: "Especificar Tipo de Alerta",
                    hint: "Ej: Nevadas intensas, Fuga de gas, etc.",
                    iconoSuf: Icons.format_list_bulleted,
                    iconFuera: Icons.label_important,
                    tipo: TextInputType.text,
                    llavemapa: "otroTipo",
                    mapa: datos,
                    validator: (value) => value!.isEmpty
                        ? 'Debes especificar el tipo de alerta'
                        : null,
                  ),
                  const SizedBox(height: 25),
                ],

                // 4. Descripción
                Entrada(
                  label: "Descripción de la Alerta",
                  hint:
                      "Detalla el percance (Ubicación, intensidad, estado actual)",
                  iconoSuf: Icons.text_fields,
                  iconFuera: Icons.description,
                  tipo: TextInputType.multiline,
                  llavemapa: "descripcion",
                  mapa: datos,
                  maxLines: 4,
                  validator: (value) =>
                      value!.isEmpty ? 'La descripción es obligatoria' : null,
                ),
                const SizedBox(height: 25),

                // 5. Opción Subir Foto
                OutlinedButton.icon(
                  icon: const Icon(Icons.photo_library),
                  label: Text(
                    _imagenLocal != null
                        ? 'Cambiar Foto'
                        : 'Subir Foto desde Dispositivo',
                  ),
                  onPressed: _seleccionarImagen,
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    foregroundColor: primaryColor,
                    side: BorderSide(color: primaryColor),
                  ),
                ),

                // Muestra la imagen local
                _buildImagePreview(),

                // 6. Enlace de Imagen (Opcional, si no se subió foto)
                if (_imagenLocal == null)
                  Padding(
                    padding: const EdgeInsets.only(top: 25.0),
                    child: Entrada(
                      label: "O Enlace de Imagen (Opcional)",
                      hint:
                          "Pega el link de una imagen relevante o déjalo vacío",
                      iconoSuf: Icons.link,
                      iconFuera: Icons.image,
                      tipo: TextInputType.url,
                      llavemapa: "imagenUrl",
                      mapa: datos,
                      validator: (value) {
                        if (value != null &&
                            value.isNotEmpty &&
                            !Uri.parse(value).isAbsolute) {
                          return 'Por favor, ingresa un URL válido';
                        }
                        return null;
                      },
                    ),
                  ),

                const SizedBox(height: 40),

                // 🚀 Botón PUBLICAR
                ElevatedButton.icon(
                  onPressed: () async {
                    if (llaveGlobal.currentState!.validate()) {
                      llaveGlobal.currentState!.save();

                      final String nombreParaPublicacion =
                          _nombreUsuario == "Cargando..."
                          ? "Usuario"
                          : _nombreUsuario;

                      // 💡 2. LÓGICA DE CONVERSIÓN A BASE64 (SOLUCIÓN SIN STORAGE)
                      String? finalImageUrl = datos["imagenUrl"];

                      if (_imagenLocal != null) {
                        try {
                          // Lee los bytes de la imagen
                          final bytes = await _imagenLocal!.readAsBytes();

                          // Convierte los bytes a cadena Base64
                          finalImageUrl =
                              'data:image/jpeg;base64,${base64Encode(bytes)}';
                        } catch (e) {
                          // Manejo de error si la lectura falla
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Error al leer la imagen: $e"),
                              backgroundColor: Colors.orange,
                            ),
                          );
                          return;
                        }
                      }

                      // 3. Determinar el TIPO final
                      String tipoFinal = datos["tipo"];
                      if (_mostrarOtroCampo && datos["otroTipo"] != null) {
                        tipoFinal = datos["otroTipo"];
                      }

                      // 4. Obtener la fecha y hora actual (Formato legible)
                      final String tiempoActual = DateTime.now()
                          .toLocal()
                          .toString()
                          .split('.')[0]; // Ej: 2025-12-09 14:56:06

                      final Map<String, dynamic> datosPublicacion = {
                        "descripcion": datos["descripcion"],
                        "imagenUrl": finalImageUrl, // Ahora es URL o Base64
                        "tiempo": tiempoActual,
                        "tipo": tipoFinal,
                      };

                      try {
                        await agregarPublicacion(
                          datosPublicacion,
                          nombreParaPublicacion,
                        );

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("¡Alerta publicada exitosamente!"),
                            backgroundColor: Colors.green,
                          ),
                        );

                        Navigator.pop(context);
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Error al publicar la alerta: $e"),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    }
                  },
                  style: publishButtonStyle,
                  icon: const Icon(Icons.send_rounded),
                  label: const Text("PUBLICAR ALERTA"),
                ),

                const SizedBox(height: 20),

                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    "Cancelar y volver",
                    style: TextStyle(color: primaryColor.withOpacity(0.8)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
