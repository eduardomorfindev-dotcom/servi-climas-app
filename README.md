# ServiClimasApp

App nativa de iOS para gestionar servicios de aire acondicionado y refrigeración en Manzanillo, Colima. Permite a los clientes registrarse, iniciar sesión y solicitar mantenimiento, instalación, reparación o compra de equipos, todo desde el celular.

## Funcionalidades

- **Autenticación real** con Firebase Authentication (registro, inicio de sesión, cierre de sesión).
- **Verificación de cuenta** con código de un solo uso y reenvío con cuenta regresiva.
- **4 flujos de servicio**, cada uno con sus propios campos:
  - **Mantenimiento**: tipo de equipo, tipo de mantenimiento, fecha/hora, comentario, método de pago.
  - **Instalación**: capacidad, tipo de lugar, piso, fecha/hora, método de pago.
  - **Reparación**: tipo de aire, síntoma, comentario, método de pago, fecha/hora.
  - **Compra de aire acondicionado**: capacidad, tipo, voltaje, método de pago, factura.
- **Persistencia en la nube**: cada solicitud confirmada se guarda en Cloud Firestore.
- **Notificaciones locales** (`UNUserNotificationCenter`) al cliente y al dueño del negocio — inmediatas o programadas un día antes de la cita, según el servicio.

## Tecnologías

- Swift 5 + UIKit, interfaz 100% programática (sin Storyboards para las pantallas).
- Firebase Authentication
- Cloud Firestore
- `UserNotifications` framework
- `UINavigationController` para una navegación consistente entre pantallas

## Arquitectura

El proyecto sigue un patrón similar a MVC, con una capa de modelos independiente de las vistas:

- `Models/SolicitudServicio.swift`: protocolo común que implementan las 4 solicitudes (`SolicitudMantenimiento`, `SolicitudInstalacion`, `SolicitudReparacion`, `SolicitudCompraAire`), para que una sola pantalla de confirmación y una sola pantalla de éxito sirvan para los 4 servicios sin duplicar código.
- `Models/SesionManager.swift`: envuelve Firebase Authentication (registro, login, logout).
- `Models/BaseDatosManager.swift`: guarda cada solicitud confirmada en Firestore.
- `Models/NotificacionesManager.swift`: centraliza la programación de notificaciones locales.
- `Extensions/UITextField+Ojito.swift`: botón reutilizable de mostrar/ocultar contraseña.

## Cómo correrlo

1. Clona el repositorio.
2. Abre `ServiClimasApp.xcodeproj` en Xcode.
3. Selecciona un simulador de iPhone y presiona ▶️ (⌘R).

El proyecto ya incluye `GoogleService-Info.plist` conectado a un proyecto de Firebase de desarrollo. Para producción, se recomienda ajustar las reglas de seguridad de Firestore (actualmente en modo de prueba) antes de publicar la app.
