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
