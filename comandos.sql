CREATE TABLE info_profe (
id_info_profesor INT(10) PRIMARY KEY AUTO_INCREMENT,
id_profe INT(10),
nombre_profe VARCHAR(25),
apellido1_profe VARCHAR(50),
apellido2_profe VARCHAR(50),
fecha_nac_profe DATE,
sexo_profe ENUM('H','M')
);
CREATE TABLE telefono_profe (
id_telefono_profe INT(10) PRIMARY KEY AUTO_INCREMENT,
id_profe INT(10),
telefono_fijo_profe VARCHAR(9),
telefono_privado_profe VARCHAR(9),
telefono_atencion_profe VARCHAR(9)
);
CREATE TABLE direccion_profe (
id_direccion_profe INT(10) PRIMARY KEY AUTO_INCREMENT,
id_profe INT(10),
direccion1_profe VARCHAR(50),
direccion2_profe VARCHAR(50)
);
CREATE TABLE departamento (
id_departamento INT(10) PRIMARY KEY ,
nombre_departamento VARCHAR(50)
);
CREATE TABLE profesor (
id_profe INT(10) PRIMARY KEY,
nif_profe VARCHAR(9),
id_info_profesor INT(10),
id_telefono_profe INT(10),
id_direccion_profe INT(10),
id_departamento INT(10)
);
CREATE TABLE asignatura (
id_asignatura INT(10) PRIMARY KEY,
nombre_asignatura VARCHAR(100),
creditos FLOAT,
tipo_asignatura ENUM('Obligatoria','Opcional'),
id_curso INT(10),
cuatrimestre TINYINT(3),
id_profe INT(10),
id_grado INT(10)
);
CREATE TABLE grado (
id_grado INT(10) PRIMARY KEY,
nombre_grado VARCHAR(100)
);
CREATE TABLE alumno_asignatura(
id_alumno_asignatura INT(10),
id_alumno INT(10),
id_asignatura INT(10),
id_curso INT(10)
);
CREATE TABLE curso_escolar(
id_curso INT(10) PRIMARY KEY,
año_inicio YEAR(4),
año_fin YEAR(4)
);
CREATE TABLE info_alumno (
id_info_alumno INT(10) PRIMARY KEY AUTO_INCREMENT,
id_alumno INT(10),
nombre_alumno VARCHAR(25),
apellido1_alumno VARCHAR(50),
apellido2_alumno VARCHAR(50),
fecha_nac_alumno DATE,
sexo_alumno ENUM('H','M') 
);
CREATE TABLE direccion_alumno(
id_direccion_alumno INT(10) PRIMARY KEY  AUTO_INCREMENT,
id_alumno INT(10),
direccion1_alumno VARCHAR(50),
direccion2_alumno VARCHAR(50),
ciudad VARCHAR(25)
);
CREATE TABLE telefono_alumno(
id_telefono_alumno INT(10) PRIMARY KEY AUTO_INCREMENT,
id_alumno INT(10),
telefono_alumno VARCHAR(9),
telefono_acudiente VARCHAR(9)
);
CREATE TABLE alumno(
id_alumno INT(10) PRIMARY KEY,
nif_alumno VARCHAR(9),
id_info_alumno INT(10),
id_direccion_alumno INT(10),
id_telefono_alumno INT(10)
);

ALTER TABLE profesor ADD CONSTRAINT fk_profesor_info_profe FOREIGN KEY (id_info_profesor) REFERENCES info_profe(id_info_profesor);
ALTER TABLE profesor ADD CONSTRAINT fk_profesor_telefono_profe FOREIGN KEY (id_telefono_profe) REFERENCES telefono_profe(id_telefono_profe);
ALTER TABLE profesor ADD CONSTRAINT fk_profesor_direccion_profe FOREIGN KEY (id_direccion_profe) REFERENCES direccion_profe(id_direccion_profe);
ALTER TABLE profesor ADD CONSTRAINT fk_profesor_departamento FOREIGN KEY (id_departamento) REFERENCES departamento(id_departamento);

