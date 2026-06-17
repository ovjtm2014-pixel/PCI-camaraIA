# PCI Cámara IA - Aplicación de Inspección de Pavimento

Aplicación móvil multiplataforma para calcular el **Índice de Condición del Pavimento (PCI)** mediante identificación visual con inteligencia artificial.

## Características

- 📱 **Aplicación Móvil**: Compatible con Android, iOS y Raspberry Pi 5
- 🎥 **Visión por Computadora**: Detección automática de daños en pavimento usando IA
- 🤖 **Machine Learning**: Modelo TensorFlow Lite para clasificación de defectos
- 📊 **Cálculo PCI**: Implementación del estándar ASTM D6433
- 💾 **Base de Datos Local**: Almacenamiento de inspecciones y reportes
- 📍 **Geolocalización**: Registro de ubicación GPS en inspecciones
- 📈 **Reportes**: Generación de reportes PDF con visualización de resultados

## Tecnología

- **Framework**: Flutter 3.0+
- **IA/ML**: TensorFlow Lite
- **Base de Datos**: SQLite
- **Mapas**: Google Maps API
- **Backend**: Firebase (opcional)

## Estructura del Proyecto

```
PCI-camaraIA/
├── flutter_app/              # Aplicación Flutter principal
│   ├── lib/
│   │   ├── main.dart
│   │   ├── models/           # Modelos de datos
│   │   ├── screens/          # Pantallas de la aplicación
│   │   ├── services/         # Servicios (cámara, IA, BD)
│   │   └── utils/            # Utilidades y constantes
│   ├── assets/
│   │   └── models/           # Modelos TensorFlow Lite
│   └── pubspec.yaml
├── ml_model/                 # Modelos de Machine Learning
│   ├── training/             # Scripts de entrenamiento
│   └── models/               # Modelos entrenados
├── docs/                     # Documentación
└── README.md
```

## Instalación Rápida

### Android/iOS
```bash
flutter pub get
flutter run
```

### Raspberry Pi 5
```bash
flutter config --enable-linux-desktop
flutter run -d linux
```

## Fases de Desarrollo

- [x] Estructura del proyecto
- [ ] Integración de cámara
- [ ] Modelo IA para detección de daños
- [ ] Cálculo del PCI
- [ ] Interfaz de usuario
- [ ] Base de datos local
- [ ] Exportación de reportes
- [ ] Pruebas y optimización

## Metodología PCI

Se implementa el estándar **ASTM D6433** para cálculo del Índice de Condición del Pavimento.

### Tipos de Daños Detectables

- Grietas (piel de cocodrilo, lineales, transversales)
- Baches (potholes)
- Desprendimientos
- Ahuellamiento
- Exudación
- Parches
- Polvo/Desprendimiento
- Bombeo

## Uso

1. Abre la aplicación
2. Selecciona "Nueva Inspección"
3. Captura fotos del pavimento con la cámara
4. El sistema detecta automáticamente los daños
5. Obtén el cálculo del PCI automático
6. Exporta reportes en PDF

## Contribución

Las contribuciones son bienvenidas. Por favor, abre un issue o pull request.

## Licencia

MIT License

## Contacto

Para más información: [tu email/contacto]

---

**Versión**: 0.1.0  
**Estado**: En desarrollo
