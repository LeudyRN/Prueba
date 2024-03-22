-- Crear base de datos
CREATE DATABASE PruebaDB_Shift_Medic_DB_oraora
USER sys IDENTIFIED BY RLN123456e
USER system IDENTIFIED BY RLN123456e
LOGFILE GROUP 1 ('D:\PROGRAMS\ORACLEDB\ORADATA\XE\REDO03.LOG') SIZE 100M,
         GROUP 2 ('D:\PROGRAMS\ORACLEDB\ORADATA\XE\REDO02.LOG') SIZE 100M,
         GROUP 3 ('D:\PROGRAMS\ORACLEDB\ORADATA\XE\REDO01.LOG') SIZE 100M
MAXLOGFILES 5
MAXLOGMEMBERS 5
MAXDATAFILES 100
CHARACTER SET utf8
DEFAULT TABLESPACE xeXDB
DEFAULT TEMPORARY TABLESPACE TEMP;

CREATE DATABASE PruebaDB_Shift_Medic_DB_oraora22222
CHARACTER SET utf8
DEFAULT TABLESPACE xeXDB
DEFAULT TEMPORARY TABLESPACE TEMP;

CREATE USER leudyrn IDENTIFIED BY RLN12345e;


-- Creación de la tabla Planes de Seguro
CREATE TABLE Planes_de_Seguro (
    ID_Plan_Seguro INTEGER PRIMARY KEY,
    Nombre_Plan VARCHAR(100),
    Tipo_Plan VARCHAR(50) CHECK (Tipo_Plan IN ('Individual', 'Familiar', 'Corporativo')),
    Cobertura_Medica VARCHAR(200),
    Fecha_Inicio_Cobertura DATE,
    Fecha_Termino DATE
);

-- Creación de la tabla Medicamentos
CREATE TABLE Medicamentos (
    ID_Medicamento NUMBER PRIMARY KEY,
    Nombre VARCHAR2(100),
    Presentacion VARCHAR2(100),
    Utilidad VARCHAR2(200),
    Precio NUMBER
);

-- Creación de la tabla Pacientes
CREATE TABLE Pacientes (
    ID_Paciente INTEGER PRIMARY KEY,
    Nombre VARCHAR(100) DEFAULT 'Sin Nombre',
    Cedula VARCHAR(20),
    Fecha_Nacimiento DATE,
    Genero VARCHAR(10) CHECK (Genero IN ('Masculino', 'Femenino', 'Otro')),
    Direccion VARCHAR(200),
    Telefono VARCHAR(15),
    Email VARCHAR(100),
    ID_Plan_Seguro INTEGER,
    CONSTRAINT fk_Plan_Seguro FOREIGN KEY (ID_Plan_Seguro) REFERENCES Planes_de_Seguro(ID_Plan_Seguro)
);

CREATE INDEX idx_Planes_de_Seguro_Nombre_Plan ON Planes_de_Seguro(Nombre_Plan);

-- Creación de la tabla Centros de atención médica
CREATE TABLE Centros_Atencion (
    ID_Centro NUMBER PRIMARY KEY,
    Tipo_Centro VARCHAR2(50),
    ID_Seguro_Aceptado NUMBER,
    CONSTRAINT fk_Seguro_Aceptado FOREIGN KEY (ID_Seguro_Aceptado) REFERENCES Planes_de_Seguro(ID_Plan_Seguro)
);

-- Creación de la tabla Proveedor de atención médica
CREATE TABLE Proveedor_Atencion_Medica (
    ID_Proveedor NUMBER PRIMARY KEY,
    Nombre_Proveedor VARCHAR2(100),
    Especialidad_Proveedor VARCHAR2(50),
    Direccion VARCHAR2(200),
    Telefono VARCHAR2(15),
    Email VARCHAR2(100),
    Numero_Identificacion_Fiscal VARCHAR2(20),
    Tipo_Proveedor VARCHAR2(50)
);

-- Creación de la tabla Hospitales
CREATE TABLE Hospitales (
    ID_Hospital NUMBER PRIMARY KEY,
    Nombre_Hospital VARCHAR2(100),
    Direccion VARCHAR2(200),
    Telefono VARCHAR2(15),
    Numero_Identificacion_Fiscal VARCHAR2(20)
);

-- Creación de la tabla Clínica
CREATE TABLE Clinica (
    ID_Clinica NUMBER PRIMARY KEY,
    Nombre_Clinica VARCHAR2(100),
    Direccion VARCHAR2(200),
    Telefono VARCHAR2(15),
    Numero_Identificacion_Fiscal VARCHAR2(20)
);

