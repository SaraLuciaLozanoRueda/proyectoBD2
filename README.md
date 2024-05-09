# PROYECTO BD2


![image](https://github.com/SaraLuciaLozanoRueda/proyectoBD2/assets/151969212/ac047743-7775-490d-b814-49f3449d049b)





### Consultas sobre una tabla

1. Devuelve un listado con el primer apellido, segundo apellido y el nombre de
    todos los alumnos. El listado deberá estar ordenado alfabéticamente de
    menor a mayor por el primer apellido, segundo apellido y nombre.

  ```mysql
  mysql> CREATE PROCEDURE todos_alumnos()
      -> BEGIN
      ->   SELECT ia.apellido1_alumno,ia.apellido2_alumno,ia.nombre_alumno
      ->   FROM alumno AS a 
      ->   INNER JOIN info_alumno AS ia ON a.id_alumno = ia.id_alumno
      ->   ORDER BY ia.apellido1_alumno ASC,ia.apellido2_alumno ASC,ia.nombre_alumno ASC;
      -> END$$
  Query OK, 0 rows affected (0,00 sec)
  
  mysql> DELIMITER ;
  mysql> 
  mysql> CALL todos_alumnos();
  +------------------+------------------+---------------+
  | apellido1_alumno | apellido2_alumno | nombre_alumno |
  +------------------+------------------+---------------+
  | Fernández        | Gómez            | David         |
  | Gómez            | Pérez            | Carlos        |
  | González         | López            | Sara          |
  | López            | García           | Ana           |
  | López            | Pérez            | Javier        |
  | Martínez         | Fernández        | Pedro         |
  | Martínez         | Gómez            | Lucía         |
  | Pérez            | Martínez         | Elena         |
  | Rodríguez        | Sánchez          | Laura         |
  | Sánchez          | Fernández        | Mario         |
  +------------------+------------------+---------------+
  
  ```

  

2. Averigua el nombre y los dos apellidos de los alumnos que no han dado de
    alta su número de teléfono en la base de datos.

  ```mysql
  SELECT in_a.nombre_alumno,in_a.apellido1_alumno,in_a.apellido2_alumno
  FROM alumno AS a 
  INNER JOIN info_alumno AS in_a ON a.id_alumno = in_a.id_alumno
  INNER JOIN telefono_alumno AS te_a ON in_a.id_alumno = te_a.id_alumno
  WHERE te_a.telefono_alumno IS NULL OR te_a.telefono_acudiente IS NULL;
  
  
  +---------------+------------------+------------------+
  | nombre_alumno | apellido1_alumno | apellido2_alumno |
  +---------------+------------------+------------------+
  | Carlos        | Gómez            | Pérez            |
  | Laura         | Rodríguez        | Sánchez          |
  | Lucía         | Martínez         | Gómez            |
  +---------------+------------------+------------------+
  
  ```

  

3. Devuelve el listado de los alumnos que nacieron en 1999.

   ```mysql
   mysql> SELECT a.id_alumno,in_a.nombre_alumno,in_a.apellido1_alumno,in_a.apellido2_alumno
       -> FROM info_alumno AS in_a
       -> INNER JOIN alumno AS a ON in_a.id_alumno = a.id_alumno
       -> WHERE YEAR(in_a.fecha_nac_alumno)='1999';
   +-----------+---------------+------------------+------------------+
   | id_alumno | nombre_alumno | apellido1_alumno | apellido2_alumno |
   +-----------+---------------+------------------+------------------+
   |       206 | Elena         | Pérez            | Martínez         |
   |       208 | Mario         | Sánchez          | Fernández        |
   +-----------+---------------+------------------+------------------+
   
   ```

   

4. Devuelve el listado de profesores que no han dado de alta su número de
    teléfono en la base de datos y además su nif termina en K.

  ```mysql
  SELECT p.id_profe,p.nif_profe,in_p.nombre_profe,in_p.apellido1_profe
  FROM info_profe AS in_p 
  INNER JOIN profesor AS p ON in_p.id_profe = p.id_profe
  INNER JOIN telefono_profe AS te_p ON p.id_profe = te_p.id_profe
  WHERE te_p.telefono_fijo_profe IS NULL OR te_p.telefono_privado_profe IS NULL OR te_p.telefono_atencion_profe IS NULL AND p.nif_profe LIKE '%K';
  
  +----------+-----------+--------------+-----------------+
  | id_profe | nif_profe | nombre_profe | apellido1_profe |
  +----------+-----------+--------------+-----------------+
  |      101 | 12345678A | Juan         | Martínez        |
  |      110 | 90123456K | Carmen       | González        |
  +----------+-----------+--------------+-----------------+
  ```

  

5. Devuelve el listado de las asignaturas que se imparten en el primer
    cuatrimestre, en el tercer curso del grado que tiene el identificador 7.

  ```mysql
  CREATE VIEW asignatura_1_4 AS 
  SELECT a.id_asignatura,a.nombre_asignatura
  FROM asignatura AS a
  WHERE a.cuatrimestre = 1 AND id_curso = 3 AND id_grado = 7;
  
  SELECT id_asignatura,nombre_asignatura
  FROM asignatura_1_4;
  
  +---------------+-------------------+
  | id_asignatura | nombre_asignatura |
  +---------------+-------------------+
  |             3 | Inglés Avanzado   |
  |             7 | Diseño Gráfico    |
  +---------------+-------------------+
  ```

  

### Consultas multitabla (Composición interna)

1. Devuelve un listado con los datos de todas las alumnas que se han
    matriculado alguna vez en el Grado en Ingeniería Informática (Plan 2015).

  ```mysql
  SELECT a.id_alumno,in_a.nombre_alumno,in_a.apellido1_alumno,in_a.apellido2_alumno,in_a.fecha_nac_alumno
  FROM info_alumno AS in_a
  INNER JOIN alumno AS a ON in_a.id_alumno = a.id_alumno
  INNER JOIN alumno_asignatura AS aa ON a.id_alumno = aa.id_alumno
  INNER JOIN asignatura AS asig ON aa.id_asignatura = asig.id_asignatura
  INNER JOIN grado AS gr ON asig.id_grado = gr.id_grado
  WHERE in_a.sexo_alumno = 'M' AND gr.nombre_grado = 'Ingeniería Informática'
  
  +-----------+---------------+------------------+------------------+------------------+
  | id_alumno | nombre_alumno | apellido1_alumno | apellido2_alumno | fecha_nac_alumno |
  +-----------+---------------+------------------+------------------+------------------+
  |       202 | Ana           | López            | García           | 2001-07-20       |
  |       209 | Lucía         | Martínez         | Gómez            | 2001-04-22       |
  +-----------+---------------+------------------+------------------+------------------+
  ```

  

2. Devuelve un listado con todas las asignaturas ofertadas en el Grado en
    Ingeniería Informática (Plan 2015).

  ```mysql
  DELIMITER $$
  CREATE PROCEDURE asignaturas_informatica()
  BEGIN
    SELECT a.id_asignatura,a.nombre_asignatura
    FROM asignatura AS a 
    INNER JOIN grado AS g ON a.id_grado = g.id_grado
    WHERE g.nombre_grado = 'Ingeniería Informática';
  END$$
  DELIMITER ;
  
  CALL asignaturas_informatica();
  
  +---------------+-------------------+
  | id_asignatura | nombre_asignatura |
  +---------------+-------------------+
  |             1 | Cálculo I         |
  |             3 | Inglés Avanzado   |
  |             7 | Diseño Gráfico    |
  +---------------+-------------------+
  ```

  

3. Devuelve un listado de los profesores junto con el nombre del
    departamento al que están vinculados. El listado debe devolver cuatro
    columnas, primer apellido, segundo apellido, nombre y nombre del
    departamento. El resultado estará ordenado alfabéticamente de menor a
    mayor por los apellidos y el nombre.

  ```mysql
  CREATE VIEW profesor_departament AS
  SELECT in_p.apellido1_profe,in_p.apellido2_profe,in_p.nombre_profe,d.nombre_departamento
  FROM info_profe AS in_p
  INNER JOIN profesor AS p ON p.id_profe = in_p.id_profe
  INNER JOIN departamento AS d ON p.id_departamento = d.id_departamento
  ORDER BY in_p.apellido1_profe ASC,in_p.apellido2_profe ASC,in_p.nombre_profe ASC;
  
  SELECT apellido1_profe,apellido2_profe,nombre_profe,nombre_departamento
  FROM profesor_departament;
  
  +-----------------+-----------------+--------------+-------------------------------------+
  | apellido1_profe | apellido2_profe | nombre_profe | nombre_departamento                 |
  +-----------------+-----------------+--------------+-------------------------------------+
  | Díaz            | Fernández       | Pedro        | Departamento de Lenguas Extranjeras |
  | Fernández       | Díaz            | Elena        | Departamento de Tecnología          |
  | García          | López           | María        | Departamento de Ciencias Naturales  |
  | Gómez           | Rodríguez       | David        | Departamento de Música              |
  | Martínez        | Gómez           | Juan         | Departamento de Matemáticas         |
  | Pérez           | González        | Laura        | Departamento de Arte                |
  | Rodríguez       | Martínez        | Ana          | Departamento de Lenguas Extranjeras |
  | Sánchez         | Martínez        | Sergio       | Departamento de Economía            |
  +-----------------+-----------------+--------------+-------------------------------------+
  ```

  

4. Devuelve un listado con el nombre de las asignaturas, año de inicio y año de
    fin del curso escolar del alumno con nif 26902806M.

  ```mysql
  DELIMITER $$
  CREATE PROCEDURE alumno_nif()
  BEGIN
    SELECT asig.nombre_asignatura,c.año_incio,c.año_fin,a.nif_alumno
    FROM alumno AS a
    INNER JOIN alumno_asignatura AS aa ON a.id_alumno = aa.id_alumno
    INNER JOIN asignatura AS asig ON aa.id_asignatura = asig.id_asignatura
    INNER JOIN curso_escolar  AS c ON asig.id_curso = c.id_curso
    WHERE a.nif_alumno = '26902806M';
  END$$
  DELIMITER ;
  CALL alumno_nif();
  
  +-------------------+------------+----------+------------+
  | nombre_asignatura | año_incio  | año_fin  | nif_alumno |
  +-------------------+------------+----------+------------+
  | Cálculo I         |       2023 |     2024 | 26902806M  |
  +-------------------+------------+----------+------------+
  ```

  

5. Devuelve un listado con el nombre de todos los departamentos que tienen
    profesores que imparten alguna asignatura en el Grado en Ingeniería
    Informática (Plan 2015).

  ```mysql
  CREATE VIEW profe_departamento_grado AS
  SELECT d.nombre_departamento
  FROM departamento AS d
  INNER JOIN profesor AS p ON d.id_departamento = p.id_departamento
  INNER JOIN asignatura AS asig ON p.id_profe = asig.id_profe
  INNER JOIN grado AS g ON asig.id_grado = g.id_grado
  WHERE g.nombre_grado = 'Ingeniería Informática';
  
  SELECT nombre_departamento
  FROM profe_departamento_grado;
  
  +------------------------------+
  | nombre_departamento          |
  +------------------------------+
  | Departamento de Matemáticas  |
  | Departamento de Matemáticas  |
  | Departamento de Música       |
  +------------------------------+
  ```

  

6. Devuelve un listado con todos los alumnos que se han matriculado en
    alguna asignatura durante el curso escolar 2018/2019.

  ```mysql
  SELECT a.id_alumno,in_a.nombre_alumno,in_a.apellido1_alumno,in_a.apellido2_alumno
  FROM alumno_asignatura AS aa 
  INNER JOIN alumno AS a ON aa.id_alumno = a.id_alumno
  INNER JOIN info_alumno AS in_a ON a.id_alumno = in_a.id_alumno
  INNER JOIN curso_escolar AS ce ON aa.id_curso = ce.id_curso
  WHERE ce.año_inicio = 2018 AND ce.año_fin = 2019;
  
  +-----------+---------------+------------------+------------------+
  | id_alumno | nombre_alumno | apellido1_alumno | apellido2_alumno |
  +-----------+---------------+------------------+------------------+
  |       205 | David         | Fernández        | Gómez            |
  |       210 | Javier        | López            | Pérez            |
  +-----------+---------------+------------------+------------------+
  ```



### Consultas multitabla (Composición externa)

Resuelva todas las consultas utilizando las cláusulas LEFT JOIN y RIGHT JOIN.

1. Devuelve un listado con los nombres de todos los profesores y los
    departamentos que tienen vinculados. El listado también debe mostrar
    aquellos profesores que no tienen ningún departamento asociado. El listado
    debe devolver cuatro columnas, nombre del departamento, primer apellido,
    segundo apellido y nombre del profesor. El resultado estará ordenado
    alfabéticamente de menor a mayor por el nombre del departamento,
    apellidos y el nombre.

  ```mysql
  CREATE VIEW departamento_profe AS 
  SELECT d.nombre_departamento,in_pr.apellido1_profe,in_pr.apellido2_profe,in_pr.nombre_profe
  FROM profesor AS pr
  INNER JOIN info_profe AS in_pr ON pr.id_profe = in_pr.id_profe
  LEFT JOIN departamento AS d ON pr.id_departamento = d.id_departamento
  ORDER BY d.nombre_departamento ASC,in_pr.apellido1_profe ASC, in_pr.apellido2_profe ASC, in_pr.nombre_profe ASC;
  
  SELECT nombre_departamento,apellido1_profe,apellido2_profe,nombre_profe
  FROM departamento_profe;
  
  +-------------------------------------+-----------------+-----------------+--------------+
  | nombre_departamento                 | apellido1_profe | apellido2_profe | nombre_profe |
  +-------------------------------------+-----------------+-----------------+--------------+
  | NULL                                | González        | López           | Carmen       |
  | NULL                                | López           | Sánchez         | Carlos       |
  | Departamento de Arte                | Pérez           | González        | Laura        |
  | Departamento de Ciencias Naturales  | García          | López           | María        |
  | Departamento de Economía            | Sánchez         | Martínez        | Sergio       |
  | Departamento de Lenguas Extranjeras | Díaz            | Fernández       | Pedro        |
  | Departamento de Lenguas Extranjeras | Rodríguez       | Martínez        | Ana          |
  | Departamento de Matemáticas         | Martínez        | Gómez           | Juan         |
  | Departamento de Música              | Gómez           | Rodríguez       | David        |
  | Departamento de Tecnología          | Fernández       | Díaz            | Elena        |
  +-------------------------------------+-----------------+-----------------+--------------+
  ```

  

2. Devuelve un listado con los profesores que no están asociados a un
    departamento.

  ```mysql
  SELECT in_p.nombre_profe,p.id_profe,d.nombre_departamento
  FROM profesor AS p
  INNER JOIN info_profe AS in_p ON p.id_profe = in_p.id_profe 
  LEFT  JOIN departamento AS d ON p.id_departamento = d.id_departamento
  WHERE p.id_departamento IS NULL;
  
  +--------------+----------+---------------------+
  | nombre_profe | id_profe | nombre_departamento |
  +--------------+----------+---------------------+
  | Carlos       |      105 | NULL                |
  | Carmen       |      110 | NULL                |
  +--------------+----------+---------------------+
  ```

  

3. Devuelve un listado con los departamentos que no tienen profesores
    asociados.

  ```mysql
  DELIMITER $$
  CREATE PROCEDURE departamento_noprofe()
  BEGIN
    SELECT p.id_profe,d.nombre_departamento
    FROM profesor AS p
    INNER JOIN info_profe AS in_p ON p.id_profe = in_p.id_profe 
    RIGHT  JOIN departamento AS d ON p.id_departamento = d.id_departamento
    WHERE p.id_departamento IS NULL;
  END$$
  CALL departamento_noprofe();
  
  +----------+------------------------------------+
  | id_profe | nombre_departamento                |
  +----------+------------------------------------+
  |     NULL | Departamento de Educación Física   |
  |     NULL | Departamento de Filosofía          |
  +----------+------------------------------------+
  ```

  

4. Devuelve un listado con los profesores que no imparten ninguna asignatura.

   ```mysql
   SELECT p.id_profe,a.nombre_asignatura
   FROM asignatura AS a 
   RIGHT JOIN profesor AS p ON a.id_profe = p.id_profe
   WHERE a.id_profe IS NULL;
   
   +----------+-------------------+
   | id_profe | nombre_asignatura |
   +----------+-------------------+
   |      103 | NULL              |
   |      109 | NULL              |
   +----------+-------------------+
   ```

   

5. Devuelve un listado con las asignaturas que no tienen un profesor asignado.

   ```mysql
   SELECT p.id_profe,a.nombre_asignatura
   FROM asignatura AS a 
   LEFT JOIN profesor AS p ON a.id_profe = p.id_profe
   WHERE a.id_profe IS NULL;
   
   +----------+---------------------------+
   | id_profe | nombre_asignatura         |
   +----------+---------------------------+
   |     NULL | Cálculo I                 |
   |     NULL | Filosofía Contemporánea   |
   +----------+---------------------------+
   ```

   

6. Devuelve un listado con todos los departamentos que tienen alguna
    asignatura que no se haya impartido en ningún curso escolar. El resultado
    debe mostrar el nombre del departamento y el nombre de la asignatura que
    no se haya impartido nunca.

  ```mysql
  SELECT d.nombre_departamento, asig.nombre_asignatura
  FROM departamento AS d
  INNER JOIN profesor AS p ON d.id_departamento = p.id_departamento
  INNER JOIN asignatura AS asig ON p.id_profe = asig.id_profe
  LEFT JOIN curso_escolar AS cs ON asig.id_curso = cs.id_curso
  WHERE cs.id_curso IS NULL;
  
  +-----------------------------+-------------------------+
  | nombre_departamento         | nombre_asignatura       |
  +-----------------------------+-------------------------+
  | Departamento de Arte        | Música Clásica          |
  | Departamento de Tecnología  | Economía Internacional  |
  +-----------------------------+-------------------------+
  ```

  



### Consultas resumen

1. Devuelve el número total de alumnas que hay.

   ```mysql
   DELIMITER $$
   CREATE PROCEDURE alumnas()
   BEGIN
     SELECT COUNT(a.id_alumno) AS alumnas
     FROM alumno AS a
     INNER JOIN info_alumno AS in_a ON in_a.id_alumno = a.id_alumno
     WHERE sexo_alumno = 'M';
   END$$
   DELIMITER ;
   CALL alumnas();
   
   +---------+
   | alumnas |
   +---------+
   |       5 |
   +---------+
   ```

   

2. Calcula cuántos alumnos nacieron en 1999.

   ```mysql
   CREATE VIEW nacidos_1999 AS 
   SELECT COUNT(a.id_alumno) AS nacidos
   FROM alumno AS a
   INNER JOIN info_alumno AS in_a ON a.id_alumno = in_a.id_alumno
   WHERE YEAR(in_a.fecha_nac_alumno) = '1999';
   
   SELECT nacidos
   FROM nacidos_1999;
   
   +---------+
   | nacidos |
   +---------+
   |       2 |
   +---------+
   ```

   

3. Calcula cuántos profesores hay en cada departamento. El resultado sólo
  debe mostrar dos columnas, una con el nombre del departamento y otra
  con el número de profesores que hay en ese departamento. El resultado
  sólo debe incluir los departamentos que tienen profesores asociados y
  deberá estar ordenado de mayor a menor por el número de profesores.

  ```mysql
  SELECT d.nombre_departamento,COUNT(p.id_profe) AS profe_depa
  FROM profesor AS p 
  INNER JOIN departamento AS d ON p.id_departamento = d.id_departamento
  GROUP BY d.nombre_departamento
  ORDER BY profe_depa DESC;
  
  +-------------------------------------+------------+
  | nombre_departamento                 | profe_depa |
  +-------------------------------------+------------+
  | Departamento de Lenguas Extranjeras |          2 |
  | Departamento de Matemáticas         |          1 |
  | Departamento de Ciencias Naturales  |          1 |
  | Departamento de Arte                |          1 |
  | Departamento de Música              |          1 |
  | Departamento de Tecnología          |          1 |
  | Departamento de Economía            |          1 |
  +-------------------------------------+------------+
  ```

  

4. Devuelve un listado con todos los departamentos y el número de profesores
  que hay en cada uno de ellos. Tenga en cuenta que pueden existir
  departamentos que no tienen profesores asociados. Estos departamentos
  también tienen que aparecer en el listado.

  ```mysql
  SELECT d.nombre_departamento,COUNT(p.id_profe) AS profe_depa
  FROM profesor AS p 
  LEFT JOIN departamento AS d ON p.id_departamento = d.id_departamento
  GROUP BY d.nombre_departamento
  ORDER BY profe_depa DESC;
  
  +-------------------------------------+------------+
  | nombre_departamento                 | profe_depa |
  +-------------------------------------+------------+
  | NULL                                |          2 |
  | Departamento de Lenguas Extranjeras |          2 |
  | Departamento de Matemáticas         |          1 |
  | Departamento de Ciencias Naturales  |          1 |
  | Departamento de Arte                |          1 |
  | Departamento de Música              |          1 |
  | Departamento de Tecnología          |          1 |
  | Departamento de Economía            |          1 |
  +-------------------------------------+------------+
  ```

  

5. Devuelve un listado con el nombre de todos los grados existentes en la base
  de datos y el número de asignaturas que tiene cada uno. Tenga en cuenta que pueden existir grados que no tienen asignaturas asociadas. Estos grados también tienen que aparecer en el listado. El resultado deberá estar ordenado de mayor a menor por el número de asignaturas.

  ```mysql
  CREATE VIEW cantidad_asignaturas AS
  SELECT COUNT(a.id_grado) AS cantidad,g.nombre_grado
  FROM grado AS g
  INNER JOIN asignatura AS a ON g.id_grado = a.id_grado
  GROUP BY g.id_grado,g.nombre_grado
  ORDER BY cantidad DESC;
  
  SELECT cantidad,nombre_grado
  FROM cantidad_asignaturas;
  
  +----------+--------------------------+
  | cantidad | nombre_grado             |
  +----------+--------------------------+
  |        3 | Ingeniería Informática   |
  |        2 | Educación Física         |
  |        1 | Biología                 |
  |        1 | Historia del Arte        |
  |        1 | Música                   |
  |        1 | Filosofía                |
  |        1 | Química                  |
  +----------+--------------------------+
  ```



6. Devuelve un listado con el nombre de todos los grados existentes en la base
     de datos y el número de asignaturas que tiene cada uno, de los grados que
       tengan más de 40 asignaturas asociadas.

     ```mysql
     CREATE VIEW cantidad_asignaturas AS
     SELECT COUNT(a.id_grado) AS cantidad,g.nombre_grado
     FROM grado AS g
     INNER JOIN asignatura AS a ON g.id_grado = a.id_grado
     GROUP BY g.id_grado,g.nombre_grado
     HAVING COUNT(a.id_grado) > 40
     ORDER BY cantidad DESC;
     
     SELECT cantidad,nombre_grado
     FROM cantidad_asignaturas;
     ```

     

7. Devuelve un listado que muestre el nombre de los grados y la suma del
     número total de créditos que hay para cada tipo de asignatura. El resultado
       debe tener tres columnas: nombre del grado, tipo de asignatura y la suma
       de los créditos de todas las asignaturas que hay de ese tipo. Ordene el
       resultado de mayor a menor por el número total de crédidos.

     ```mysql
     SELECT g.nombre_grado,a.tipo_asignatura,SUM(a.creditos) AS suma_creditos
     FROM grado AS g
     INNER JOIN asignatura AS a ON g.id_grado = a.id_grado
     GROUP BY g.nombre_grado,a.tipo_asignatura
     ORDER BY suma_creditos DESC;
     
     +--------------------------+-----------------+---------------+
     | nombre_grado             | tipo_asignatura | suma_creditos |
     +--------------------------+-----------------+---------------+
     | Ingeniería Informática   | Obligatoria     |            12 |
     | Educación Física         | Obligatoria     |             8 |
     | Biología                 | Obligatoria     |             5 |
     | Historia del Arte        | Obligatoria     |             5 |
     | Química                  | Obligatoria     |             5 |
     | Ingeniería Informática   | Opcional        |             4 |
     | Música                   | Opcional        |             4 |
     | Filosofía                | Obligatoria     |             4 |
     +--------------------------+-----------------+---------------+
     ```

     

8. Devuelve un listado que muestre cuántos alumnos se han matriculado de
     alguna asignatura en cada uno de los cursos escolares. El resultado deberá
       mostrar dos columnas, una columna con el año de inicio del curso escolar y
       otra con el número de alumnos matriculados.

     ```mysql
     CREATE VIEW alumnos_curso AS
     SELECT c.año_inicio, COUNT(aa.id_alumno) AS alumnos
     FROM alumno_asignatura AS aa 
     INNER JOIN curso_escolar AS c ON aa.id_curso = c.id_curso
     GROUP BY c.año_inicio;
     
     SELECT año_inicio,alumnos
     FROM alumnos_curso;
     
     +-------------+---------+
     | año_inicio  | alumnos |
     +-------------+---------+
     |        2023 |       2 |
     |        2022 |       2 |
     |        2015 |       2 |
     |        2016 |       2 |
     |        2018 |       2 |
     +-------------+---------+
     ```

     

9. Devuelve un listado con el número de asignaturas que imparte cada
     profesor. El listado debe tener en cuenta aquellos profesores que no
       imparten ninguna asignatura. El resultado mostrará cinco columnas: id,
       nombre, primer apellido, segundo apellido y número de asignaturas. El
       resultado estará ordenado de mayor a menor por el número de asignaturas.

     ```mysql
     SELECT p.id_profe,p.nombre_profe,p.apellido1_profe,p.apellido2_profe,COUNT(p.id_profe) AS imparte 
     FROM info_profe AS p
     LEFT JOIN asignatura AS a ON a.id_profe = p.id_profe
     GROUP BY p.id_profe,p.nombre_profe,p.apellido1_profe,p.apellido2_profe;
     
     +----------+--------------+-----------------+-----------------+---------+
     | id_profe | nombre_profe | apellido1_profe | apellido2_profe | imparte |
     +----------+--------------+-----------------+-----------------+---------+
     |      101 | Juan         | Martínez        | Gómez           |       1 |
     |      102 | María        | García          | López           |       1 |
     |      103 | Pedro        | Díaz            | Fernández       |       1 |
     |      104 | Ana          | Rodríguez       | Martínez        |       1 |
     |      105 | Carlos       | López           | Sánchez         |       1 |
     |      106 | Laura        | Pérez           | González        |       1 |
     |      107 | David        | Gómez           | Rodríguez       |       1 |
     |      108 | Elena        | Fernández       | Díaz            |       1 |
     |      109 | Sergio       | Sánchez         | Martínez        |       1 |
     |      110 | Carmen       | González        | López           |       1 |
     +----------+--------------+-----------------+-----------------+---------+
     ```

     

  

### Subconsultas

1. Devuelve todos los datos del alumno más joven.

   ```mysql
   CREATE VIEW mas_joven AS
   SELECT in_a.nombre_alumno,in_a.apellido1_alumno,in_a.apellido2_alumno,in_a.sexo_alumno,in_a.fecha_nac_alumno
   FROM info_alumno AS in_a
   ORDER BY in_a.fecha_nac_alumno DESC
   LIMIT 1;
   
   SELECT nombre_alumno,apellido1_alumno,apellido2_alumno,sexo_alumno,fecha_nac_alumno
   FROM mas_joven;
   
   +---------------+------------------+------------------+-------------+------------------+
   | nombre_alumno | apellido1_alumno | apellido2_alumno | sexo_alumno | fecha_nac_alumno |
   +---------------+------------------+------------------+-------------+------------------+
   | Sara          | González         | López            | M           | 2003-06-30       |
   +---------------+------------------+------------------+-------------+------------------+
   ```

   

2. Devuelve un listado con los profesores que no están asociados a un
  departamento.

  ```mysql
  SELECT p.id_profe,
      (SELECT nombre_profe FROM info_profe WHERE id_info_profesor = p.id_info_profesor) AS nombre,
      (SELECT apellido1_profe FROM info_profe WHERE id_info_profesor = p.id_info_profesor) AS apellido,
      (SELECT apellido2_profe FROM info_profe WHERE id_info_profesor = p.id_info_profesor) AS apellido2
  FROM profesor AS p
  WHERE p.id_departamento IS NULL;
  
  +----------+--------+-----------+-----------+
  | id_profe | nombre | apellido  | apellido2 |
  +----------+--------+-----------+-----------+
  |      105 | Carlos | López     | Sánchez   |
  |      110 | Carmen | González  | López     |
  +----------+--------+-----------+-----------+
  ```

  

3. Devuelve un listado con los departamentos que no tienen profesores
  asociados.

  ```mysql
  SELECT p.id_profe,
      (SELECT d.id_departamento FROM departamento AS d WHERE p.id_departamento = d.id_departamento) AS id_departamento
  FROM profesor AS p
  WHERE p.id_departamento IS NULL;
  
  +----------+-----------------+
  | id_profe | id_departamento |
  +----------+-----------------+
  |      105 |            NULL |
  |      110 |            NULL |
  +----------+-----------------+
  ```

  

4. Devuelve un listado con los profesores que tienen un departamento
  asociado y que no imparten ninguna asignatura.

  ```mysql
  SELECT p.id_profe, ip.nombre_profe, ip.apellido1_profe, ip.apellido2_profe
  FROM profesor AS p
  INNER JOIN info_profe AS ip ON p.id_info_profesor = ip.id_info_profesor
  INNER JOIN departamento AS d ON p.id_departamento = d.id_departamento
  WHERE p.id_profe NOT IN (
      SELECT DISTINCT id_profe FROM asignatura
  );
  ```

  

5. Devuelve un listado con las asignaturas que no tienen un profesor asignado.

   ```mysql
   CREATE VIEW no_profe AS
   SELECT a.id_asignatura,a.nombre_asignatura,a.id_profe
   FROM asignatura AS a
   WHERE a.id_profe IS NULL;
   
   SELECT id_asignatura,nombre_asignatura,id_profe
   FROM no_profe;
   
   +---------------+---------------------------+----------+
   | id_asignatura | nombre_asignatura         | id_profe |
   +---------------+---------------------------+----------+
   |             1 | Cálculo I                 |     NULL |
   |             9 | Filosofía Contemporánea   |     NULL |
   +---------------+---------------------------+----------+
   ```

   

6. Devuelve un listado con todos los departamentos que no han impartido
  asignaturas en ningún curso escolar.

  ```mysql
  SELECT id_departamento, nombre_departamento
  FROM departamento
  WHERE id_departamento NOT IN (
      SELECT DISTINCT d.id_departamento
      FROM departamento AS d
      INNER JOIN profesor AS p ON d.id_departamento = p.id_departamento
      INNER JOIN asignatura AS a ON p.id_profe = a.id_profe
  );
  
  +-----------------+------------------------------------+
  | id_departamento | nombre_departamento                |
  +-----------------+------------------------------------+
  |               4 | Departamento de Historia           |
  |               5 | Departamento de Educación Física   |
  |               9 | Departamento de Economía           |
  |              10 | Departamento de Filosofía          |
  +-----------------+------------------------------------+
  ```

  
