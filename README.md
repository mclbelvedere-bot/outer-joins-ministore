# MiniStore - Auditoría de Inventario y Ventas con SQL Outer JOINs

Este repositorio contiene la solución técnica al caso práctico de auditoría de datos para MiniStore, enfocado en la detección de productos sin rotación y transacciones huérfanas mediante combinaciones externas (LEFT JOIN, RIGHT JOIN y FULL OUTER JOIN).

---

## Justificaciones Técnicas y Preguntas de Negocio

### 1. ¿Por qué usamos LEFT JOIN para la Consulta 1 y no INNER JOIN?
Se utilizó LEFT JOIN definiendo la tabla productos en la cláusula FROM (lado izquierdo) para preservar la totalidad de los registros del catálogo maestro. 
* Si hubiésemos utilizado un INNER JOIN, el motor de la base de datos habría descartado automáticamente cualquier producto que no registrara coincidencias en la tabla ventas.
* Al usar LEFT JOIN en combinación con la cláusula WHERE v.venta_id IS NULL, logramos aislar los productos 108 (Hub USB-C 7p) y 109 (Parlante Bluetooth), los cuales representan stock sin movimiento dentro del catálogo.

---

### 2. ¿Por qué usamos RIGHT JOIN para la Consulta 2 y cuál es la posición de las tablas?
En la Consulta 2, la tabla productos se ubica a la izquierda (FROM productos) y la tabla ventas a la derecha (RIGHT JOIN ventas).
* El objetivo técnico es auditar la integridad referencial de la tabla transaccional de ventas.
* El RIGHT JOIN prioriza y conserva el 100% de los registros transaccionales de la tabla derecha (ventas), completando con valores NULL los datos de catálogo si no existe correspondencia en la tabla izquierda.
* Esta estructura permitió aislar la venta_id = 10 (asociada al producto_id = 999), detectando una transacción huérfana dentro del sistema por un posible error en la carga de datos.

---

### 3. Representación de los Valores NULL en cada resultado
Un valor NULL representa la ausencia de correspondencia relacional entre ambas tablas:
* En la Consulta 1 (v.venta_id IS NULL): Indica que el producto existe en la tabla maestra de productos, pero no registra ninguna transacción asociada en la tabla de ventas.
* En la Consulta 2 (p.producto_id IS NULL): Indica que existe un registro de venta en el sistema, pero su código de producto (producto_id = 999) no figura registrado en el catálogo maestro.

---

### 4. ¿Cuándo usarías FULL OUTER JOIN en un caso real de negocio?
El FULL OUTER JOIN se utiliza en auditorías integrales de datos, procesos de migración entre sistemas o reconciliaciones contables. Permite obtener una vista unificada de dos tablas sin perder registros de ningún extremo, facilitando la identificación simultánea de inconsistencias en ambas direcciones: elementos no consumidos y consumo de elementos no registrados.