-- Creación de la tabla Consultorios
CREATE TABLE Consultorios (
    ID_Consultorio NUMBER PRIMARY KEY,
    Nombre_Consultorio VARCHAR2(100),
    Direccion VARCHAR2(200),
    Telefono VARCHAR2(15),
    Numero_Identificacion_Fiscal VARCHAR2(20)
);

-- Creación de la tabla Farmacia
CREATE TABLE Farmacia (
    ID_Farmacia NUMBER PRIMARY KEY,
    Nombre VARCHAR2(100),
    Direccion VARCHAR2(200),
    Telefono VARCHAR2(15),
    Horario VARCHAR2(50),
    ID_Medicamento NUMBER,
    CONSTRAINT fk_Medicamento FOREIGN KEY (ID_Medicamento) REFERENCES Medicamentos(ID_Medicamento)
);

-- Creación de la tabla Solicitud de autorización
CREATE TABLE Solicitud_Autorizacion (
    ID_Solicitud NUMBER PRIMARY KEY,
    ID_Paciente NUMBER,
    Tipo_Servicio_Solicitado VARCHAR2(100),
    Estado_Solicitud VARCHAR2(100),
    CONSTRAINT fk_Paciente FOREIGN KEY (ID_Paciente) REFERENCES Pacientes(ID_Paciente)
);

-- Creación de la tabla Autorización
CREATE TABLE Autorizacion (
    ID_Autorizacion NUMBER PRIMARY KEY,
    ID_Solicitud NUMBER, -- Ajusta esta parte según tu diseño de base de datos
    Fecha_Autorizacion DATE,
    Tipo_Servicio_Autorizado VARCHAR2(100),
    Monto_Autorizado NUMBER
);

-- Creacion de la tabla Cita_Medica
CREATE TABLE Cita_Medica (
    ID_Cita NUMBER PRIMARY KEY,
    ID_Paciente NUMBER,
    ID_Proveedor NUMBER,
    ID_Centro_Atencion NUMBER,
    Fecha_Cita DATE,
    Razon_Cita VARCHAR2(200),
    Costo NUMBER,
    Estado VARCHAR2(50),
    CONSTRAINT fk_Cita_Medica_Paciente FOREIGN KEY (ID_Paciente) REFERENCES Pacientes(ID_Paciente),
    CONSTRAINT fk_Cita_Medica_Proveedor FOREIGN KEY (ID_Proveedor) REFERENCES Proveedor_Atencion_Medica(ID_Proveedor),
    CONSTRAINT fk_Cita_Medica_Centro_Atencion FOREIGN KEY (ID_Centro_Atencion) REFERENCES Centros_Atencion(ID_Centro)
);

-- Creacion de la tabla Historial_Medico
CREATE TABLE Historial_Médico (
    ID_Historial NUMBER PRIMARY KEY,
    ID_Paciente NUMBER,
    ID_Proveedor NUMBER,
    Fecha_Visita DATE,
    Diagnostico VARCHAR2(200),
    Tratamiento_Prescrito VARCHAR2(200),
    Medicamento_Recetado VARCHAR2(100),
    CONSTRAINT fk_Historial_Medico_Paciente FOREIGN KEY (ID_Paciente) REFERENCES Pacientes(ID_Paciente)
);

-- Creación de la tabla Facturas
CREATE TABLE Facturas (
    ID_Factura NUMBER PRIMARY KEY,
    ID_Paciente NUMBER,
    ID_Proveedor NUMBER,
    ID_Medicamento NUMBER,
    Fecha_Factura DATE,
    Descripcion_Servicio VARCHAR2(200),
    Monto_Facturado NUMBER,
    Estado VARCHAR2(50),
    CONSTRAINT fk_Paciente_Facturas FOREIGN KEY (ID_Paciente) REFERENCES Pacientes(ID_Paciente),
    CONSTRAINT fk_Proveedor_Facturas FOREIGN KEY (ID_Proveedor) REFERENCES Proveedor_Atencion_Medica(ID_Proveedor),
    CONSTRAINT fk_Medicamento_Facturas FOREIGN KEY (ID_Medicamento) REFERENCES Medicamentos(ID_Medicamento)
);

