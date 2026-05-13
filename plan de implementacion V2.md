Este es un plan de implementación profesional y robusto para el proyecto **Caffenio**, utilizando **Flutter** como framework multiplataforma (Android, iOS, Web, Windows).

Antes de proceder con el código, he refinado la arquitectura basándome en tus entidades para asegurar que el sistema sea escalable, mantenible y siga los estándares de desarrollo actuales.

---

### 1. Arquitectura del Sistema: "Clean Architecture"

Para un proyecto de esta magnitud, utilizaremos una arquitectura de capas que separe la lógica de negocio de la interfaz de usuario:

* **Data Layer:** Repositorios, Modelos (Data Transfer Objects - DTOs) y Data Sources (conexión a la API/BD).
* **Domain Layer:** Entidades (objetos de negocio puros) y Use Cases (lógica específica: `RealizarPedido`, `ActualizarInventario`).
* **Presentation Layer:** Widgets (UI) y Manejo de Estado (Bloc o Provider).

---

### 2. Plan de Implementación Refinado (Fases)

#### Fase 1: Base de Datos y Backend (Core)

Dado que usaremos Flutter, necesitamos un backend para orquestar estas tablas.

* **Estandarización:** Creación del script DDL basado en tus tablas (MySQL/PostgreSQL).
* **Integridad:** Implementación de Triggers para la actualización automática de la tabla `Inventario` cuando un `Pedido` cambie a estado 'listo'.
* **API REST:** Desarrollo de endpoints para cada entidad (CRUD de Productos, Gestión de Clientes y Fidelización).

#### Fase 2: Estructura Flutter (Multiplataforma)

* **Gestión de Estado:** Uso de `flutter_bloc` para manejar la complejidad de los pedidos en tiempo real.
* **Persistencia Local:** `sqflite` (para móviles) o `drift` (multiplataforma) para permitir el modo offline en sucursales con mala conexión.
* **Diseño (UI/UX):** Implementación de un sistema de temas que respete la identidad visual de Caffenio (Colores café, crema y acentos rojos).

#### Fase 3: Módulos Críticos

1. **Módulo de Ventas (POS):** Interfaz optimizada para Windows/Web (cajeros) y Android/iOS (clientes).
2. **Módulo de Inventario:** Alertas de `stock_minimo` basadas en tu entidad `Inventario`.
3. **Módulo de Lealtad:** Cálculo automático de puntos en la entidad `TarjetaLealtad` tras cada `Pago` exitoso.

---

### 3. Matriz de Entidades y Modelado de Datos (Revisada)

He organizado tus entidades en grupos lógicos para la implementación en el código:

| Grupo | Entidades | Notas de Implementación |
| --- | --- | --- |
| **Catálogo** | Producto, Categoria, Ingrediente | Se cargan al inicio y se mantienen en caché (Memory Cache). |
| **Operaciones** | Pedido, DetallePedido, Personalizacion | Requiere validación de stock en tiempo real antes de confirmar. |
| **Logística** | Sucursal, Inventario, OrdenCompra | Sincronización periódica con el servidor central. |
| **Fidelización** | Cliente, TarjetaLealtad | Encriptación de datos sensibles de contacto. |
| **RRHH** | Empleado, Turno | Control de acceso basado en roles (`barista`, `gerente`). |

---

### 4. Propuesta de Estructura de Proyecto (Repositorio)

Para mantener el estándar profesional, la estructura en tu repositorio debería verse así:

```text
lib/
├── core/               # Utilidades, temas, constantes
├── data/
│   ├── models/         # Modelos que extienden tus tablas (fromJSON/toJSON)
│   ├── repositories/   # Implementación de la comunicación con BD/API
│   └── datasources/    # Clientes de red o base de datos local
├── domain/
│   ├── entities/       # Las clases puras (Producto, Cliente, etc.)
│   └── usecases/       # Lógica de negocio (Ej: AplicarDescuentoUseCase)
├── presentation/
│   ├── bloc/           # Lógica de estado
│   ├── pages/          # Pantallas (Venta, Inventario, Perfil)
│   └── widgets/        # Componentes reutilizables
└── main.dart           # Punto de entrada multiplataforma

```

---

### 5. Siguiente Paso: Generación de Documentación y Script

Para asegurar que el desarrollo sea fluido, voy a generar el documento maestro de arquitectura.

**¿Deseas que genere ahora el script DDL (`bdcaffenio.sql`) completo con todas las relaciones y restricciones, o prefieres que empiece con la creación de los Modelos en Dart (Flutter) para estas entidades?**

Dependencias: 1 flutter_bloc
2 get_it
3 equatable
4 dio
5 retrofit
6 json_annotation
7 drift
8 sqlite3_flutter_libs
9 path_provider
10 path
11 shared_preferences
12 intl
13 decimal
14 logger
15 google_fonts
16 flutter_svg
17 connectivity_plus
18 font_awesome_flutter

sql mejorado:

-- 1. Categoria
CREATE TABLE Categoria (
    categoria_id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL
);

-- 2. Producto
CREATE TABLE Producto (
    producto_id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT,
    precio DECIMAL(10,2) NOT NULL,
    disponible BOOLEAN DEFAULT TRUE,
    categoria_id INT,
    FOREIGN KEY (categoria_id) REFERENCES Categoria(categoria_id)
);

-- 3. Ingrediente
CREATE TABLE Ingrediente (
    ingrediente_id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    unidad_medida VARCHAR(50) NOT NULL,
    stock DECIMAL(10,2) DEFAULT 0.00
);

-- 4. Receta
CREATE TABLE Receta (
    receta_id INT AUTO_INCREMENT PRIMARY KEY,
    producto_id INT,
    ingrediente_id INT,
    cantidad DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (producto_id) REFERENCES Producto(producto_id),
    FOREIGN KEY (ingrediente_id) REFERENCES Ingrediente(ingrediente_id)
);

