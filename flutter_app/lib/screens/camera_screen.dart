import 'package:flutter/material.dart';
import '../models/inspection_model.dart';

class CameraScreen extends StatefulWidget {
  final Inspection inspection;

  const CameraScreen({
    Key? key,
    required this.inspection,
  }) : super(key: key);

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  @override
  void initState() {
    super.initState();
    // TODO: Implementar inicialización de cámara
    // _initializeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Capturar Daños'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.camera_alt,
              size: 64,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            const Text(
              'Cámara en desarrollo',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                // TODO: Implementar captura de fotos
              },
              icon: const Icon(Icons.camera),
              label: const Text('Capturar Foto'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: Liberar recursos de cámara
    super.dispose();
  }
}