-- Creación de la tabla Pago
CREATE TABLE Pago (
    ID_Pago NUMBER PRIMARY KEY,
    ID_Factura NUMBER,
    ID_Paciente NUMBER,
    Fecha_Pago DATE,
    Monto_Pagado NUMBER,
    Metodo_Pago VARCHAR2(50),
    CONSTRAINT fk_Factura_Pago FOREIGN KEY (ID_Factura) REFERENCES Facturas(ID_Factura)
);

-- Creación de la tabla Reclamación
CREATE TABLE Reclamacion (
    ID_Reclamacion NUMBER PRIMARY KEY,
    ID_Paciente NUMBER,
    ID_Proveedor NUMBER,
    Fecha_Reclamacion DATE,
    Servicio_Reclamado VARCHAR2(200),
    Monto_Reclamado NUMBER,
    Estado VARCHAR2(50),
    CONSTRAINT fk_Reclamacion_Paciente FOREIGN KEY (ID_Paciente) REFERENCES Pacientes(ID_Paciente),
    CONSTRAINT fk_Reclamacion_Proveedor FOREIGN KEY (ID_Proveedor) REFERENCES Proveedor_Atencion_Medica(ID_Proveedor)
);


-- Creacion de la tabla auditoria_FACTURAS (PARA EL USO DE LOS TRIGGER)
CREATE TABLE Auditoria_Facturas (
    ID_Factura NUMBER,
    Fecha_Actualizacion DATE,
    Usuario VARCHAR2(100)
);

-- Creacion de usuario
ALTER SESSION SET "_ORACLE_SCRIPT"=true;

CREATE USER usuario1 IDENTIFIED BY Soporte20;
CREATE USER usuario2 IDENTIFIED BY Soporte40;
CREATE USER usuario3 IDENTIFIED BY Soporte60;

-- Creacion de las vistas
CREATE VIEW vista1 AS SELECT * FROM Pacientes;
CREATE VIEW vista2 AS SELECT * FROM Proveedor_Atencion_Medica;
CREATE VIEW vista3 AS SELECT * FROM Facturas;

-- Creacion de Triggers
CREATE SEQUENCE SEQ_PACIENTES START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE TRIGGER trigger1
BEFORE INSERT ON Pacientes
FOR EACH ROW
BEGIN
   -- Verificar si el campo de correo electrónico está en un formato válido
   IF NOT REGEXP_LIKE(:NEW.Email, '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$') THEN
      RAISE_APPLICATION_ERROR(-20001, 'El correo electrónico proporcionado no es válido');
   END IF;

   -- Generar un ID único para cada paciente si la secuencia existe
   IF NOT :NEW.ID_Paciente IS NOT NULL THEN
      SELECT SEQ_PACIENTES.NEXTVAL INTO :NEW.ID_Paciente FROM dual;
   END IF;
END;
/

CREATE OR REPLACE TRIGGER trigger2
AFTER UPDATE ON Facturas
FOR EACH ROW
BEGIN
   -- Registrar la actualización en un registro de auditoría si la tabla Auditoria_Facturas existe
   BEGIN
      INSERT INTO Auditoria_Facturas (ID_Factura, Fecha_Actualizacion, Usuario) 
      VALUES (:OLD.ID_Factura, SYSDATE, USER);
   EXCEPTION
      WHEN OTHERS THEN
         NULL;
   END;
END;
/

CREATE OR REPLACE TRIGGER trigger3
AFTER DELETE ON Proveedor_Atencion_Medica
FOR EACH ROW
BEGIN
   -- Eliminar todos los registros relacionados en otras tablas si las tablas existen
   BEGIN
      DELETE FROM Facturas WHERE ID_Proveedor = :OLD.ID_Proveedor;
      DELETE FROM Centros_Atencion WHERE ID_Seguro_Aceptado = :OLD.ID_Proveedor;
      -- Notificar al administrador sobre la eliminación del proveedor si dbms_output está habilitado
      dbms_output.put_line('Se eliminó el proveedor ' || :OLD.Nombre_Proveedor || ' (ID: ' || :OLD.ID_Proveedor || ')');
   EXCEPTION
      WHEN OTHERS THEN
         NULL;
   END;
END;
/


