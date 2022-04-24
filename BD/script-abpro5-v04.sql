-- ABPro AE5 Grupo 3

-- Parte 1: Crear entorno de trabajo
-- Crear una base de datos
CREATE DATABASE telovendo5 DEFAULT CHARACTER SET utf8mb4;
-- Crear un usuario con todos los privilegios para trabajar con la base de datos recién creada.   
CREATE USER 'admintelovendo5'@'localhost' IDENTIFIED BY 'password';
SET PASSWORD FOR 'admintelovendo5'@'localhost' = 'ADminteloVendoNUEVO4590##';

-- Totalidad de permisos a la base de datos creada.
GRANT ALL PRIVILEGES ON telovendo5.* TO 'admintelovendo5'@'localhost';
-- Se cargan los privilegios del usuario.
FLUSH PRIVILEGES;

SHOW DATABASES;
-- SHOW TABLES;
USE telovendo5;


-- Parte 2: Crear dos tablas.
-- La primera almacena a los usuarios de la aplicación (id_usuario, nombre, apellido,
-- contraseña, zona horaria (por defecto UTC-3), género y teléfono de contacto).

-- Creación tabla usuarios.
/*
  - El nombre de la tabla se indica en singular, ya que cada registro guarda 1 usuario
  - Para el campo id_usuario se establece un SMALLINT UNSIGNED porque nos permite almacenar hasta 65535 usuarios que nos parece una cantidad coherente y usa 2 bytes, 
  sin embargo,si se estima registrar más usuarios se tendría que usar un INT que ocupa 4 bytes donde el UNSIGNED almacena máximo 4294967295 lo cual es un número muy elevado. 
  Además se establece NOT NULL porque este campo no podrá tener el valor nulo y el AUTO_INCREMENT nos permitira generar un número único para cada id_usuario, esto en vista 
  que el campo se definirá como PRIMARY KEY (identificará de forma única un registro de la tabla).
  - Respecto a los campos VARCHAR requiere un espacio de (#caracteres + 1) bytes, esto nos permite tener flexibilidad respecto al almacenamiento a diferencia de 
  CHAR(n) donde siempre se utilizará un almacenamiento de n bytes independiente de la cantidad de caracteres escritos.
  - Se necesitará el id_usuario, nombre_usuario, contrasena_usuario y zona_horaria_usuario para persistir un registro, por ello estos campos se han definido NOT NULL.
  - zona_horaria_usuario si no se ingresa por defecto se establecerá en UTC-3.
  - El genero_usuario se define como VARCHAR ya que hoy por inclusividad "podrían" existir más géneros que femenino y masculino.
  - El campo telefono_usuario se definió con un bigint que nos permite almacenar un número con más de 12 digitos con un almacenamiento de 8 bytes, 
  el int quedaba con una cantidad de dígitos bajo lo requerido (10 digitos) y si utilizabamos un varchar(12) se requeriría un almacenamiento de 13 bytes 
  que es superior al bigint.
  - Se define el cotejamiento o juegos de caracteres que se utilizan en utf8mb4.
*/
DROP TABLE IF EXISTS telovendo5.usuario; 
CREATE TABLE telovendo5.usuario (
   id_usuario              SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT, 
   nombre_usuario          VARCHAR(30) NOT NULL, 
   apellido_usuario        VARCHAR(50) DEFAULT '',
   contrasena_usuario      VARCHAR(10) NOT NULL,
   zona_horaria_usuario    VARCHAR(5) NOT NULL DEFAULT 'UTC-3',
   genero_usuario          VARCHAR(20),
   telefono_usuario        BIGINT,
   PRIMARY KEY (id_usuario)
) DEFAULT CHARSET=utf8mb4;
DESCRIBE telovendo5.usuario;

