-- ── CONSULTA 1: LEFT JOIN ─────────────────
-- Pregunta de negocio: ¿Qué productos del catálogo nunca fueron vendidos?
-- Conserva el catálogo completo (tabla izquierda) y filtra aquellos cuyo venta_id sea NULL.

SELECT 
    p.producto_id,
    p.nombre AS producto,
    p.categoria,
    p.precio,
    v.venta_id,
    v.fecha_venta
FROM productos p
LEFT JOIN ventas v ON p.producto_id = v.producto_id
WHERE v.venta_id IS NULL;


-- ── CONSULTA 2: RIGHT JOIN ────────────────
-- Pregunta de negocio: ¿Existen ventas registradas con productos que no figuran en nuestro catálogo?
-- Conserva todas las transacciones de ventas (tabla derecha) y aísla los registros huérfanos sin coincidencia en catálogo.

SELECT 
    v.venta_id,
    v.producto_id AS venta_producto_id,
    v.cliente_id,
    v.cantidad,
    v.fecha_venta,
    p.nombre AS producto_catalogo
FROM productos p
RIGHT JOIN ventas v ON p.producto_id = v.producto_id
WHERE p.producto_id IS NULL;


-- ── CONSULTA 3: FULL OUTER JOIN ───────────
-- Pregunta de negocio: Vista completa de auditoría que muestra todos los productos y todas las ventas
-- sin perder ninguna fila, identificando tanto productos sin ventas como ventas sin producto.

SELECT 
    p.producto_id AS catálogo_producto_id,
    p.nombre AS producto,
    p.categoria,
    v.venta_id,
    v.producto_id AS venta_producto_id,
    v.cantidad,
    v.fecha_venta
FROM productos p
FULL OUTER JOIN ventas v ON p.producto_id = v.producto_id
ORDER BY p.producto_id, v.venta_id;