-- Creacion de procedure
CREATE OR REPLACE PROCEDURE actualizar_paciente(
    p_id_paciente IN NUMBER,
    p_nombre IN VARCHAR2,
    p_cedula IN VARCHAR2,
    p_fecha_nacimiento IN DATE,
    p_genero IN VARCHAR2,
    p_direccion IN VARCHAR2,
    p_telefono IN VARCHAR2,
    p_email IN VARCHAR2,
    p_id_plan_seguro IN NUMBER
) AS
BEGIN
    UPDATE Pacientes
    SET Nombre = p_nombre,
        Cedula = p_cedula,
        Fecha_Nacimiento = p_fecha_nacimiento,
        Genero = p_genero,
        Direccion = p_direccion,
        Telefono = p_telefono,
        Email = p_email,
        ID_Plan_Seguro = p_id_plan_seguro
    WHERE ID_Paciente = p_id_paciente;
END;
/

CREATE OR REPLACE PROCEDURE calcular_costo_total(
    p_id_paciente IN NUMBER,
    p_costo_total OUT NUMBER
) AS
BEGIN
    SELECT SUM(Monto_Facturado) INTO p_costo_total
    FROM Facturas
    WHERE ID_Paciente = p_id_paciente;
END;
/

CREATE OR REPLACE PROCEDURE nueva_solicitud_autorizacion(
    p_id_paciente IN NUMBER,
    p_tipo_servicio_solicitado IN VARCHAR2,
    p_estado_solicitud IN VARCHAR2
) AS
BEGIN
    INSERT INTO Solicitud_Autorizacion(ID_Paciente, Tipo_Servicio_Solicitado, Estado_Solicitud)
    VALUES (p_id_paciente, p_tipo_servicio_solicitado, p_estado_solicitud);
END;
/


-- Creacion de sinonimos:
CREATE SYNONYM sinonimo1 FOR Facturas;
CREATE SYNONYM sinonimo2 FOR Proveedor_Atencion_Medica;
CREATE SYNONYM sinonimo3 FOR Pacientes;

-- Creacion de jobs
BEGIN
    DBMS_SCHEDULER.CREATE_JOB(
        job_name        => 'job1',
        job_type        => 'PLSQL_BLOCK',
        job_action      => 'BEGIN actualizar_paciente; END;',
        start_date      => SYSTIMESTAMP,
        repeat_interval => 'FREQ=DAILY; INTERVAL=1',
        end_date        => NULL,
        enabled         => TRUE
    );
END;
/

BEGIN
    DBMS_SCHEDULER.CREATE_JOB(
        job_name        => 'job2',
        job_type        => 'PLSQL_BLOCK',
        job_action      => 'BEGIN calcular_costo_total; END;',
        start_date      => SYSTIMESTAMP,
        repeat_interval => 'FREQ=WEEKLY; INTERVAL=1',
        end_date        => NULL,
        enabled         => TRUE
    );
END;
/

BEGIN
    DBMS_SCHEDULER.CREATE_JOB(
        job_name        => 'job3',
        job_type        => 'PLSQL_BLOCK',
        job_action      => 'BEGIN nueva_solicitud_autorizacion; END;',
        start_date      => SYSTIMESTAMP,
        repeat_interval => 'FREQ=MONTHLY; INTERVAL=1',
        end_date        => NULL,
        enabled         => TRUE
    );
END;
/


--  Creacion de dblink
CREATE DATABASE LINK dblink_to_remote
CONNECT TO usuario_remote IDENTIFIED BY password_remote
USING 'nombre_tns';


-- Scripts para la introduccion de datos a las tablas

-- Inserción de datos en la tabla Planes_de_Seguro
INSERT INTO Planes_de_Seguro (ID_Plan_Seguro, Nombre_Plan, Tipo_Plan, Cobertura_Medica, Fecha_Inicio_Cobertura, Fecha_Termino)
VALUES (1, 'Plan Básico', 'Individual', 'Cobertura básica de salud', TO_DATE('2024-01-01', 'YYYY-MM-DD'), TO_DATE('2025-01-01', 'YYYY-MM-DD'));

-- Inserción de datos en la tabla Medicamentos
INSERT INTO Medicamentos (ID_Medicamento, Nombre, Presentacion, Utilidad, Precio)
VALUES (1, 'Paracetamol', 'Tabletas', 'Alivio del dolor y la fiebre', 10.50);

-- Inserción de datos en la tabla Pacientes
INSERT INTO Pacientes (ID_Paciente, Nombre, Cedula, Fecha_Nacimiento, Genero, Direccion, Telefono, Email, ID_Plan_Seguro)
VALUES (1, 'Juan Pérez', '123456789', TO_DATE('1990-05-15', 'YYYY-MM-DD'), 'Masculino', 'Calle 123', '1234567890', 'juan@example.com', 1);