ALTER TABLE asignatura ADD CONSTRAINT fk_asignatura_profesor FOREIGN KEY (id_profe) REFERENCES profesor(id_profe);
ALTER TABLE asignatura ADD CONSTRAINT fk_asignatura_grado FOREIGN KEY (id_grado) REFERENCES grado(id_grado);

ALTER TABLE alumno_asignatura ADD CONSTRAINT fk_alumno_asignatura_alumno FOREIGN KEY (id_alumno) REFERENCES alumno(id_alumno);
ALTER TABLE alumno_asignatura ADD CONSTRAINT fk_alumno_asignatura_asignatura FOREIGN KEY (id_asignatura) REFERENCES asignatura(id_asignatura);
ALTER TABLE alumno_asignatura ADD CONSTRAINT fk_alumno_asignatura_curso_escolar FOREIGN KEY (id_curso) REFERENCES curso_escolar(id_curso);

ALTER TABLE alumno ADD CONSTRAINT fk_alumno_info_alumno FOREIGN KEY (id_info_alumno) REFERENCES info_alumno(id_info_alumno);
ALTER TABLE alumno ADD CONSTRAINT fk_alumno_direccion_alumno FOREIGN KEY (id_direccion_alumno) REFERENCES direccion_alumno(id_direccion_alumno);
ALTER TABLE alumno ADD CONSTRAINT fk_alumno_telefono_alumno FOREIGN KEY (id_telefono_alumno) REFERENCES telefono_alumno(id_telefono_alumno);


INSERT INTO departamento (id_departamento, nombre_departamento)
VALUES
(1, 'Departamento de Matemáticas'),
(2, 'Departamento de Ciencias Naturales'),
(3, 'Departamento de Lenguas Extranjeras'),
(4, 'Departamento de Historia'),
(5, 'Departamento de Educación Física'),
(6, 'Departamento de Arte'),
(7, 'Departamento de Música'),
(8, 'Departamento de Tecnología'),
(9, 'Departamento de Economía'),
(10, 'Departamento de Filosofía');


INSERT INTO grado (id_grado, nombre_grado)
VALUES
(1, 'Ingeniería Informática'),
(2, 'Biología'),
(3, 'Lengua y Literatura'),
(4, 'Historia del Arte'),
(5, 'Educación Física'),
(6, 'Música'),
(7, 'Diseño Gráfico'),
(8, 'Economía'),
(9, 'Filosofía'),
(10, 'Química');

INSERT INTO curso_escolar (id_curso, año_inicio, año_fin)
VALUES
(1, 2023, 2024),
(2, 2022, 2024),
(3, 2015, 2016),
(4, 2016, 2017),
(5, 2018, 2019);

INSERT INTO info_profe (id_info_profesor, id_profe, nombre_profe, apellido1_profe, apellido2_profe, fecha_nac_profe, sexo_profe)
VALUES
(1, 101, 'Juan', 'Martínez', 'Gómez', '1980-05-15', 'H'),
(2, 102, 'María', 'García', 'López', '1975-09-20', 'M'),
(3, 103, 'Pedro', 'Díaz', 'Fernández', '1983-02-10', 'H'),
(4, 104, 'Ana', 'Rodríguez', 'Martínez', '1978-11-30', 'M'),
(5, 105, 'Carlos', 'López', 'Sánchez', '1985-07-25', 'H'),
(6, 106, 'Laura', 'Pérez', 'González', '1982-04-18', 'M'),
(7, 107, 'David', 'Gómez', 'Rodríguez', '1987-09-05', 'H'),
(8, 108, 'Elena', 'Fernández', 'Díaz', '1980-12-20', 'M'),
(9, 109, 'Sergio', 'Sánchez', 'Martínez', '1979-03-12', 'H'),
(10,110, 'Carmen', 'González', 'López', '1984-06-28', 'M');


