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