-- Inserción de datos en la tabla Centros_Atencion
INSERT INTO Centros_Atencion (ID_Centro, Tipo_Centro, ID_Seguro_Aceptado)
VALUES (1, 'Hospital', 1);

-- Inserción de datos en la tabla Proveedor_Atencion_Medica
INSERT INTO Proveedor_Atencion_Medica (ID_Proveedor, Nombre_Proveedor, Especialidad_Proveedor, Direccion, Telefono, Email, Numero_Identificacion_Fiscal, Tipo_Proveedor)
VALUES (1, 'Clínica XYZ', 'Cardiología', 'Avenida Principal', '987654321', 'info@clinica.com', 'ABC123', 'Clínica');

-- Inserción de datos en la tabla Hospitales
INSERT INTO Hospitales (ID_Hospital, Nombre_Hospital, Direccion, Telefono, Numero_Identificacion_Fiscal)
VALUES (1, 'Hospital ABC', 'Calle Principal', '987654321', 'DEF456');

-- Inserción de datos en la tabla Clínica
INSERT INTO Clinica (ID_Clinica, Nombre_Clinica, Direccion, Telefono, Numero_Identificacion_Fiscal)
VALUES (1, 'Clínica XYZ', 'Avenida Central', '123456789', 'GHI789');

-- Inserción de datos en la tabla Consultorios
INSERT INTO Consultorios (ID_Consultorio, Nombre_Consultorio, Direccion, Telefono, Numero_Identificacion_Fiscal)
VALUES (1, 'Consultorio Dr. Pérez', 'Plaza Principal', '987654321', 'JKL012');

-- Inserción de datos en la tabla Farmacia
INSERT INTO Farmacia (ID_Farmacia, Nombre, Direccion, Telefono, Horario, ID_Medicamento)
VALUES (1, 'Farmacia Popular', 'Avenida Comercial', '123456789', '8:00 AM - 10:00 PM', 1);

-- Inserción de datos en la tabla Solicitud_Autorizacion
INSERT INTO Solicitud_Autorizacion (ID_Solicitud, ID_Paciente, Tipo_Servicio_Solicitado, Estado_Solicitud)
VALUES (1, 1, 'Consulta Médica', 'Pendiente');

-- Inserción de datos en la tabla Autorizacion
INSERT INTO Autorizacion (ID_Autorizacion, ID_Solicitud, Fecha_Autorizacion, Tipo_Servicio_Autorizado, Monto_Autorizado)
VALUES (1, 1, TO_DATE('2024-03-18', 'YYYY-MM-DD'), 'Consulta Médica', 50.00);

-- Inserción de datos en la tabla Cita_Medica
INSERT INTO Cita_Medica (ID_Cita, ID_Paciente, ID_Proveedor, ID_Centro_Atencion, Fecha_Cita, Razon_Cita, Costo, Estado)
VALUES (1, 1, 1, 1, TO_DATE('2024-03-20', 'YYYY-MM-DD'), 'Consulta de rutina', 50.00, 'Programada');

-- Inserción de datos en la tabla Historial_Médico
INSERT INTO Historial_Médico (ID_Historial, ID_Paciente, ID_Proveedor, Fecha_Visita, Diagnostico, Tratamiento_Prescrito, Medicamento_Recetado)
VALUES (1, 1, 1, TO_DATE('2024-03-20', 'YYYY-MM-DD'), 'Sin diagnóstico', 'Reposo', 'Paracetamol');

-- Inserción de datos en la tabla Facturas
INSERT INTO Facturas (ID_Factura, ID_Paciente, ID_Proveedor, ID_Medicamento, Fecha_Factura, Descripcion_Servicio, Monto_Facturado, Estado)
VALUES (1, 1, 1, 1, TO_DATE('2024-03-20', 'YYYY-MM-DD'), 'Consulta de rutina', 50.00, 'Pagada');

-- Inserción de datos en la tabla Pago
INSERT INTO Pago (ID_Pago, ID_Factura, ID_Paciente, Fecha_Pago, Monto_Pagado, Metodo_Pago)
VALUES (1, 1, 1, TO_DATE('2024-03-21', 'YYYY-MM-DD'), 50.00, 'Efectivo');

