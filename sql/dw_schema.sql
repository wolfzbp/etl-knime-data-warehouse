-- Crear base de datos DW
DROP DATABASE IF EXISTS dw_retail;
CREATE DATABASE dw_retail;

-- Conectarse a la base
\c dw_retail;

-- =========================
-- DIMENSIONES
-- =========================

CREATE TABLE dim_cliente (
    sk_cliente SERIAL PRIMARY KEY,
    id_cliente INT,
    nombre VARCHAR(100),
    apellido VARCHAR(100),
    ciudad VARCHAR(100),
    provincia VARCHAR(100),
    segmento VARCHAR(50),
    edad INT,
    genero VARCHAR(20)
);

CREATE TABLE dim_producto (
    sk_producto SERIAL PRIMARY KEY,
    id_producto INT,
    nombre_producto VARCHAR(150),
    categoria VARCHAR(100),
    subcategoria VARCHAR(100),
    marca VARCHAR(100),
    precio_lista NUMERIC(10,2),
    costo_unitario NUMERIC(10,2)
);

CREATE TABLE dim_tienda (
    sk_tienda SERIAL PRIMARY KEY,
    id_tienda INT,
    nombre_tienda VARCHAR(150),
    ciudad VARCHAR(100),
    provincia VARCHAR(100),
    region VARCHAR(50),
    tipo_tienda VARCHAR(50),
    rating NUMERIC(3,1)
);

CREATE TABLE dim_empleado (
    sk_empleado SERIAL PRIMARY KEY,
    id_empleado INT,
    nombre_empleado VARCHAR(150),
    cargo VARCHAR(100)
);

CREATE TABLE dim_tiempo (
    sk_tiempo SERIAL PRIMARY KEY,
    fecha DATE,
    anio INT,
    mes INT,
    dia INT
);

-- =========================
-- TABLA DE HECHOS
-- =========================

CREATE TABLE fact_ventas (
    id_fact SERIAL PRIMARY KEY,

    sk_cliente INT,
    sk_producto INT,
    sk_tienda INT,
    sk_empleado INT,
    sk_tiempo INT,

    cantidad INT,
    precio_unitario NUMERIC(10,2),
    descuento NUMERIC(10,2),
    venta_bruta NUMERIC(12,2),
    venta_neta NUMERIC(12,2),
    costo_total NUMERIC(12,2),
    utilidad NUMERIC(12,2),
    CONSTRAINT fk_fact_cliente FOREIGN KEY (sk_cliente) REFERENCES dim_cliente(sk_cliente),
    CONSTRAINT fk_fact_producto FOREIGN KEY (sk_producto) REFERENCES dim_producto(sk_producto),
    CONSTRAINT fk_fact_tienda FOREIGN KEY (sk_tienda) REFERENCES dim_tienda(sk_tienda),
    CONSTRAINT fk_fact_empleado FOREIGN KEY (sk_empleado) REFERENCES dim_empleado(sk_empleado),
    CONSTRAINT fk_fact_tiempo FOREIGN KEY (sk_tiempo) REFERENCES dim_tiempo(sk_tiempo)
);