CREATE TABLE public.estado (
    id_estado integer NOT NULL,
    nombre character varying NOT NULL,
    min_cp integer NOT NULL,
    max_cp integer NOT NULL
);

CREATE TABLE public.pozo (
    id_pozo integer NOT NULL,
    id_estado integer,
    FOREIGN KEY id_estado REFERENCES estado(id_estado)
    periodo date NOT NULL
);

CREATE TABLE public.produccion (
    id_produccion integer NOT NULL,
    id_pozo integer,
    FOREIGN KEY id_pozo REFERENCES pozo(id_pozo)
    tipo character varying NOT NULL,
    unidad character varying(5) NOT NULL,
    periodo date NOT NULL,
    valor numeric
);

CREATE TABLE public.distribuidora (
    id_distribuidora integer NOT NULL,
    id_estado integer,
    FOREIGN KEY id_estado REFERENCES estado(id_estado)
    id_pozo integer,
    FOREIGN KEY id_pozo REFERENCES pozo(id_pozo)
    ubicacion character varying NOT NULL,
    cp integer NOT NULL
);

CREATE TABLE public.quejas (
    id_queja integer NOT NULL PRIMARY KEY,
    id_distribuidora integer NOT NULL,
    FOREIGN KEY(id_distribuidora) REFERENCES distribuidora(id_distribuidora)
    estado character varying NOT NULL,
    anio integer NOT NULL,
);

CREATE TABLE public.ventas_internas (
    id_vi integer NOT NULL,
    id_distribuidora integer NOT NULL,
    FOREIGN KEY(id_distribuidora) REFERENCES distribuidora(id_distribuidora)
    tipo character varying NOT NULL,
    unidad character varying(5) NOT NULL,
    periodo date NOT NULL,
    valor numeric
);

CREATE TABLE public.comercio_exterior (
    id_ce integer NOT NULL,
    id_distribuidora integer NOT NULL,
    FOREIGN KEY(id_distribuidora) REFERENCES distribuidora(id_distribuidora)
    tipo character varying NOT NULL,
    unidad character varying NOT NULL,
    periodo date NOT NULL,
    movimiento character varying NOT NULL,
    valor numeric NOT NULL
);

CREATE TABLE public.productos (
    id_productos integer NOT NULL,
    id_distribuidora integer NOT NULL,
    FOREIGN KEY(id_distribuidora) REFERENCES distribuidora(id_distribuidora)
    magna boolean NOT NULL,
    premium boolean NOT NULL,
    diesel boolean NOT NULL,
    dme boolean NOT NULL
);
