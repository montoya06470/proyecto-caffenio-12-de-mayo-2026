Prompt: 
actua como un administrador de base de datos; proyecto cafeteria (Caffenio), que entidades se necesitan para su gestion?

## Entidades para el Sistema de Gestión de Cafetería (Caffenio)

<img width="1536" height="1024" alt="Copilot_20260512_083124" src="https://github.com/user-attachments/assets/e05b3c75-3823-48db-b0dc-63213ab90fcc" />


Como DBA, estas son las entidades principales que necesitarías modelar:

---

### 🧾 核心 del Negocio

**1. Producto**
Café, bebidas, alimentos — con nombre, descripción, precio, categoría, disponibilidad.

**2. Categoría**
Bebidas calientes, frías, snacks, postres, etc.

**3. Ingrediente**
Insumos base: granos de café, leche, jarabe, etc. — con stock y unidad de medida.

**4. Receta / ProductoIngrediente**
Relación entre producto e ingredientes (cuánto de cada ingrediente usa cada producto).

---

### 👤 Clientes y Fidelización

**5. Cliente**
Nombre, contacto, programa de lealtad, historial de compras.

**6. TarjetaLealtad / Puntos**
Acumulación y canje de puntos por compra.

---

### 🛒 Operaciones

**7. Pedido**
Encabezado de la orden: cliente, fecha, sucursal, total, estado (pendiente/listo/entregado).

**8. DetallePedido**
Líneas del pedido: producto, cantidad, precio unitario, personalizaciones.

**9. Personalización**
Opciones como tamaño, tipo de leche, shots extra, temperatura, azúcar.

---

### 💳 Pagos

**10. Pago**
Método (efectivo, tarjeta, app), monto, referencia, fecha.

**11. Descuento / Promoción**
Cupones, combos, descuentos por temporada o membresía.

---

### 🏪 Infraestructura

**12. Sucursal**
Ubicación, horario, teléfono, capacidad.

**13. Empleado**
Datos del staff: rol (barista, cajero, gerente), sucursal asignada.

**14. Turno**
Control de horarios del personal por sucursal.

---

### 📦 Inventario y Proveedores

**15. Inventario**
Stock actual de cada ingrediente por sucursal.

**16. Proveedor**
Datos de proveedores de insumos.

**17. OrdenCompra / DetalleOrdenCompra**
Reabastecimiento de ingredientes.

---

### 📊 Resumen del modelo

```
Sucursal ──< Empleado
Sucursal ──< Inventario >── Ingrediente
Sucursal ──< Pedido >── DetallePedido >── Producto
                                          Producto >── Receta >── Ingrediente
                                          Producto >── Categoría
Pedido ──< Pago
Pedido ── Cliente ── TarjetaLealtad
DetallePedido >── Personalización
```

---

¿Quieres que profundice en alguna entidad, defina los atributos completos con tipos de datos, diseñe el DDL en SQL, o modele el diagrama ER?

Prompt 2: 
ahora dame las entidades con sus atributos y tipo en forma de tabla para cada una de las entidades

<img width="549" height="239" alt="image" src="https://github.com/user-attachments/assets/842440c9-d024-4bc9-b6d2-edf11063b22d" />
<img width="436" height="219" alt="image" src="https://github.com/user-attachments/assets/d0205719-ddb9-4c60-aace-8facbaf10200" />
<img width="210" height="145" alt="image" src="https://github.com/user-attachments/assets/037f065e-c238-46f2-a0ce-6b9d00caf02d" />
<img width="436" height="179" alt="image" src="https://github.com/user-attachments/assets/f259ebe8-d85c-43bd-9e17-28381910f953" />
<img width="433" height="134" alt="image" src="https://github.com/user-attachments/assets/26223d96-f777-4cb0-b55d-9a376ee44d7d" />
<img width="432" height="229" alt="image" src="https://github.com/user-attachments/assets/17516d14-ea9f-4212-a4f8-291730f64e4e" />
<img width="215" height="180" alt="image" src="https://github.com/user-attachments/assets/822acab3-42e3-41a3-8a81-cfd99f2aacd8" />
<img width="434" height="184" alt="image" src="https://github.com/user-attachments/assets/a0f3ab63-f07d-496f-b292-1f071d0ecbd5" />
<img width="431" height="183" alt="image" src="https://github.com/user-attachments/assets/3aa1ad4b-b593-42e2-97b2-3d1aa0d4074d" />
<img width="427" height="189" alt="image" src="https://github.com/user-attachments/assets/a95007a5-0051-4c63-93c0-baff20c774ed" />

