actua como un creador de software, quiero crear una aplicacion multiplataforma en flutter dart y firebase utilizando vs code o Antigravity, que herramientas se requieren, ui, ux, dependencias, login, autenticacion, usuario, password, base de datos en firestore provider, dependencias en pubspecyaml, antes de que proporciones codigo, quiero crear un plan de implementacion en formato markdown, para desarrollar la aplicacion "Caffenio", no codigo, procedimiento paso a paso para el desarrollo

# 📋 Plan de Implementación: Aplicación "Caffenio"
**Stack:** Flutter + Dart + Firebase + Provider + VS Code  
**Objetivo:** Documento maestro de planificación paso a paso. Sin código. Solo arquitectura, flujo y decisiones técnicas.

---

## 🔹 Fase 0: Definición de Alcance y Requisitos de "Caffenio"
1. **Identificar propósito principal:** (ej. catálogo de café, pedidos, fidelización, comunidad, gestión de inventario).
2. **Definir roles de usuario:** `Invitado`, `Registrado`, `Administrador` (si aplica).
3. **Listar funcionalidades MVP:**
   - Registro e inicio de sesión con correo/contraseña.
   - Perfil de usuario editable.
   - Navegación principal (Home, Catálogo, Perfil, Historial, Configuración).
   - Operaciones CRUD básicas sobre documentos en Firestore.
4. **Establecer entregables por fase** y criterios de aceptación.
5. **Crear repositorio Git** con ramas: `main`, `develop`, `feature/*`, `release/*`.

---

## 🔹 Fase 1: Configuración del Entorno y Herramientas
1. **Instalar SDKs:**
   - Flutter SDK (última versión estable).
   - Dart SDK (incluido con Flutter).
   - Node.js (opcional, para Firebase CLI y herramientas auxiliares).
2. **Configurar VS Code:**
   - Extensiones obligatorias: `Flutter`, `Dart`, `Firebase`, `GitLens`, `Error Lens`, `Pubspec Assist`.
   - Configurar formateador automático y linter (`flutter analyze`).
   - Activar emuladores Android/iOS o habilitar dispositivo físico.
3. **Instalar Firebase CLI:**
   - `npm install -g firebase-tools`
   - Autenticar CLI: `firebase login`
   - Inicializar proyecto: `firebase init` (solo para configuración de reglas/functions si se requieren).
4. **Verificar entorno:** `flutter doctor`, `dart --version`, `flutter run` (proyecto vacío).

---

## 🔹 Fase 2: Arquitectura y Estructura del Proyecto
1. **Patrones adoptados:**
   - **Feature-first** + **Clean-ish layers** (`presentation`, `domain`, `data`).
   - **State Management:** `provider` con `ChangeNotifier` y `MultiProvider`.
   - **Navegación:** Declarativa con enrutamiento centralizado.
2. **Estructura de carpetas sugerida:**
   ```
   lib/
   ├── core/           (constantes, temas, utilidades, errores personalizados)
   ├── features/       (módulos independientes: auth, profile, catalog, etc.)
   ├── shared/         (widgets reutilizables, servicios globales)
   ├── providers/      (ChangeNotifiers para estado global y local)
   └── main.dart       (punto de entrada, inicialización de Firebase y Providers)
   ```
3. **Convenciones:**
   - Archivos `.dart` en `snake_case`.
   - Clases en `PascalCase`.
   - Widgets privados con `_` si no se exportan.
   - Separación estricta entre UI y lógica de negocio.

---

## 🔹 Fase 3: Diseño UI/UX
1. **Investigación y Referencias:**
   - Benchmark de apps de café/cafeterías.
   - Definir paleta de colores, tipografía, iconografía y espaciado.
2. **Wireframing y Prototipado:**
   - Herramienta recomendada: Figma o Penpot.
   - Crear flujos: `Onboarding → Login → Registro → Home → Perfil → Configuración`.
   - Definir estados: `empty`, `loading`, `error`, `success`.
3. **Sistema de Diseño en Flutter:**
   - Configurar `ThemeData` (light/dark).
   - Crear archivo de estilos globales (`core/theme/app_theme.dart`).
   - Definir tokens de diseño: radios, sombras, elevaciones, breakpoints.
4. **Validación UX:**
   - Navegación ≤ 3 toques para acciones principales.
   - Feedback inmediato en formularios y acciones asíncronas.
   - Accesibilidad: contraste, tamaños de fuente escalables, semántica.

---

## 🔹 Fase 4: Gestión de Dependencias (`pubspec.yaml`)
1. **Principios de gestión:**
   - Usar versiones estables (`^x.y.z`).
   - Evitar dependencias en desuso o con baja mantención.
   - Documentar propósito de cada paquete en comentarios.