/*
 - Las características para id_ingreso son las mismas que las indicadas para id_usuario de tabla usuario.
 - Cada registro en la tabla ingreso_x_usuario, debe estar asociado a un registro de la tabla usuario, por ello id_usuario de la tabla ingreso_x_usuario 
 se establece con las carácteristicas: SMALLINT UNSIGNED NOT NULL y FOREING KEY hacia usuario.id_usuario. La eliminación es en cascada, 
 es decir, en donde todos los registros relacionados son eliminados de acuerdo a las relaciones de FOREIN KEY.
 - La fecha_hora_ingreso es un datatime (YYYY-MM-DD hh:mm:ss) en vista que nos piden la fecha y hora. 
 - Se define el cotejamiento o juegos de caracteres que se utilizan en utf8mb4
*/
DROP TABLE IF EXISTS telovendo5.ingreso_x_usuario; 
CREATE TABLE telovendo5.ingreso_x_usuario (
   id_ingreso              SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
   id_usuario              SMALLINT UNSIGNED NOT NULL,
   fecha_hora_ingreso      DATETIME DEFAULT NOW(),
   PRIMARY KEY (id_ingreso),
   CONSTRAINT ingreso_x_usuario_ibfk_1  FOREIGN KEY (id_ingreso) REFERENCES telovendo5.usuario (id_usuario) ON DELETE CASCADE
) DEFAULT CHARSET=utf8mb4;
DESCRIBE telovendo5.ingreso_x_usuario;
  
-- Parte 3: Modificación de la tabla
-- Modifique el UTC por defecto.Desde UTC-3 a UTC-2.
ALTER TABLE telovendo5.usuario ALTER zona_horaria_usuario SET DEFAULT 'UTC-2';
DESCRIBE telovendo5.usuario;
  
  
-- Parte 4: Creación de registros.
-- Para cada tabla crea 8 registros.
INSERT INTO telovendo5.usuario ( id_usuario, nombre_usuario, apellido_usuario, contrasena_usuario, genero_usuario, telefono_usuario) 
VALUES (NULL,'Pedro', 'Perez','ERTYUpa2','masculino',987654321),
(NULL,'Juan', 'Gonzales','clave0202','masculino',987564302),
(NULL,'Raúl', 'Romero','clave0303','masculino',987984303),
(NULL,'Ignacio', 'Tapia','clave0404','masculino',987874304),
(NULL,'Claudia', 'Mondaca','clave0505','femenino',987654305),
(NULL,'Pedro', 'Carcamo','clave0606','masculino',987934306),
(NULL,'Sofia', 'Rojas','clave0707','femenino',985554307),
(NULL,'Ana', 'García','clave0808','femenino',988754308);

INSERT INTO telovendo5.ingreso_x_usuario (id_ingreso,id_usuario,fecha_hora_ingreso) 
VALUES (NULL,1, '2022-04-21 21:00:02'),
(NULL,2, '2022-04-21 11:00:12'),
(NULL,3, '2020-04-21 12:40:12'),
(NULL,4, '2022-04-21 13:00:02'),
(NULL,5, '2021-04-21 18:30:18'),
(NULL,6, '2022-04-21 09:00:02'),
(NULL,7, '2020-04-21 08:00:20'),
(NULL,8, '2021-04-21 21:50:02');

/*Mostramos los datos*/
SELECT * FROM telovendo5.usuario;
SELECT * FROM telovendo5.ingreso_x_usuario;
SELECT usuario.id_usuario,usuario.nombre_usuario, usuario.zona_horaria_usuario, ingreso_x_usuario.fecha_hora_ingreso FROM telovendo5.usuario
INNER JOIN telovendo5.ingreso_x_usuario ON usuario.id_usuario=ingreso_x_usuario.id_usuario;