Prompt 3;
de acuerdo a tu respuesta anterior puedes generar un script en sql para descargar con el nombre de bdcaffenio.sql para toas las entiades con sus relaciones

-- bdcaffenio.sql
-- Base de datos Caffenio (DDL para MySQL / MariaDB)
CREATE DATABASE IF NOT EXISTS bdcaffenio CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE bdcaffenio;

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
    precio DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    disponible BOOLEAN NOT NULL DEFAULT TRUE,
    categoria_id INT,
    CONSTRAINT fk_producto_categoria FOREIGN KEY (categoria_id) REFERENCES Categoria(categoria_id)
);

-- 3. Ingrediente
CREATE TABLE Ingrediente (
    ingrediente_id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    unidad_medida VARCHAR(50),
    stock DECIMAL(10,2) NOT NULL DEFAULT 0.00
);

-- 4. Receta (ProductoIngrediente)
CREATE TABLE Receta (
    receta_id INT AUTO_INCREMENT PRIMARY KEY,
    producto_id INT NOT NULL,
    ingrediente_id INT NOT NULL,
    cantidad DECIMAL(10,2) NOT NULL,
    CONSTRAINT fk_receta_producto FOREIGN KEY (producto_id) REFERENCES Producto(producto_id),
    CONSTRAINT fk_receta_ingrediente FOREIGN KEY (ingrediente_id) REFERENCES Ingrediente(ingrediente_id)
);

-- 5. Cliente
CREATE TABLE Cliente (
    cliente_id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(150),
    contacto VARCHAR(150),
    fecha_registro DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- 6. TarjetaLealtad
CREATE TABLE TarjetaLealtad (
    tarjeta_id INT AUTO_INCREMENT PRIMARY KEY,
    cliente_id INT NOT NULL,
    puntos INT NOT NULL DEFAULT 0,
    fecha_ultima_actualizacion DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT fk_tarjeta_cliente FOREIGN KEY (cliente_id) REFERENCES Cliente(cliente_id)
);

-- 7. Sucursal
CREATE TABLE Sucursal (
    sucursal_id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100),
    ubicacion VARCHAR(200),
    horario VARCHAR(100),
    telefono VARCHAR(20),
    capacidad INT
);

-- 8. Empleado
CREATE TABLE Empleado (
    empleado_id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(150) NOT NULL,
    rol ENUM('barista','cajero','gerente','otro') NOT NULL DEFAULT 'barista',
    sucursal_id INT,
    fecha_contratacion DATE,
    CONSTRAINT fk_empleado_sucursal FOREIGN KEY (sucursal_id) REFERENCES Sucursal(sucursal_id)
);

-- 9. Turno
CREATE TABLE Turno (
    turno_id INT AUTO_INCREMENT PRIMARY KEY,
    empleado_id INT NOT NULL,
    sucursal_id INT NOT NULL,
    fecha DATE NOT NULL,
    hora_inicio TIME,
    hora_fin TIME,
    CONSTRAINT fk_turno_empleado FOREIGN KEY (empleado_id) REFERENCES Empleado(empleado_id),
    CONSTRAINT fk_turno_sucursal FOREIGN KEY (sucursal_id) REFERENCES Sucursal(sucursal_id)
);

-- 10. Inventario
CREATE TABLE Inventario (
    inventario_id INT AUTO_INCREMENT PRIMARY KEY,
    sucursal_id INT NOT NULL,
    ingrediente_id INT NOT NULL,
    stock_actual DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    stock_minimo DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    CONSTRAINT fk_inventario_sucursal FOREIGN KEY (sucursal_id) REFERENCES Sucursal(sucursal_id),
    CONSTRAINT fk_inventario_ingrediente FOREIGN KEY (ingrediente_id) REFERENCES Ingrediente(ingrediente_id),
    UNIQUE KEY ux_inventario_sucursal_ingrediente (sucursal_id, ingrediente_id)
);