-- 5. Cliente
CREATE TABLE Cliente (
    cliente_id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(150) NOT NULL,
    contacto VARCHAR(150),
    fecha_registro DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- 6. TarjetaLealtad
CREATE TABLE TarjetaLealtad (
    tarjeta_id INT AUTO_INCREMENT PRIMARY KEY,
    cliente_id INT,
    puntos INT DEFAULT 0,
    fecha_ultima_actualizacion DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (cliente_id) REFERENCES Cliente(cliente_id)
);

-- 7. Sucursal
CREATE TABLE Sucursal (
    sucursal_id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    ubicacion VARCHAR(200),
    horario VARCHAR(100),
    telefono VARCHAR(20),
    capacidad INT
);

-- 8. Pedido
CREATE TABLE Pedido (
    pedido_id INT AUTO_INCREMENT PRIMARY KEY,
    cliente_id INT,
    sucursal_id INT,
    fecha DATETIME DEFAULT CURRENT_TIMESTAMP,
    total DECIMAL(10,2) NOT NULL,
    estado ENUM('pendiente', 'listo', 'entregado', 'cancelado') DEFAULT 'pendiente',
    FOREIGN KEY (cliente_id) REFERENCES Cliente(cliente_id),
    FOREIGN KEY (sucursal_id) REFERENCES Sucursal(sucursal_id)
);

-- 9. DetallePedido
CREATE TABLE DetallePedido (
    detalle_id INT AUTO_INCREMENT PRIMARY KEY,
    pedido_id INT,
    producto_id INT,
    cantidad INT NOT NULL,
    precio_unitario DECIMAL(10,2) NOT NULL,
    subtotal DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (pedido_id) REFERENCES Pedido(pedido_id),
    FOREIGN KEY (producto_id) REFERENCES Producto(producto_id)
);

-- 10. Personalizacion
CREATE TABLE Personalizacion (
    personalizacion_id INT AUTO_INCREMENT PRIMARY KEY,
    detalle_id INT,
    tipo VARCHAR(50),
    valor VARCHAR(100),
    FOREIGN KEY (detalle_id) REFERENCES DetallePedido(detalle_id)
);

-- 11. Pago
CREATE TABLE Pago (
    pago_id INT AUTO_INCREMENT PRIMARY KEY,
    pedido_id INT,
    metodo ENUM('efectivo', 'tarjeta', 'app') NOT NULL,
    monto DECIMAL(10,2) NOT NULL,
    referencia VARCHAR(100),
    fecha DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (pedido_id) REFERENCES Pedido(pedido_id)
);

-- 12. Descuento
CREATE TABLE Descuento (
    descuento_id INT AUTO_INCREMENT PRIMARY KEY,
    codigo VARCHAR(50) UNIQUE,
    descripcion VARCHAR(200),
    tipo ENUM('porcentaje', 'monto', 'combo'),
    valor DECIMAL(10,2) NOT NULL,
    fecha_inicio DATE,
    fecha_fin DATE
);

-- 13. Empleado
CREATE TABLE Empleado (
    empleado_id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(150) NOT NULL,
    rol ENUM('barista', 'cajero', 'gerente', 'otro'),
    sucursal_id INT,
    fecha_contratacion DATE,
    FOREIGN KEY (sucursal_id) REFERENCES Sucursal(sucursal_id)
);

-- 14. Turno
CREATE TABLE Turno (
    turno_id INT AUTO_INCREMENT PRIMARY KEY,
    empleado_id INT,
    sucursal_id INT,
    fecha DATE NOT NULL,
    hora_inicio TIME,
    hora_fin TIME,
    FOREIGN KEY (empleado_id) REFERENCES Empleado(empleado_id),
    FOREIGN KEY (sucursal_id) REFERENCES Sucursal(sucursal_id)
);

-- 15. Inventario
CREATE TABLE Inventario (
    inventario_id INT AUTO_INCREMENT PRIMARY KEY,
    sucursal_id INT,
    ingrediente_id INT,
    stock_actual DECIMAL(10,2) DEFAULT 0.00,
    stock_minimo DECIMAL(10,2) DEFAULT 0.00,
    FOREIGN KEY (sucursal_id) REFERENCES Sucursal(sucursal_id),
    FOREIGN KEY (ingrediente_id) REFERENCES Ingrediente(ingrediente_id)
);

-- 16. Proveedor
CREATE TABLE Proveedor (
    proveedor_id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(150) NOT NULL,
    contacto VARCHAR(150),
    telefono VARCHAR(20)
);

-- 17. OrdenCompra
CREATE TABLE OrdenCompra (
    orden_id INT AUTO_INCREMENT PRIMARY KEY,
    proveedor_id INT,
    sucursal_id INT,
    fecha DATE DEFAULT (CURRENT_DATE),
    estado ENUM('pendiente', 'recibida', 'cancelada') DEFAULT 'pendiente',
    FOREIGN KEY (proveedor_id) REFERENCES Proveedor(proveedor_id),
    FOREIGN KEY (sucursal_id) REFERENCES Sucursal(sucursal_id)
);

-- 18. DetalleOrdenCompra
CREATE TABLE DetalleOrdenCompra (
    detalle_id INT AUTO_INCREMENT PRIMARY KEY,
    orden_id INT,
    ingrediente_id INT,
    cantidad DECIMAL(10,2) NOT NULL,
    precio_unitario DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (orden_id) REFERENCES OrdenCompra(orden_id),
    FOREIGN KEY (ingrediente_id) REFERENCES Ingrediente(ingrediente_id)
);