INSERT INTO telefono_profe (id_telefono_profe, id_profe, telefono_fijo_profe, telefono_privado_profe, telefono_atencion_profe)
VALUES
(1, 101, '123456789', NULL, '654987321'),
(2, 102, '987654321', '123456789', '987654123'),
(3,103, '333333333', '444444444', '555555555'),
(4,104, '666666666', '777777777', '888888888'),
(NULL,105, '999999999', '000000000', '111111111'),
(NULL,106, '222222222', '333333333',  NULL),
(NULL,107, '555555555', '666666666', '777777777'),
(NULL,108, '888888888', '999999999', '000000000'),
(NULL,109, '111111111', '222222222', '333333333'),
(NULL,110, '444444444', NULL, '666666666');


INSERT INTO direccion_profe (id_direccion_profe, id_profe, direccion1_profe, direccion2_profe)
VALUES
(1, 101, 'Calle Mayor, 123', 'Piso 2, Puerta B'),
(2, 102, 'Avenida Libertad, 456', 'Bloque C, Escalera 3'),
(3,103, 'Calle Gran Vía, 789', 'Piso 5, Puerta C'),
(4,104, 'Plaza España, 101', 'Piso 1, Puerta A'),
(5,105, 'Calle Alcalá, 234', 'Piso 3, Puerta D'),
(6, 106, 'Avenida Diagonal, 567', 'Piso 4, Puerta E'),
(7, 107, 'Calle Serrano, 890', 'Piso 6, Puerta F'),
(8, 108, 'Paseo de la Castellana, 111', 'Piso 7, Puerta G'),
(9,109, 'Avenida de América, 222', 'Piso 8, Puerta H'),
(10,110, 'Calle Velázquez, 333', 'Piso 9, Puerta I');

INSERT INTO profesor (id_profe,nif_profe, id_info_profesor, id_telefono_profe, id_direccion_profe, id_departamento)
VALUES
(101, '12345678A', 1, 1, 1, 1),
(102,'87654321B', 2, 2, 2, 2),
(103,'98765432C',3, 3, 3, 3),
(104,'45678901D', 4, 4, 4, 3),
(105,'23456789E', 5, 5, 5, NULL),
(106,'89012345F',6, 6, 6, 6),
(107,'67890123K',7, 7, 7, 7),
(108,'34567890H',8, 8, 8, 8),
(109,'01234567I', 9, 9, 9, 9),
(110,'90123456K', 10, 10, 10, NULL);


INSERT INTO asignatura (id_asignatura, nombre_asignatura, creditos, tipo_asignatura, id_curso, cuatrimestre, id_profe, id_grado)
VALUES
(1, 'Cálculo I', 6.0, 'Obligatoria', 1, 1, NULL, 1),
(2, 'Biología Celular', 5.0, 'Obligatoria', 2, 1, 102, 2),
(3, 'Inglés Avanzado', 4.0, 'Opcional', 3, 1, 101, 1),
(4,'Historia del Arte', 5.0, 'Obligatoria', 4, 1, 104, 4),
(5,'Educación Física', 3.0, 'Obligatoria', 5, 1, 105, 5),
(6,'Música Clásica', 4.0, 'Opcional', 6, 1, 106, 6),
(7,'Diseño Gráfico', 6.0, 'Obligatoria', 3, 1, 107, 1),
(8,'Economía Internacional', 5.0, 'Obligatoria', 8, 1, 108, 5),
(9,'Filosofía Contemporánea', 4.0, 'Obligatoria', 9, 1, NULL, 9),
(10,'Química Orgánica', 5.0, 'Obligatoria', 10, 1, 110, 10);


