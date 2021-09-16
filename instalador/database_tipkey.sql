
DROP TABLE IF EXISTS ambientes;
CREATE TABLE ambientes(
    `no` INT(20) NOT NULL AUTO_INCREMENT,
    cede VARCHAR(20)NOT NULL,
    nom_aula VARCHAR(20) NOT NULL,
    PRIMARY KEY (`no`)
);

DROP TABLE IF EXISTS programas;
CREATE TABLE programas(
    ficha int(15) NOT NULL,
    nom_programa VARCHAR(50) NOT NULL,
   
    PRIMARY KEY(ficha)
);

DROP TABLE IF EXISTS instructores;
CREATE TABLE instructores (
    No_documento int(15) NOT NULL,
    nom_instructor varchar (30)NOT NULL,
    PRIMARY KEY (No_documento)
);


CREATE TABLE prog_inst(
    ficha int(15) NOT NULL,
    No_documento int(15) NOT NULL,
    PRIMARY KEY (ficha, No_documento)
);

DROP TABLE IF EXISTS usuario;
CREATE TABLE usuario(
    id INT(11) NOT NULL AUTO_INCREMENT,
    fecha TIMESTAMP NOT NULL,
    clave VARCHAR(10) NOT NULL,
    correo VARCHAR(30) NOT NULL,
    nombre_usuario VARCHAR(20) NOT NULL,
    PRIMARY KEY(id)
);


DROP TABLE IF EXISTS prestamo_ambientes;
CREATE TABLE prestamo_ambientes(
    fecha_registro timestamp NOT NULL,
    No_documento int (15) NOT NULL,
    hora_ingreso TIME NOT NULL,
    hora_salida TIME  NOT NULL,
    observaciones varchar (100),
    `no`INT (20) NOT NULL,
    id int(11) DEFAULT NULL,
    fecha_prestamo date NOT NULL,
    fecha_devolucion date NOT NULL,
    PRIMARY KEY (fecha_registro)
);

DROP TABLE IF EXISTS re_drop;
CREATE TABLE re_drop (
    id int(11) NOT NULL AUTO_INCREMENT,
    descripcion varchar(200) NOT NULL,
    fecha_registro datetime NOT NULL,
    PRIMARY KEY (id)       
);

ALTER TABLE prestamo_ambientes
    ADD CONSTRAINT prestamo_1 FOREIGN KEY (id)
    REFERENCES usuario (id) ON DELETE CASCADE ON UPDATE CASCADE,
    ADD CONSTRAINT prestamo_2 FOREIGN KEY (`no`) 
    REFERENCES ambientes (`no`) ON DELETE CASCADE ON UPDATE CASCADE,
    ADD CONSTRAINT prestamo_3 FOREIGN KEY (`No_documento`) 
    REFERENCES instructores (`No_documento`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE prog_inst
    ADD CONSTRAINT instructores_1 FOREIGN KEY (`No_documento`) 
    REFERENCES instructores (`No_documento`) ON DELETE CASCADE ON UPDATE CASCADE,   
    ADD CONSTRAINT programas_1 FOREIGN KEY (ficha) 
    REFERENCES programas (ficha) ON DELETE CASCADE ON UPDATE CASCADE;

DELIMITER //
CREATE PROCEDURE dd (IN fecha DATE, IN fecha_f DATE, IN hi TIME, IN hf TIME,IN a INT)
	BEGIN
    SELECT * FROM prestamo_ambientes WHERE (
        (
            
            fecha BETWEEN fecha_prestamo AND fecha_devolucion OR
            fecha_f BETWEEN fecha_prestamo AND fecha_devolucion OR
            fecha_prestamo BETWEEN fecha AND fecha_f)
        AND(
            hi BETWEEN hora_ingreso AND hora_salida OR
            hf BETWEEN hora_ingreso AND hora_salida OR
            hora_ingreso BETWEEN hi AND hf)
        ) AND
        a=`no`;
        END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE disponibilidad(IN fecha DATE, IN hora TIME)
	BEGIN
    SELECT * FROM prestamo_ambientes WHERE 
    fecha BETWEEN fecha_prestamo AND fecha_devolucion AND
    hora BETWEEN hora_ingreso AND hora_salida;
    END //
DELIMITER ;






