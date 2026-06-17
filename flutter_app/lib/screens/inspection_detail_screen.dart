import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../services/database_service.dart';
import '../models/inspection_model.dart';

class InspectionDetailScreen extends StatefulWidget {
  final String inspectionId;

  const InspectionDetailScreen({
    Key? key,
    required this.inspectionId,
  }) : super(key: key);

  @override
  State<InspectionDetailScreen> createState() => _InspectionDetailScreenState();
}

class _InspectionDetailScreenState extends State<InspectionDetailScreen> {
  late Future<Inspection?> _inspectionFuture;

  @override
  void initState() {
    super.initState();
    _inspectionFuture = context.read<DatabaseService>().getInspection(widget.inspectionId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle de Inspección'),
        centerTitle: true,
      ),
      body: FutureBuilder<Inspection?>(
        future: _inspectionFuture,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final inspection = snapshot.data!;
          final dateFormat = DateFormat('dd/MM/yyyy HH:mm');
          final pciColor = Color(inspection.getConditionColor());

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Encabezado con PCI
                if (inspection.pciScore != null)
                  Card(
                    color: pciColor,
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        children: [
                          const Text(
                            'Índice de Condición del Pavimento',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            inspection.pciScore!.toStringAsFixed(1),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 48,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            inspection.getPavementCondition(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                else
                  Card(
                    color: Colors.grey[300],
                    child: const Padding(
                      padding: EdgeInsets.all(24.0),
                      child: Center(
                        child: Text(
                          'PCI no calculado',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),

                const SizedBox(height: 24),

                // Información de la vía
                _SectionHeader(title: 'Información de la Vía'),
                const SizedBox(height: 12),
                _InfoRow(label: 'Nombre', value: inspection.roadName),
                _InfoRow(label: 'Sección', value: inspection.roadSection),
                _InfoRow(
                  label: 'Largo',
                  value: '${inspection.sectionLength.toStringAsFixed(2)} m',
                ),
                _InfoRow(
                  label: 'Ancho',
                  value: '${inspection.sectionWidth.toStringAsFixed(2)} m',
                ),
                _InfoRow(
                  label: 'Área',
                  value: '${(inspection.sectionLength * inspection.sectionWidth).toStringAsFixed(2)} m²',
                ),

                const SizedBox(height: 24),

                // Información de la inspección
                _SectionHeader(title: 'Información de la Inspección'),
                const SizedBox(height: 12),
                _InfoRow(
                  label: 'Fecha',
                  value: dateFormat.format(inspection.inspectionDate),
                ),
                _InfoRow(label: 'Inspector', value: inspection.inspector),
                if (inspection.notes != null)
                  _InfoRow(label: 'Notas', value: inspection.notes!),
                if (inspection.latitude != null && inspection.longitude != null)
                  _InfoRow(
                    label: 'Ubicación',
                    value: '${inspection.latitude}, ${inspection.longitude}',
                  ),

                const SizedBox(height: 24),

                // Daños detectados
                _SectionHeader(title: 'Daños Detectados'),
                const SizedBox(height: 12),
                if (inspection.damages.isEmpty)
                  const Text(
                    'No hay daños registrados',
                    style: TextStyle(
                      color: Colors.grey,
                      fontStyle: FontStyle.italic,
                    ),
                  )
                else
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: inspection.damages.length,
                    itemBuilder: (context, index) {
                      final damage = inspection.damages[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 8.0),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    damage.getTypeName(),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      damage.getSeverityName(),
                                      style: const TextStyle(
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Área: ${damage.area.toStringAsFixed(2)} m²',
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                  Text(
                                    'Confianza: ${(damage.confidence * 100).toStringAsFixed(0)}%',
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),

                const SizedBox(height: 24),

                // Botones de acción
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {
                          // TODO: Compartir reporte
                        },
                        icon: const Icon(Icons.share),
                        label: const Text('Compartir'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          // TODO: Exportar a PDF
                        },
                        icon: const Icon(Icons.download),
                        label: const Text('Descargar'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;

  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }
}