-- Inserción de datos en la tabla Reclamacion
INSERT INTO Reclamacion (ID_Reclamacion, ID_Paciente, ID_Proveedor, Fecha_Reclamacion, Servicio_Reclamado, Monto_Reclamado, Estado)
VALUES (1, 1, 1, TO_DATE('2024-03-21', 'YYYY-MM-DD'), 'Consulta de rutina', 50.00, 'En revisión');


-- Select para todas las tablas
SELECT * FROM Planes_de_Seguro;
SELECT * FROM Medicamentos;
SELECT * FROM Pacientes;
SELECT * FROM Centros_Atencion;
SELECT * FROM Proveedor_Atencion_Medica;
SELECT * FROM Hospitales;
SELECT * FROM Clinica;
SELECT * FROM Consultorios;
SELECT * FROM Farmacia;
SELECT * FROM Solicitud_Autorizacion;
SELECT * FROM Autorizacion;
SELECT * FROM Historial_Médico;
SELECT * FROM Facturas;
SELECT * FROM Pago;
SELECT * FROM Reclamacion;
SELECT * FROM Auditoria_Facturas;


-- Select de las vistas
SELECT * FROM Vista_Pacientes_Planes_Seguro;
Select * from Vista_Facturas_Detallada;
Select * from Vista_Medicamentos_Farmacias;
Select * from Vista_Citas_Medicas;
Select * from Vista_Historial_Medico;

-- Creacion de las vista

-- Creacion de la vista Pacientes con su Plan seguro
CREATE VIEW Vista_Pacientes_Planes_Seguro AS
SELECT p.ID_Paciente, p.Nombre AS Nombre_Paciente, p.Cedula, p.Fecha_Nacimiento, p.Genero,
       p.Direccion, p.Telefono, p.Email, ps.Nombre_Plan AS Plan_Seguro
FROM Pacientes p
LEFT JOIN Planes_de_Seguro ps ON p.ID_Plan_Seguro = ps.ID_Plan_Seguro;

-- Creacion de la vista facturas con informacion detallada de los pacientes y proveedores:
CREATE VIEW Vista_Facturas_Detallada AS
SELECT f.ID_Factura, p.Nombre AS Nombre_Paciente, pr.Nombre_Proveedor, f.Fecha_Factura,
       f.Descripcion_Servicio, f.Monto_Facturado, f.Estado
FROM Facturas f
INNER JOIN Pacientes p ON f.ID_Paciente = p.ID_Paciente
INNER JOIN Proveedor_Atencion_Medica pr ON f.ID_Proveedor = pr.ID_Proveedor;

-- Creacion de la vista de medicamentos con informacion de las farmacias que la tienen disponibles
CREATE VIEW Vista_Medicamentos_Farmacias AS
SELECT m.ID_Medicamento, m.Nombre AS Nombre_Medicamento, m.Presentacion, m.Utilidad, m.Precio,
       fa.Nombre AS Nombre_Farmacia, fa.Direccion AS Direccion_Farmacia, fa.Telefono AS Telefono_Farmacia
FROM Medicamentos m
INNER JOIN Farmacia fa ON m.ID_Medicamento = fa.ID_Medicamento;

-- Creacion de la vista citas medicas con detalles de pacientes, proveedores y centros de atencion
CREATE VIEW Vista_Citas_Medicas AS
SELECT cm.ID_Cita, p.Nombre AS Nombre_Paciente, pr.Nombre_Proveedor, ca.Tipo_Centro,
       cm.Fecha_Cita, cm.Razon_Cita, cm.Costo, cm.Estado
FROM Cita_Medica cm
INNER JOIN Pacientes p ON cm.ID_Paciente = p.ID_Paciente
INNER JOIN Proveedor_Atencion_Medica pr ON cm.ID_Proveedor = pr.ID_Proveedor
INNER JOIN Centros_Atencion ca ON cm.ID_Centro_Atencion = ca.ID_Centro;

-- Creacion de la vista historial medico con la informacion detallada de pacientes y proveedores
CREATE VIEW Vista_Historial_Medico AS
SELECT hm.ID_Historial, p.Nombre AS Nombre_Paciente, pr.Nombre_Proveedor,
       hm.Fecha_Visita, hm.Diagnostico, hm.Tratamiento_Prescrito, hm.Medicamento_Recetado
FROM Historial_Médico hm
INNER JOIN Pacientes p ON hm.ID_Paciente = p.ID_Paciente
INNER JOIN Proveedor_Atencion_Medica pr ON hm.ID_Proveedor = pr.ID_Proveedor;