INSERT INTO info_alumno (id_info_alumno, id_alumno, nombre_alumno, apellido1_alumno, apellido2_alumno, fecha_nac_alumno, sexo_alumno)
VALUES
(1, 201, 'Carlos', 'Gómez', 'Pérez', '2000-03-10', 'H'),
(2, 202, 'Ana', 'López', 'García', '2001-07-20', 'M'),
(3, 203, 'Pedro', 'Martínez', 'Fernández', '2002-01-05', 'H'),
(4, 204, 'Laura', 'Rodríguez', 'Sánchez', '2000-05-12', 'M'),
(5, 205, 'David', 'Fernández', 'Gómez', '2001-09-18', 'H'),
(6, 206, 'Elena', 'Pérez', 'Martínez', '1999-02-25', 'M'),
(7, 207, 'Sara', 'González', 'López', '2003-06-30', 'M'),
(8, 208, 'Mario', 'Sánchez', 'Fernández', '1999-11-15', 'H'),
(9, 209, 'Lucía', 'Martínez', 'Gómez', '2001-04-22', 'M'),
(10, 210, 'Javier', 'López', 'Pérez', '2002-08-07', 'H');



INSERT INTO direccion_alumno (id_direccion_alumno, id_alumno, direccion1_alumno, direccion2_alumno, ciudad)
VALUES
(1, 201, 'Calle Sol, 45', 'Bloque A, Piso 3', 'Madrid'),
(2, 202, 'Avenida Gran Vía, 100', 'Puerta 20', 'Barcelona'),
(3, 203, 'Plaza Mayor, 1', 'Escalera B, Piso 2', 'Sevilla'),
(4, 204, 'Calle Mayor, 10', 'Piso 1, Puerta C', 'Valencia'),
(5, 205, 'Avenida Libertad, 25', 'Bloque B, Piso 2', 'Málaga'),
(6, 206, 'Calle Real, 30', 'Piso 4, Puerta A', 'Bilbao'),
(7, 207, 'Avenida del Mar, 50', 'Piso 2, Puerta D', 'Alicante'),
(8, 208, 'Calle Granada, 15', 'Escalera C, Piso 3', 'Granada'),
(9, 209, 'Plaza de España, 20', 'Piso 5, Puerta B', 'Toledo'),
(10, 210, 'Calle Alcalá, 35', 'Piso 3, Puerta E', 'Zaragoza');


INSERT INTO telefono_alumno (id_telefono_alumno, id_alumno, telefono_alumno, telefono_acudiente)
VALUES
(1, 201, NULL, '999888777'),
(2, 202, '667222333', '998887766'),
(3, 203, '668333444', '997776655'),
(4, 204, '669444555', NULL),
(5, 205, '660555666', '995554433'),
(6, 206, '661666777', '994443322'),
(7, 207, '662777888', '993332211'),
(8, 208, '663888999', '992221100'),
(9, 209, NULL, '991110099'),
(10, 210, '665000111', '990000888');

INSERT INTO alumno (id_alumno, nif_alumno, id_info_alumno, id_direccion_alumno, id_telefono_alumno)
VALUES
(201, '26902806M', 1, 1, 1),
(202, '87654321B', 2, 2, 2),
(203, '98765432C', 3, 3, 3),
(204, '45678901D', 4, 4, 4),
(205, '23456789E', 5, 5, 5),
(206, '89012345F', 6, 6, 6),
(207, '67890123G', 7, 7, 7),
(208, '34567890H', 8, 8, 8),
(209, '01234567I', 9, 9, 9),
(210, '90123456J', 10, 10, 10);

INSERT INTO alumno_asignatura (id_alumno_asignatura, id_alumno, id_asignatura, id_curso)
VALUES
(1, 201, 1, 1),
(2, 202, 2, 2),
(3, 203, 3, 3),
(4, 204, 4, 4),
(5, 205, 5, 5),
(6,206, 6, 1),
(7,207, 7, 2),
(8,208, 8, 3),
(9,209, 9, 4),
(10,210, 10, 5);