2. **Categorías de paquetes:**
   - **Core:** Flutter, íconos.
   - **Firebase:** Inicialización, Auth, Firestore, Storage (si aplica).
   - **Estado:** `provider`.
   - **Navegación & Rutas:** `go_router` o `auto_route`.
   - **UI & Utilidades:** `intl`, `cached_network_image`, `formz`/`flutter_form_builder`, `flutter_native_splash`, `flutter_launcher_icons`.
   - **Persistencia Local:** `shared_preferences` o `hive` (para settings/tema).
   - **Desarrollo:** `flutter_lints`, `mockito` (para tests).
3. **Procedimiento de adición:**
   - `flutter pub add <paquete>`
   - Ejecutar `flutter pub get`
   - Verificar compatibilidad con versión de Flutter (`flutter pub outdated`).
4. **Nota:** Se evitará incluir código en esta fase. Solo se definirá la lista y su propósito técnico.

---

## 🔹 Fase 5: Integración de Firebase
1. **Crear proyecto en Firebase Console:**
   - Habilitar `Authentication` (método Email/Password).
   - Habilitar `Cloud Firestore` (modo producción o test según necesidad).
   - Configurar `Storage` (si se requieren imágenes de perfil/productos).
2. **Generar configuración por plataforma:**
   - Android: `google-services.json`
   - iOS: `GoogleService-Info.plist`
   - Web: objeto `firebaseConfig` (si aplica)
3. **Inicialización en la app:**
   - Colocar archivos de configuración en rutas correctas.
   - Llamar a `Firebase.initializeApp()` antes de ejecutar cualquier widget.
   - Configurar manejo de errores de inicialización.
4. **Seguridad inicial:**
   - Definir reglas básicas de Firestore (lectura/escritura por usuario autenticado).
   - Validar que Auth requiera verificación de correo (opcional pero recomendado).

---

## 🔹 Fase 6: Sistema de Autenticación (Email/Password)
1. **Modelo de datos de sesión:**
   - Definir estructura `AuthState` (autenticado, no autenticado, cargando, error).
   - Mapear usuario de Firebase a modelo local de `Caffenio`.
2. **Provider de Autenticación:**
   - Crear `AuthProvider` que exponga métodos: `login`, `register`, `logout`, `resetPassword`, `updateProfile`.
   - Manejar persistencia de sesión automática (Firebase ya lo hace nativamente).
   - Emitir notificaciones de cambio de estado para reconstrucción de UI.
3. **Flujo de pantallas:**
   - `LoginScreen` → validación → llamada a `AuthProvider.login()` → redirección a `Home`.
   - `RegisterScreen` → validación → llamada a `AuthProvider.register()` → verificación opcional → login.
   - `ForgotPasswordScreen` → solicitud de reset → mensaje de éxito/error.
4. **Manejo de errores UX:**
   - Traducir códigos de error de Firebase (`weak-password`, `email-already-in-use`, `invalid-email`, etc.).
   - Mostrar `SnackBar` o diálogos contextualizados.
   - Evitar bloqueos de UI durante llamadas asíncronas.

---

## 🔹 Fase 7: Base de Datos Firestore + Provider
1. **Diseño del esquema Firestore:**
   - Colecciones principales: `users`, `products`, `orders`, `settings` (ajustar a alcance real de Caffenio).
   - Documentar estructura de campos, tipos, índices y relaciones.
2. **Capa de Datos (Repository/Service):**
   - Crear clase `FirestoreService` con métodos CRUD genéricos.
   - Implementar streams (`snapshots()`) para datos en tiempo real.
   - Configurar paginación y consultas optimizadas (índices compuestos si es necesario).
3. **Integración con Provider:**
   - Crear `DataProvider` o `CatalogProvider` que consuma streams.
   - Manejar estados: `loading`, `loaded`, `error`, `empty`.
   - Exponer métodos de actualización que sincronicen UI y Firestore.
4. **Persistencia Offline:**
   - Habilitar caché de Firestore en inicio de app.
   - Configurar tolerancia a desconexiones y reconciliación al reconectar.
5. **Seguridad y Validación:**
   - Validar datos antes de enviar a Firestore.
   - Reforzar reglas de seguridad (`request.auth != null`, `resource.data.owner == request.auth.uid`, etc.).

---

## 🔹 Fase 8: Desarrollo de Pantallas y Flujo de Navegación
1. **Router/Enrutamiento:**
   - Definir rutas nombradas o declarativas.
   - Implementar guards para rutas protegidas (solo accesibles si `authState.isAuthenticated`).
   - Configurar redirecciones por defecto y manejo de rutas no encontradas.
