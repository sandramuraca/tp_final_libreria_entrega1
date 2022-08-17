CREATE DATABASE IF NOT EXISTS libreria;

USE libreria;

/*creo tablas que solo tienen PK para luego crear tablas con FK asociadas*/

/*tabla 1*/
CREATE TABLE IF NOT EXISTS documento_tipo (
	documento_tipo_id INT NOT NULL UNIQUE AUTO_INCREMENT PRIMARY KEY,
    documento_tipo_nombre VARCHAR (50)  NOT NULL
);

/*tabla 2*/
CREATE TABLE IF NOT EXISTS canal_venta (
	canal_venta_id INT NOT NULL UNIQUE AUTO_INCREMENT PRIMARY KEY,
    canal_venta_nombre VARCHAR (50) NOT NULL
);

/*tabla 4*/
CREATE TABLE IF NOT EXISTS ciudad (
	ciudad_id INT NOT NULL UNIQUE AUTO_INCREMENT PRIMARY KEY,
    ciudad_nombre VARCHAR (80) NOT NULL
);

/*tabla 5*/
CREATE TABLE IF NOT EXISTS condicion_fiscal (
	condicion_fiscal_id INT NOT NULL UNIQUE AUTO_INCREMENT PRIMARY KEY,
    condicion_fiscal_nombre VARCHAR (50) NOT NULL
);


/*tabla 7*/
CREATE TABLE IF NOT EXISTS sucursal (
	sucursal_id INT NOT NULL UNIQUE AUTO_INCREMENT PRIMARY KEY,
    sucursal_nombre VARCHAR (50) NOT NULL
);

/*tabla 8*/
CREATE TABLE IF NOT EXISTS tipo_persona (
	tipo_persona_id INT NOT NULL UNIQUE AUTO_INCREMENT PRIMARY KEY,
    tipo_persona_detalle VARCHAR (50) NOT NULL
);

/*tabla 11*/
CREATE TABLE IF NOT EXISTS medio_pago (
	medio_pago_id INT NOT NULL UNIQUE AUTO_INCREMENT PRIMARY KEY,
    medio_pago_nombre VARCHAR (50) NOT NULL
);

/*tabla 12*/
CREATE TABLE IF NOT EXISTS genero (
	genero_id INT NOT NULL UNIQUE AUTO_INCREMENT PRIMARY KEY,
    genero_nombre VARCHAR (50) NOT NULL
);

/*tabla 13*/
CREATE TABLE IF NOT EXISTS editorial (
	editorial_id INT NOT NULL UNIQUE AUTO_INCREMENT PRIMARY KEY,
    editorial_nombre VARCHAR (50) NOT NULL
);

/*tabla 15*/
CREATE TABLE IF NOT EXISTS comprobante_tipo (
	comprobante_tipo_id INT NOT NULL UNIQUE AUTO_INCREMENT PRIMARY KEY,
    comprobante_tipo_nombre VARCHAR (30) NOT NULL
);

/*tabla 16*/
CREATE TABLE IF NOT EXISTS nacionalidad (
	nacionalidad_id INT NOT NULL UNIQUE AUTO_INCREMENT PRIMARY KEY,
    nacionalidad_nombre VARCHAR (30) NOT NULL
);

/* Creo las Tablas  con PK y FK*/

/*tabla 3*/
CREATE TABLE IF NOT EXISTS persona (
persona_id INT NOT NULL UNIQUE AUTO_INCREMENT PRIMARY KEY,
documento_tipo_id  INT NOT NULL,
documento_numero INT (11),
persona_nombre VARCHAR (20),
persona_apellido VARCHAR (20),
persona_mail VARCHAR (50),
persona_telefono INT (20),
domicilio_calle VARCHAR (80),
domicilio_numero INT (10),
ciudad_id INT,
condicion_fiscal_id INT,
tipo_persona_id INT,

FOREIGN KEY (documento_tipo_id)
		REFERENCES documento_tipo(documento_tipo_id)
        ON DELETE CASCADE
		ON UPDATE CASCADE,

FOREIGN KEY (ciudad_id)
		REFERENCES ciudad(ciudad_id)
        ON DELETE CASCADE
		ON UPDATE CASCADE,
        
FOREIGN KEY (condicion_fiscal_id)
		REFERENCES condicion_fiscal(condicion_fiscal_id)
        ON DELETE CASCADE
		ON UPDATE CASCADE,

FOREIGN KEY (tipo_persona_id)
		REFERENCES tipo_persona(tipo_persona_id)
        ON DELETE CASCADE
		ON UPDATE CASCADE
); 

