Este documento presenta el proyecto de software **Caffenio**, estructurado según los principios de la ingeniería de software y detallado mediante el plan de implementación técnico.

### Proyecto: Sistema de Gestión Integral "Caffenio"

#### 1. Objetivo del Proyecto
El objetivo principal es desarrollar una solución de software multiplataforma (móvil y web) para la **gestión integral de una cadena de cafeterías**, permitiendo la interacción fluida entre clientes (pedidos y lealtad) y el personal operativo (baristas y administradores). Este proyecto busca cerrar la brecha entre las necesidades comerciales de personalización de productos y el control de inventario en tiempo real.

#### 2. Marco Teórico (Ingeniería de Software)
De acuerdo con los fundamentos de la ingeniería de software, este proyecto se define como un **producto de tres dimensiones**: programas computacionales, documentación de construcción/uso y estructuras de datos para la manipulación de información.
*   **Enfoque:** Se aplica un enfoque sistemático, disciplinado y cuantificable al desarrollo.
*   **Gestión de Proyectos:** El desarrollo sigue un ciclo de vida que incluye las etapas de **Inicio, Planificación, Ejecución, Control y Cierre**.
*   **Calidad:** Se implementa el Aseguramiento de la Calidad del Software (SQA) para garantizar que los entregables cumplan con los requisitos especificados.

#### 3. Tecnologías Utilizadas
El stack tecnológico seleccionado se basa en herramientas modernas para asegurar la escalabilidad y el rendimiento:
*   **Lenguaje:** Dart 3.x.
*   **Framework de UI:** Flutter 3.x (Android, iOS y Web).
*   **Backend as a Service (BaaS):** Firebase (Authentication, Firestore, Storage, Analytics).
*   **Gestión de Estado:** Provider.
*   **Infraestructura y CI/CD:** GitHub Actions.
*   **Base de Datos Relacional (Backups):** MySQL/MariaDB.

---

#### 4. Índice de Contenidos (Basado en el Plan de Implementación V2)
Este índice sigue la hoja de ruta técnica definida para la ejecución del proyecto:

1.  **Fase 0 — Definición de Alcance y Requisitos**
    *   Propósito y roles de usuario (Guest, Customer, Barista, Admin).
    *   Funcionalidades MVP (Autenticación, Catálogo, Carrito, Lealtad).
2.  **Fase 1 — Configuración del Entorno**
    *   Requisitos del sistema e inicialización de Flutter y Firebase CLI.
3.  **Fase 2 — Arquitectura y Estructura del Proyecto**
    *   Patrón *Feature-First Clean Architecture*.
4.  **Fase 3 — Sistema de Diseño UI/UX**
    *   Identidad visual, paleta de colores y sistema de espaciado.
5.  **Fase 4 — Dependencias**
    *   Configuración del archivo `pubspec.yaml`.
6.  **Fase 5 — Configuración de Firebase**
    *   Proyectos de desarrollo y producción; servicios de base de datos y almacenamiento.
7.  **Fase 6 — Sistema de Autenticación**
    *   Flujos de registro (Email/Password y Google) y estados de sesión.
8.  **Fase 7 — Esquema Firestore y Capa de Datos**
    *   Modelado de colecciones (Users, Products, Orders, Sucursales, Inventory).
9.  **Fase 8 — Providers y Gestión de Estado**
    *   Implementación de `MultiProvider` y lógica de negocio.
10. **Fase 9 — Pantallas y Navegación**
    *   Configuración de `GoRouter` y diseño de la interfaz de usuario.
11. **Fase 10 — Módulos Funcionales de Caffenio**
    *   Desarrollo de Catálogo, Carrito, Pedidos e Inventario.
12. **Fase 11 — Pruebas y Calidad**
    *   Pruebas unitarias, de widget e integración.
13. **Fase 12 — Construcción y Despliegue**
    *   Configuración de Ambientes (Flavors) y firma de aplicaciones.

---

#### 5. Desarrollo e Implementación
El desarrollo se rige por la **especificación de requisitos de software (ERS)**, clasificando las necesidades en funcionales y no funcionales (como el tiempo de respuesta menor a 5 segundos para registros).

*   **Arquitectura de la Solución:** Se utiliza un diseño desacoplado donde la lógica de negocio (domain) no depende de los frameworks externos.
*   **Proceso de Implementación:** Se sigue un modelo **iterativo e incremental** (ágil), permitiendo generar software funcional en plazos cortos (Sprints).
*   **Gestión de Configuración:** Se establece una **Línea Base (Baseline)** para controlar los cambios en el código fuente y la documentación a medida que el proyecto evoluciona.
*   **Control de Calidad:** Se aplican técnicas de **Caja Blanca** (camino básico) y **Caja Negra** (particiones de equivalencia) para validar la lógica y las entradas del sistema.

#### 6. Conclusiones
La implementación de Caffenio demuestra que el uso de metodologías de ingeniería de software aplicadas a problemas reales en contextos reales permite la creación de sistemas robustos y escalables. La combinación de **Flutter y Firebase** proporciona una velocidad de desarrollo óptima sin sacrificar la calidad, cumpliendo con los objetivos de negocio de modernizar la experiencia de compra en una cafetería industrial. El cumplimiento estricto de las fases del plan asegura que el producto final sea mantenible y responda a las necesidades de todos los interesados (stakeholders).