-- 11. Pedido
CREATE TABLE Pedido (
    pedido_id INT AUTO_INCREMENT PRIMARY KEY,
    cliente_id INT,
    sucursal_id INT,
    fecha DATETIME DEFAULT CURRENT_TIMESTAMP,
    total DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    estado ENUM('pendiente','listo','entregado','cancelado') NOT NULL DEFAULT 'pendiente',
    CONSTRAINT fk_pedido_cliente FOREIGN KEY (cliente_id) REFERENCES Cliente(cliente_id),
    CONSTRAINT fk_pedido_sucursal FOREIGN KEY (sucursal_id) REFERENCES Sucursal(sucursal_id)
);

-- 12. DetallePedido
CREATE TABLE DetallePedido (
    detalle_id INT AUTO_INCREMENT PRIMARY KEY,
    pedido_id INT NOT NULL,
    producto_id INT NOT NULL,
    cantidad INT NOT NULL DEFAULT 1,
    precio_unitario DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    subtotal DECIMAL(10,2) AS (cantidad * precio_unitario) STORED,
    CONSTRAINT fk_detalle_pedido_pedido FOREIGN KEY (pedido_id) REFERENCES Pedido(pedido_id),
    CONSTRAINT fk_detalle_pedido_producto FOREIGN KEY (producto_id) REFERENCES Producto(producto_id)
);

-- 13. Personalizacion
CREATE TABLE Personalizacion (
    personalizacion_id INT AUTO_INCREMENT PRIMARY KEY,
    detalle_id INT NOT NULL,
    tipo VARCHAR(50),
    valor VARCHAR(100),
    CONSTRAINT fk_personalizacion_detalle FOREIGN KEY (detalle_id) REFERENCES DetallePedido(detalle_id)
);

-- 14. Pago
CREATE TABLE Pago (
    pago_id INT AUTO_INCREMENT PRIMARY KEY,
    pedido_id INT NOT NULL,
    metodo ENUM('efectivo','tarjeta','app') NOT NULL,
    monto DECIMAL(10,2) NOT NULL,
    referencia VARCHAR(100),
    fecha DATETIME DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_pago_pedido FOREIGN KEY (pedido_id) REFERENCES Pedido(pedido_id)
);

-- 15. Descuento / Promocion
CREATE TABLE Descuento (
    descuento_id INT AUTO_INCREMENT PRIMARY KEY,
    codigo VARCHAR(50) UNIQUE,
    descripcion VARCHAR(200),
    tipo ENUM('porcentaje','monto','combo') NOT NULL,
    valor DECIMAL(10,2) NOT NULL,
    fecha_inicio DATE,
    fecha_fin DATE
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
    proveedor_id INT NOT NULL,
    sucursal_id INT NOT NULL,
    fecha DATE DEFAULT CURRENT_DATE,
    estado ENUM('pendiente','recibida','cancelada') NOT NULL DEFAULT 'pendiente',
    CONSTRAINT fk_orden_proveedor FOREIGN KEY (proveedor_id) REFERENCES Proveedor(proveedor_id),
    CONSTRAINT fk_orden_sucursal FOREIGN KEY (sucursal_id) REFERENCES Sucursal(sucursal_id)
);

-- 18. DetalleOrdenCompra
CREATE TABLE DetalleOrdenCompra (
    detalle_id INT AUTO_INCREMENT PRIMARY KEY,
    orden_id INT NOT NULL,
    ingrediente_id INT NOT NULL,
    cantidad DECIMAL(10,2) NOT NULL,
    precio_unitario DECIMAL(10,2),
    CONSTRAINT fk_detalleorden_orden FOREIGN KEY (orden_id) REFERENCES OrdenCompra(orden_id),
    CONSTRAINT fk_detalleorden_ingrediente FOREIGN KEY (ingrediente_id) REFERENCES Ingrediente(ingrediente_id)
);

-- Índices recomendados (ejemplos)
CREATE INDEX idx_producto_categoria ON Producto(categoria_id);
CREATE INDEX idx_pedido_cliente ON Pedido(cliente_id);
CREATE INDEX idx_inventario_ingrediente ON Inventario(ingrediente_id);
CREATE INDEX idx_receta_producto ON Receta(producto_id);