/*tabla 14*/
CREATE TABLE IF NOT EXISTS autor(
autor_id INT NOT NULL UNIQUE AUTO_INCREMENT PRIMARY KEY,
autor_nombre VARCHAR (100),
nacionalidad_id INT,

FOREIGN KEY (nacionalidad_id)
		REFERENCES nacionalidad(nacionalidad_id)
        ON DELETE CASCADE
		ON UPDATE CASCADE

);

/*tabla 9*/
CREATE TABLE IF NOT EXISTS libro(
libro_id INT NOT NULL UNIQUE AUTO_INCREMENT PRIMARY KEY,
genero_id INT,
editorial_id INT,
autor_id INT,
anio_edicion INT (4),
titulo VARCHAR (200),
precio_libro DECIMAL (11,2),

FOREIGN KEY (genero_id)
		REFERENCES genero(genero_id)
        ON DELETE CASCADE
		ON UPDATE CASCADE,
        
FOREIGN KEY (editorial_id)
		REFERENCES editorial(editorial_id)
        ON DELETE CASCADE
		ON UPDATE CASCADE,

FOREIGN KEY (autor_id)
		REFERENCES autor(autor_id)
        ON DELETE CASCADE
		ON UPDATE CASCADE
);

/*tabla 6*/
CREATE TABLE IF NOT EXISTS venta (
venta_id INT NOT NULL UNIQUE AUTO_INCREMENT PRIMARY KEY,
canal_venta_id INT (30),
libro_id INT,
medio_pago_id INT,
sucursal_id INT,
cantidad_libro INT (4),
cantidad_libro_total INT (10),
precio_libro DECIMAL (11,2),
venta_monto_total DECIMAL (11,2),
compra_fecha TIMESTAMP,

FOREIGN KEY (canal_venta_id)
		REFERENCES canal_venta(canal_venta_id)
        ON DELETE CASCADE
		ON UPDATE CASCADE,

FOREIGN KEY (libro_id)
		REFERENCES libro(libro_id)
        ON DELETE CASCADE
		ON UPDATE CASCADE,

FOREIGN KEY (medio_pago_id)
		REFERENCES medio_pago(medio_pago_id)
        ON DELETE CASCADE
		ON UPDATE CASCADE,

FOREIGN KEY (sucursal_id)
		REFERENCES sucursal(sucursal_id)
        ON DELETE CASCADE
		ON UPDATE CASCADE
);

/*TABLA 10*/
CREATE TABLE IF NOT EXISTS comprobante(
comprobante_id INT NOT NULL UNIQUE AUTO_INCREMENT PRIMARY KEY,
comprobante_tipo_id INT,
venta_id INT,
persona_id INT,
comprobante_numero_fiscal INT (20),
comprobante_fecha TIMESTAMP,
items_cantidad_total INT (5),
items_cantidad INT (4),
items_precio DECIMAL (11,2),
comprobante_monto_total DECIMAL (11,2),

FOREIGN KEY (comprobante_tipo_id)
		REFERENCES comprobante_tipo(comprobante_tipo_id)
        ON DELETE CASCADE
		ON UPDATE CASCADE,

FOREIGN KEY (venta_id)
		REFERENCES venta(venta_id)
        ON DELETE CASCADE
		ON UPDATE CASCADE,

FOREIGN KEY (persona_id)
		REFERENCES persona(persona_id)
        ON DELETE CASCADE
		ON UPDATE CASCADE
);