-- Parte 6: Creen una nueva tabla llamada Contactos (id_contacto, id_usuario, numero de telefono, correo electronico).
/*
- Las características para id_contacto son las mismas que las indicadas para id_usuario tabla usuario.
- id_usuario luego será referencia a usuario.id_usuario por ello sus características.
- El campo numero_de_telefono mismo motivo que teléfono en tabla usuario.
- El campo correo_electronico VARCHAR,ya que puede ser de largo variable, almacenamos (n+1) bytes.
- NOT NULL mismos motivos ya mencionados. 
- Se establece UNIQUE para que la combinación (id_usuario,numero_de_telefono) y (id_usuarrio,correo_electronico) sea unica, es decir no registre 2+ veces 
el mismo telefono o correo para un usuario en especifico. 
*/
DROP TABLE IF EXISTS telovendo5.contacto; 
CREATE TABLE telovendo5.contacto (
   id_contacto             SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
   id_usuario              SMALLINT UNSIGNED NOT NULL,  
   numero_de_telefono      BIGINT NOT NULL,
   correo_electronico      VARCHAR(255),
   PRIMARY KEY (id_contacto),
   UNIQUE (id_usuario,numero_de_telefono),
   UNIQUE (id_usuario,correo_electronico)
) DEFAULT CHARSET=utf8mb4;
DESCRIBE telovendo5.contacto; 

-- Parte 7: Modifique la columna teléfono de contacto, para crear un vínculo entre la tabla Usuarios y la tabla Contactos.
/* 
- Cada registro en la tabla contacto, debe estar asociado a un registro de la tabla usuario, por ello id_usuario de la tabla contacto 
se establece con las carácteristicas: SMALLINT UNSIGNED NOT NULL y FOREING KEY hacia usuario.id_usuario. La eliminación es en cascada, 
es decir en donde todos los registros relacionados son eliminados de acuerdo a las relaciones de FOREIN KEY. 
*/
ALTER TABLE telovendo5.contacto ADD CONSTRAINT contacto_ibfk_1 FOREIGN KEY (id_usuario) REFERENCES
telovendo5.usuario(id_usuario) ON DELETE CASCADE;
/*
- La relación hasta acá indicada, permite que un usuario pueda registrar 1 o más telefonos o correos en la tabla contacto.
*/

/* Datos de prueba hasta acá
SELECT * FROM telovendo5.usuario;
INSERT INTO telovendo5.contacto (id_contacto,id_usuario,numero_de_telefono,correo_electronico) VALUES
(NULL,1,1234567890,'algo@gmail.com'),
(NULL,1,1234567892,'algo2@gmail.com'),
(NULL,2,1234567890,'algo@gmail.com'); 
SELECT * FROM telovendo5.contacto;
*/


/*
- Pero como la tabla contacto pide un campo id_usuario entonces implícitamente esta diciendo que debe haber una relación de este campo con usuario.id_usuario 
(el ALTER de arriba), pero a la vez pide modificar el campo telefono de contacto por lo que podemos relacionar por medio de este habia usuario.telefono_usuario.
Es decir en tabla contacto tendremos 2 FOREIGN KEY y para ello debemos hacer UNIQUE el campo usuario.telefono_usuario.
*/
DESCRIBE telovendo5.usuario;
ALTER TABLE telovendo5.usuario ADD UNIQUE (telefono_usuario);
/*Modificando la columna teléfono de contacto ya que se agrega FK */
ALTER TABLE telovendo5.contacto ADD CONSTRAINT contacto_ibfk_2 FOREIGN KEY (numero_de_telefono) REFERENCES
telovendo5.usuario(telefono_usuario);
DESCRIBE telovendo5.contacto;

-- SELECT * FROM telovendo5.usuario;
/*Esto no deja ingresar por el telefono*/
-- INSERT INTO telovendo5.contacto (id_contacto,id_usuario,numero_de_telefono,correo_electronico) VALUES (NULL,2,1234567890,'algo@gmail.com');
/*Esto si permite ingresar puesto que el teléfono es el mismo de la tabla usuario.numero_de_telefono*/
-- INSERT INTO telovendo5.contacto (id_contacto,id_usuario,numero_de_telefono,correo_electronico) VALUES (NULL,2,987564302,'algo@gmail.com');
-- SELECT * FROM telovendo5.contacto;

/*Esta última modificación sólo permitirá ingresar en contacto 1 registro por usuario ya que (contacto.id_usuario,contacto.numero_de_telefono) son UNIQUE y el 
número_de_telefono viene de la tabla usuario donde solo habrá 1 por usuario. */

-- Alojamiento del script en github
-- Dirigirse a carpeta BD de la rama master.
-- https://github.com/DanielaRivas1/AE6-Grupo3-TeloVendo

