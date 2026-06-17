import 'package:flutter/material.dart';
import '../models/inspection_model.dart';
import 'camera_screen.dart';

class NewInspectionScreen extends StatefulWidget {
  const NewInspectionScreen({Key? key}) : super(key: key);

  @override
  State<NewInspectionScreen> createState() => _NewInspectionScreenState();
}

class _NewInspectionScreenState extends State<NewInspectionScreen> {
  final _formKey = GlobalKey<FormState>();
  
  late TextEditingController _roadNameController;
  late TextEditingController _roadSectionController;
  late TextEditingController _sectionLengthController;
  late TextEditingController _sectionWidthController;
  late TextEditingController _inspectorController;
  late TextEditingController _notesController;

  @override
  void initState() {
    super.initState();
    _roadNameController = TextEditingController();
    _roadSectionController = TextEditingController();
    _sectionLengthController = TextEditingController();
    _sectionWidthController = TextEditingController();
    _inspectorController = TextEditingController();
    _notesController = TextEditingController();
  }

  @override
  void dispose() {
    _roadNameController.dispose();
    _roadSectionController.dispose();
    _sectionLengthController.dispose();
    _sectionWidthController.dispose();
    _inspectorController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  void _proceedToCamera() {
    if (_formKey.currentState!.validate()) {
      final inspection = Inspection(
        roadName: _roadNameController.text,
        roadSection: _roadSectionController.text,
        sectionLength: double.parse(_sectionLengthController.text),
        sectionWidth: double.parse(_sectionWidthController.text),
        inspector: _inspectorController.text,
        notes: _notesController.text.isNotEmpty ? _notesController.text : null,
      );

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => CameraScreen(inspection: inspection),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nueva Inspección'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Datos de la vía',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _roadNameController,
                decoration: const InputDecoration(
                  labelText: 'Nombre de la vía',
                  hintText: 'Ej: Avenida Principal',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Campo requerido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _roadSectionController,
                decoration: const InputDecoration(
                  labelText: 'Sección de la vía',
                  hintText: 'Ej: Km 0+000 - Km 0+500',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Campo requerido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _sectionLengthController,
                      decoration: const InputDecoration(
                        labelText: 'Largo (m)',
                        hintText: '100',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Requerido';
                        }
                        if (double.tryParse(value) == null) {
                          return 'Número inválido';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextFormField(
                      controller: _sectionWidthController,
                      decoration: const InputDecoration(
                        labelText: 'Ancho (m)',
                        hintText: '3.5',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Requerido';
                        }
                        if (double.tryParse(value) == null) {
                          return 'Número inválido';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              const Text(
                'Datos del inspector',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _inspectorController,
                decoration: const InputDecoration(
                  labelText: 'Nombre del inspector',
                  hintText: 'Ej: Juan Pérez',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Campo requerido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _notesController,
                decoration: const InputDecoration(
                  labelText: 'Notas (opcional)',
                  hintText: 'Observaciones adicionales',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _proceedToCamera,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text('Continuar a Cámara'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