2. **Construcción modular:**
   - Cada pantalla consume su provider específico vía `context.read()` o `context.watch()`.
   - Extraer widgets complejos a archivos independientes.
   - Mantener lógica de negocio fuera del árbol de widgets.
3. **Flujo principal de Caffenio:**
   - `Splash/Init` → Verifica autenticación → `AuthFlow` o `HomeFlow`.
   - `Home` → Dashboard con acceso rápido a módulos.
   - `Profile` → Edición de datos, cierre de sesión, preferencias.
   - `Settings` → Tema, idioma, notificaciones, términos/privacidad.
4. **Estados de carga y vacíos:**
   - Implementar skeletons o spinners.
   - Pantallas `empty_state` con CTA claros.
   - Manejo de errores de red y reintento.

---

## 🔹 Fase 9: Pruebas, Optimización y Calidad
1. **Pruebas automatizadas:**
   - Unit tests para providers, repositorios y validaciones.
   - Widget tests para componentes UI críticos (formularios, listas, diálogos).
   - Integration tests para flujos completos (login → home → acción).
2. **Performance:**
   - Evitar rebuilds innecesarios (`Consumer` selectivo, `Provider` de nivel adecuado).
   - Usar `ListView.builder` / `GridView.builder`.
   - Pre-cargar imágenes y cachear assets.
3. **Linting y Formateo:**
   - Configurar `analysis_options.yaml` con `flutter_lints`.
   - Ejecutar `dart format .` y `flutter analyze` antes de cada commit.
4. **Documentación interna:**
   - Comentarios en providers y servicios complejos.
   - README con instrucciones de setup, variables de entorno y estructura.

---

## 🔹 Fase 10: Construcción y Preparación para Despliegue
1. **Assets y Branding:**
   - Generar íconos con `flutter_launcher_icons`.
   - Configurar splash screen nativo.
   - Verificar licencias de fuentes e imágenes.
2. **Build por plataforma:**
   - Android: `flutter build apk --release` / `appbundle`
   - iOS: `flutter build ipa` (requiere cuenta Apple Developer)
   - Web: `flutter build web` (si aplica)
3. **Pre-despliegue:**
   - Firmar aplicaciones.
   - Configurar metadatos (nombre, descripción, capturas, política de privacidad).
   - Validar reglas de Firebase en modo producción.
4. **CI/CD (Opcional pero recomendado):**
   - GitHub Actions para tests automáticos y builds.
   - Fastlane para despliegue a stores (si se escala).

---

## 📦 Apéndice: Dependencias Recomendadas para `pubspec.yaml`
| Categoría | Paquete | Propósito |
|----------|---------|-----------|
| Estado | `provider` | Gestión de estado reactivo |
| Firebase | `firebase_core`, `firebase_auth`, `cloud_firestore` | Backend y autenticación |
| Navegación | `go_router` | Enrutamiento declarativo y guards |
| UI/Utilidades | `intl`, `cached_network_image`, `flutter_form_builder`, `formz` | Formateo, imágenes, validación de formularios |
| Local | `shared_preferences` o `hive` | Preferencias y caché ligero |
| Branding | `flutter_native_splash`, `flutter_launcher_icons` | Splash e íconos nativos |
| Desarrollo | `flutter_lints`, `mockito`, `build_runner` | Calidad, tests y generación de código |

> ⚠️ Nota: Las versiones se seleccionarán al momento de la implementación según compatibilidad con la versión de Flutter instalada.

---

## ✅ Checklist de Validación Pre-Código
- [ ] Entorno Flutter + VS Code verificado y funcionando
- [ ] Proyecto Firebase creado con Auth y Firestore activos
- [ ] Estructura de carpetas definida y versionada en Git
- [ ] Sistema de diseño UI/UX aprobado (Figma/Penpot)
- [ ] Lista de dependencias revisada y actualizada
- [ ] Flujo de autenticación mapeado (login, registro, recovery)
- [ ] Esquema Firestore documentado y reglas de seguridad redactadas
- [ ] Estrategia de estado con Provider definida
- [ ] Criterios de prueba y calidad establecidos

---

## 📌 Próximos Pasos
1. Revisar y ajustar este plan según el alcance exacto de **Caffenio**.
2. Confirmar funcionalidades MVP y priorizar sprints.
3. Solicitar generación de código por módulo (ej. `auth_provider`, `login_screen`, `firestore_repository`, `pubspec.yaml`).
4. Iterar con revisiones de UI/UX y ajustes de arquitectura antes de implementar.

¿Deseas que profundice en alguna fase específica o que genere la estructura de carpetas y archivos vacíos como punto de partida antes de pasar al código?
