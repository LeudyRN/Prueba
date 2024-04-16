
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
CREATE INDEX idx_nombre_paciente ON Pacientes(Nombre);

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

CREATE INDEX idx_id_paciente_historial
ON Historial_Médico(ID_Paciente);

CREATE INDEX idx_id_proveedor_historial
ON Historial_Médico(ID_Proveedor);

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

CREATE INDEX idx_id_paciente_facturas ON Facturas(ID_Paciente);

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

--Para probar el trigger 1

/* Cuando se ejecuta el insert, este falla y generara un error por: Corre_invalido, esto es por el trigger 1
Se tiene que tirar el select en la secuencia SEQ_PACIENTES.nextval, para validar el incremento cada vez que falla

Al principio dira uno, cuando falle debe de decir 2 y asi sucesivamente

*/

Select * from pacientes

INSERT INTO Pacientes (ID_Paciente, Nombre, Cedula, Fecha_Nacimiento, Genero, Direccion, Telefono, Email, ID_Plan_Seguro) 
VALUES (20, 'Maria Gomez', '12245525633', TO_DATE('1990-08-17', 'YYYY-MM-DD'), 'Femenino', 'Calle 60', '1234567890', 'correo_invalido', 1); 

SELECT SEQ_PACIENTES.nextval FROM dual;

------------------------------------------------------------
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

--Para probar el trigger2
INSERT INTO Facturas (ID_Factura, ID_Paciente, ID_Proveedor, ID_Medicamento, Fecha_Factura, Descripcion_Servicio, Monto_Facturado, Estado) 
VALUES (123, 1, 1, 1, TO_DATE('2024-03-20', 'YYYY-MM-DD'), 'Consulta de rutina', 50.00, 'Pagada'); 

UPDATE Facturas SET Monto_Facturado = 60.00 WHERE ID_Factura = 123;

Select * from auditoria_facturas;

----------------------------------------------------------------------------
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

-- Para probar el Trigger 3
INSERT INTO Proveedor_Atencion_Medica (ID_Proveedor, Nombre_Proveedor, Especialidad_Proveedor, Direccion, Telefono, Email, Numero_Identificacion_Fiscal, Tipo_Proveedor) 

VALUES (456, 'Clínica XYZ', 'Cardiología', 'Avenida Principal', '987654321', 'info@clinica.com', 'ABC123', 'Clínica'); 

DELETE FROM Proveedor_Atencion_Medica WHERE ID_Proveedor = 456;

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
        job_action      => 'BEGIN actualizar_paciente(id_paciente); END;', 
        start_date      => SYSTIMESTAMP, 
        repeat_interval => 'FREQ=MINUTELY; INTERVAL=1', 
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
        repeat_interval => 'FREQ=MINUTELY; INTERVAL=1',
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
        repeat_interval => 'FREQ=MINUTELY; INTERVAL=1',
        end_date        => NULL,
        enabled         => TRUE
    );
END;
/

SELECT * FROM USER_SCHEDULER_JOB_RUN_DETAILS;


--  Creacion de dblink
GRANT CREATE DATABASE LINK TO usuario1;
GRANT CREATE SESSION TO usuario1;


CREATE DATABASE LINK dblink_to_remote
CONNECT TO usuario1 IDENTIFIED BY Soporte20
USING 'XE';


-- Scripts para la introduccion de datos a las tablas

-- Inserción de datos en la tabla Planes_de_Seguro

-- Insert para Plan Individual
INSERT INTO Planes_de_Seguro (ID_Plan_Seguro, Nombre_Plan, Tipo_Plan, Cobertura_Medica, Fecha_Inicio_Cobertura, Fecha_Termino)
VALUES (1, 'Plan Básico', 'Individual', 'Cobertura básica de salud', TO_DATE('2024-01-01', 'YYYY-MM-DD'), TO_DATE('2025-01-01', 'YYYY-MM-DD'));

-- Insert para Plan Familiar
INSERT INTO Planes_de_Seguro (ID_Plan_Seguro, Nombre_Plan, Tipo_Plan, Cobertura_Medica, Fecha_Inicio_Cobertura, Fecha_Termino)
VALUES (2, 'Plan Extendido', 'Familiar', 'Cobertura para toda la familia', TO_DATE('2024-01-01', 'YYYY-MM-DD'), TO_DATE('2025-01-01', 'YYYY-MM-DD'));

-- Insert para Plan Corporativo
INSERT INTO Planes_de_Seguro (ID_Plan_Seguro, Nombre_Plan, Tipo_Plan, Cobertura_Medica, Fecha_Inicio_Cobertura, Fecha_Termino)
VALUES (3, 'Plan Empresarial', 'Corporativo', 'Cobertura para empleados corporativos', TO_DATE('2024-01-01', 'YYYY-MM-DD'), TO_DATE('2025-01-01', 'YYYY-MM-DD'));

-- Insert para Plan Individual (2)
INSERT INTO Planes_de_Seguro (ID_Plan_Seguro, Nombre_Plan, Tipo_Plan, Cobertura_Medica, Fecha_Inicio_Cobertura, Fecha_Termino)
VALUES (4, 'Plan Especial', 'Individual', 'Cobertura especializada', TO_DATE('2024-01-01', 'YYYY-MM-DD'), TO_DATE('2025-01-01', 'YYYY-MM-DD'));

-- Insert para Plan Familiar (2)
INSERT INTO Planes_de_Seguro (ID_Plan_Seguro, Nombre_Plan, Tipo_Plan, Cobertura_Medica, Fecha_Inicio_Cobertura, Fecha_Termino)
VALUES (5, 'Plan Plus', 'Familiar', 'Cobertura premium para familia', TO_DATE('2024-01-01', 'YYYY-MM-DD'), TO_DATE('2025-01-01', 'YYYY-MM-DD'));

-- Insert para Plan Corporativo (2)
INSERT INTO Planes_de_Seguro (ID_Plan_Seguro, Nombre_Plan, Tipo_Plan, Cobertura_Medica, Fecha_Inicio_Cobertura, Fecha_Termino)
VALUES (6, 'Plan Elite', 'Corporativo', 'Cobertura exclusiva para corporaciones', TO_DATE('2024-01-01', 'YYYY-MM-DD'), TO_DATE('2025-01-01', 'YYYY-MM-DD'));

-- Insert para Plan Individual (3)
INSERT INTO Planes_de_Seguro (ID_Plan_Seguro, Nombre_Plan, Tipo_Plan, Cobertura_Medica, Fecha_Inicio_Cobertura, Fecha_Termino)
VALUES (7, 'Plan Premium', 'Individual', 'Cobertura de lujo', TO_DATE('2024-01-01', 'YYYY-MM-DD'), TO_DATE('2025-01-01', 'YYYY-MM-DD'));

-- Insert para Plan Familiar (3)
INSERT INTO Planes_de_Seguro (ID_Plan_Seguro, Nombre_Plan, Tipo_Plan, Cobertura_Medica, Fecha_Inicio_Cobertura, Fecha_Termino)
VALUES (8, 'Plan Avanzado', 'Familiar', 'Cobertura avanzada para familia', TO_DATE('2024-01-01', 'YYYY-MM-DD'), TO_DATE('2025-01-01', 'YYYY-MM-DD'));

-- Insert para Plan Corporativo (3)
INSERT INTO Planes_de_Seguro (ID_Plan_Seguro, Nombre_Plan, Tipo_Plan, Cobertura_Medica, Fecha_Inicio_Cobertura, Fecha_Termino)
VALUES (9, 'Plan Empresarial Plus', 'Corporativo', 'Cobertura premium para empresas', TO_DATE('2024-01-01', 'YYYY-MM-DD'), TO_DATE('2025-01-01', 'YYYY-MM-DD'));

-- Insert para Plan Individual (4)
INSERT INTO Planes_de_Seguro (ID_Plan_Seguro, Nombre_Plan, Tipo_Plan, Cobertura_Medica, Fecha_Inicio_Cobertura, Fecha_Termino)
VALUES (10, 'Plan Estándar', 'Individual', 'Cobertura estándar', TO_DATE('2024-01-01', 'YYYY-MM-DD'), TO_DATE('2025-01-01', 'YYYY-MM-DD'));

-- Inserción de datos en la tabla Medicamentos
INSERT INTO Medicamentos (ID_Medicamento, Nombre, Presentacion, Utilidad, Precio)
VALUES (1, 'Paracetamol', 'Tabletas', 'Alivio del dolor y la fiebre', 10.50);

INSERT INTO Medicamentos (ID_Medicamento, Nombre, Presentacion, Utilidad, Precio)
VALUES (101, 'Ibuprofeno', 'Tabletas', 'Alivio del dolor e inflamación', 12.99);

INSERT INTO Medicamentos (ID_Medicamento, Nombre, Presentacion, Utilidad, Precio)
VALUES (102, 'Amoxicilina', 'Cápsulas', 'Antibiótico para infecciones', 15.75);

INSERT INTO Medicamentos (ID_Medicamento, Nombre, Presentacion, Utilidad, Precio)
VALUES (103, 'Omeprazol', 'Cápsulas', 'Tratamiento de úlceras y acidez', 8.45);

INSERT INTO Medicamentos (ID_Medicamento, Nombre, Presentacion, Utilidad, Precio)
VALUES (104, 'Loratadina', 'Tabletas', 'Antihistamínico para alergias', 9.20);

INSERT INTO Medicamentos (ID_Medicamento, Nombre, Presentacion, Utilidad, Precio)
VALUES (105, 'Ciprofloxacino', 'Tabletas', 'Antibiótico de amplio espectro', 14.30);

INSERT INTO Medicamentos (ID_Medicamento, Nombre, Presentacion, Utilidad, Precio)
VALUES (106, 'Dipirona', 'Solución Inyectable', 'Analgésico y antipirético', 7.80);

INSERT INTO Medicamentos (ID_Medicamento, Nombre, Presentacion, Utilidad, Precio)
VALUES (107, 'Lansoprazol', 'Cápsulas', 'Tratamiento de úlceras y acidez', 10.15);

INSERT INTO Medicamentos (ID_Medicamento, Nombre, Presentacion, Utilidad, Precio)
VALUES (108, 'Salbutamol', 'Inhalador', 'Broncodilatador para el asma', 18.65);

INSERT INTO Medicamentos (ID_Medicamento, Nombre, Presentacion, Utilidad, Precio)
VALUES (109, 'Clonazepam', 'Tabletas', 'Tratamiento de la ansiedad', 11.50);

INSERT INTO Medicamentos (ID_Medicamento, Nombre, Presentacion, Utilidad, Precio)
VALUES (110, 'Atorvastatina', 'Tabletas', 'Reducción del colesterol', 20.80);


-- Inserción de datos en la tabla Pacientes
INSERT INTO Pacientes (ID_Paciente, Nombre, Cedula, Fecha_Nacimiento, Genero, Direccion, Telefono, Email, ID_Plan_Seguro)
VALUES (1, 'Juan Pérez', '123456789', TO_DATE('1990-05-15', 'YYYY-MM-DD'), 'Masculino', 'Calle 123', '1234567890', 'juan@example.com', 1);

INSERT INTO Pacientes (ID_Paciente, Nombre, Cedula, Fecha_Nacimiento, Genero, Direccion, Telefono, Email, ID_Plan_Seguro)
VALUES (101, 'María García', '987654321', TO_DATE('1985-08-25', 'YYYY-MM-DD'), 'Femenino', 'Avenida Principal 456', '9876543210', 'maria@example.com', 2);

INSERT INTO Pacientes (ID_Paciente, Nombre, Cedula, Fecha_Nacimiento, Genero, Direccion, Telefono, Email, ID_Plan_Seguro)
VALUES (102, 'Pedro López', '456789123', TO_DATE('1978-10-10', 'YYYY-MM-DD'), 'Masculino', 'Calle Secundaria 789', '4567891230', 'pedro@example.com', 3);

INSERT INTO Pacientes (ID_Paciente, Nombre, Cedula, Fecha_Nacimiento, Genero, Direccion, Telefono, Email, ID_Plan_Seguro)
VALUES (103, 'Ana Martínez', '654321987', TO_DATE('1992-03-20', 'YYYY-MM-DD'), 'Femenino', 'Calle 5 de Mayo', '6543219870', 'ana@example.com', 1);

INSERT INTO Pacientes (ID_Paciente, Nombre, Cedula, Fecha_Nacimiento, Genero, Direccion, Telefono, Email, ID_Plan_Seguro)
VALUES (104, 'Carlos Rodríguez', '321987654', TO_DATE('1980-06-12', 'YYYY-MM-DD'), 'Masculino', 'Avenida Central 789', '3219876540', 'carlos@example.com', 2);

INSERT INTO Pacientes (ID_Paciente, Nombre, Cedula, Fecha_Nacimiento, Genero, Direccion, Telefono, Email, ID_Plan_Seguro)
VALUES (105, 'Laura Sánchez', '789321654', TO_DATE('1995-12-05', 'YYYY-MM-DD'), 'Femenino', 'Calle Principal 567', '7893216540', 'laura@example.com', 3);

INSERT INTO Pacientes (ID_Paciente, Nombre, Cedula, Fecha_Nacimiento, Genero, Direccion, Telefono, Email, ID_Plan_Seguro)
VALUES (106, 'Jorge Gómez', '159753258', TO_DATE('1987-09-18', 'YYYY-MM-DD'), 'Masculino', 'Avenida Primaria 123', '1597532580', 'jorge@example.com', 1);

INSERT INTO Pacientes (ID_Paciente, Nombre, Cedula, Fecha_Nacimiento, Genero, Direccion, Telefono, Email, ID_Plan_Seguro)
VALUES (107, 'Verónica Torres', '753951456', TO_DATE('1990-07-30', 'YYYY-MM-DD'), 'Femenino', 'Calle del Sol', '7539514560', 'veronica@example.com', 2);

INSERT INTO Pacientes (ID_Paciente, Nombre, Cedula, Fecha_Nacimiento, Genero, Direccion, Telefono, Email, ID_Plan_Seguro)
VALUES (108, 'Miguel Ruiz', '852963147', TO_DATE('1982-04-22', 'YYYY-MM-DD'), 'Masculino', 'Avenida Sur 456', '8529631470', 'miguel@example.com', 3);

INSERT INTO Pacientes (ID_Paciente, Nombre, Cedula, Fecha_Nacimiento, Genero, Direccion, Telefono, Email, ID_Plan_Seguro)
VALUES (109, 'Silvia Díaz', '369852147', TO_DATE('1993-11-15', 'YYYY-MM-DD'), 'Femenino', 'Calle del Parque', '3698521470', 'silvia@example.com', 1);

INSERT INTO Pacientes (ID_Paciente, Nombre, Cedula, Fecha_Nacimiento, Genero, Direccion, Telefono, Email, ID_Plan_Seguro)
VALUES (110, 'Luis Hernández', '147258369', TO_DATE('1975-02-28', 'YYYY-MM-DD'), 'Masculino', 'Calle Central 789', '1472583690', 'luis@example.com', 2);

-- Inserción de datos en la tabla Centros_Atencion
INSERT INTO Centros_Atencion (ID_Centro, Tipo_Centro, ID_Seguro_Aceptado)
VALUES (1, 'Hospital', 1);

INSERT INTO Centros_Atencion (ID_Centro, Tipo_Centro, ID_Seguro_Aceptado)
VALUES (101, 'Hospital', 1);

INSERT INTO Centros_Atencion (ID_Centro, Tipo_Centro, ID_Seguro_Aceptado)
VALUES (102, 'Clínica', 2);

INSERT INTO Centros_Atencion (ID_Centro, Tipo_Centro, ID_Seguro_Aceptado)
VALUES (103, 'Consultorio', 3);

INSERT INTO Centros_Atencion (ID_Centro, Tipo_Centro, ID_Seguro_Aceptado)
VALUES (104, 'Hospital', 2);

INSERT INTO Centros_Atencion (ID_Centro, Tipo_Centro, ID_Seguro_Aceptado)
VALUES (105, 'Hospital', 3);

INSERT INTO Centros_Atencion (ID_Centro, Tipo_Centro, ID_Seguro_Aceptado)
VALUES (106, 'Clínica', 1);

INSERT INTO Centros_Atencion (ID_Centro, Tipo_Centro, ID_Seguro_Aceptado)
VALUES (107, 'Consultorio', 2);

INSERT INTO Centros_Atencion (ID_Centro, Tipo_Centro, ID_Seguro_Aceptado)
VALUES (108, 'Hospital', 1);

INSERT INTO Centros_Atencion (ID_Centro, Tipo_Centro, ID_Seguro_Aceptado)
VALUES (109, 'Clínica', 3);

INSERT INTO Centros_Atencion (ID_Centro, Tipo_Centro, ID_Seguro_Aceptado)
VALUES (110, 'Consultorio', 1);


-- Inserción de datos en la tabla Proveedor_Atencion_Medica
INSERT INTO Proveedor_Atencion_Medica (ID_Proveedor, Nombre_Proveedor, Especialidad_Proveedor, Direccion, Telefono, Email, Numero_Identificacion_Fiscal, Tipo_Proveedor)
VALUES (1, 'Clínica XYZ', 'Cardiología', 'Avenida Principal', '987654321', 'info@clinica.com', 'ABC123', 'Clínica');

INSERT INTO Proveedor_Atencion_Medica (ID_Proveedor, Nombre_Proveedor, Especialidad_Proveedor, Direccion, Telefono, Email, Numero_Identificacion_Fiscal, Tipo_Proveedor)
VALUES (101, 'Hospital ABC', 'Cirugía', 'Calle Principal', '123456789', 'info@hospital.com', 'DEF456', 'Hospital');

INSERT INTO Proveedor_Atencion_Medica (ID_Proveedor, Nombre_Proveedor, Especialidad_Proveedor, Direccion, Telefono, Email, Numero_Identificacion_Fiscal, Tipo_Proveedor)
VALUES (102, 'Clínica XYZ', 'Pediatría', 'Avenida Central', '987654321', 'info@clinica.com', 'GHI789', 'Clínica');

INSERT INTO Proveedor_Atencion_Medica (ID_Proveedor, Nombre_Proveedor, Especialidad_Proveedor, Direccion, Telefono, Email, Numero_Identificacion_Fiscal, Tipo_Proveedor)
VALUES (103, 'Consultorio Médico 123', 'Medicina General', 'Calle Secundaria', '456123789', 'info@consultorio.com', 'JKL012', 'Consultorio');

INSERT INTO Proveedor_Atencion_Medica (ID_Proveedor, Nombre_Proveedor, Especialidad_Proveedor, Direccion, Telefono, Email, Numero_Identificacion_Fiscal, Tipo_Proveedor)
VALUES (104, 'Hospital DEF', 'Ginecología', 'Avenida Norte', '321654987', 'info@hospitaldef.com', 'MNO345', 'Hospital');

INSERT INTO Proveedor_Atencion_Medica (ID_Proveedor, Nombre_Proveedor, Especialidad_Proveedor, Direccion, Telefono, Email, Numero_Identificacion_Fiscal, Tipo_Proveedor)
VALUES (105, 'Clínica ABC', 'Dermatología', 'Calle Este', '789456123', 'info@clinicaabc.com', 'PQR678', 'Clínica');

INSERT INTO Proveedor_Atencion_Medica (ID_Proveedor, Nombre_Proveedor, Especialidad_Proveedor, Direccion, Telefono, Email, Numero_Identificacion_Fiscal, Tipo_Proveedor)
VALUES (106, 'Consultorio del Dr. López', 'Psicología', 'Avenida Sur', '654987321', 'info@consultoriodrlopez.com', 'STU901', 'Consultorio');

INSERT INTO Proveedor_Atencion_Medica (ID_Proveedor, Nombre_Proveedor, Especialidad_Proveedor, Direccion, Telefono, Email, Numero_Identificacion_Fiscal, Tipo_Proveedor)
VALUES (107, 'Hospital GHI', 'Oncología', 'Calle Oeste', '987321654', 'info@hospitalghi.com', 'VWX234', 'Hospital');

INSERT INTO Proveedor_Atencion_Medica (ID_Proveedor, Nombre_Proveedor, Especialidad_Proveedor, Direccion, Telefono, Email, Numero_Identificacion_Fiscal, Tipo_Proveedor)
VALUES (108, 'Clínica PQR', 'Ortopedia', 'Avenida Noroeste', '456789123', 'info@clinicapqr.com', 'YZA567', 'Clínica');

INSERT INTO Proveedor_Atencion_Medica (ID_Proveedor, Nombre_Proveedor, Especialidad_Proveedor, Direccion, Telefono, Email, Numero_Identificacion_Fiscal, Tipo_Proveedor)
VALUES (109, 'Consultorio Dra. Martínez', 'Nutrición', 'Calle Suroeste', '321789456', 'info@consultoriomartinez.com', 'BCD890', 'Consultorio');

INSERT INTO Proveedor_Atencion_Medica (ID_Proveedor, Nombre_Proveedor, Especialidad_Proveedor, Direccion, Telefono, Email, Numero_Identificacion_Fiscal, Tipo_Proveedor)
VALUES (110, 'Hospital JKL', 'Urología', 'Avenida Suroeste', '987654123', 'info@hospitaljkl.com', 'EFG123', 'Hospital');

-- Inserción de datos en la tabla Hospitales
INSERT INTO Hospitales (ID_Hospital, Nombre_Hospital, Direccion, Telefono, Numero_Identificacion_Fiscal)
VALUES (1, 'Hospital ABC', 'Calle Principal', '987654321', 'DEF456');

INSERT INTO Hospitales (ID_Hospital, Nombre_Hospital, Direccion, Telefono, Numero_Identificacion_Fiscal)
VALUES (101, 'Hospital XYZ', 'Avenida Principal', '123456789', 'ABC123');

INSERT INTO Hospitales (ID_Hospital, Nombre_Hospital, Direccion, Telefono, Numero_Identificacion_Fiscal)
VALUES (102, 'Hospital DEF', 'Calle Norte', '789123456', 'GHI789');

INSERT INTO Hospitales (ID_Hospital, Nombre_Hospital, Direccion, Telefono, Numero_Identificacion_Fiscal)
VALUES (103, 'Hospital GHI', 'Calle Sur', '456789123', 'JKL012');

INSERT INTO Hospitales (ID_Hospital, Nombre_Hospital, Direccion, Telefono, Numero_Identificacion_Fiscal)
VALUES (104, 'Hospital JKL', 'Calle Este', '987654321', 'MNO345');

INSERT INTO Hospitales (ID_Hospital, Nombre_Hospital, Direccion, Telefono, Numero_Identificacion_Fiscal)
VALUES (105, 'Hospital MNO', 'Calle Oeste', '654321987', 'PQR678');

INSERT INTO Hospitales (ID_Hospital, Nombre_Hospital, Direccion, Telefono, Numero_Identificacion_Fiscal)
VALUES (106, 'Hospital PQR', 'Avenida Norte', '321987654', 'STU901');

INSERT INTO Hospitales (ID_Hospital, Nombre_Hospital, Direccion, Telefono, Numero_Identificacion_Fiscal)
VALUES (107, 'Hospital STU', 'Avenida Sur', '987654321', 'VWX234');

INSERT INTO Hospitales (ID_Hospital, Nombre_Hospital, Direccion, Telefono, Numero_Identificacion_Fiscal)
VALUES (108, 'Hospital VWX', 'Avenida Este', '654321987', 'YZA567');

INSERT INTO Hospitales (ID_Hospital, Nombre_Hospital, Direccion, Telefono, Numero_Identificacion_Fiscal)
VALUES (109, 'Hospital YZA', 'Avenida Oeste', '321987654', 'BCD890');

INSERT INTO Hospitales (ID_Hospital, Nombre_Hospital, Direccion, Telefono, Numero_Identificacion_Fiscal)
VALUES (110, 'Hospital BCD', 'Avenida Central', '987654321', 'EFG123');

-- Inserción de datos en la tabla Clínica
INSERT INTO Clinica (ID_Clinica, Nombre_Clinica, Direccion, Telefono, Numero_Identificacion_Fiscal)
VALUES (1, 'Clínica XYZ', 'Avenida Central', '123456789', 'GHI789');

INSERT INTO Clinica (ID_Clinica, Nombre_Clinica, Direccion, Telefono, Numero_Identificacion_Fiscal)
VALUES (101, 'Clínica ABC', 'Calle Principal', '987654321', 'JKL012');

INSERT INTO Clinica (ID_Clinica, Nombre_Clinica, Direccion, Telefono, Numero_Identificacion_Fiscal)
VALUES (102, 'Clínica DEF', 'Calle Norte', '789123456', 'MNO345');

INSERT INTO Clinica (ID_Clinica, Nombre_Clinica, Direccion, Telefono, Numero_Identificacion_Fiscal)
VALUES (103, 'Clínica GHI', 'Calle Sur', '456789123', 'PQR678');

INSERT INTO Clinica (ID_Clinica, Nombre_Clinica, Direccion, Telefono, Numero_Identificacion_Fiscal)
VALUES (104, 'Clínica JKL', 'Calle Este', '987654321', 'STU901');

INSERT INTO Clinica (ID_Clinica, Nombre_Clinica, Direccion, Telefono, Numero_Identificacion_Fiscal)
VALUES (105, 'Clínica MNO', 'Calle Oeste', '654321987', 'VWX234');

INSERT INTO Clinica (ID_Clinica, Nombre_Clinica, Direccion, Telefono, Numero_Identificacion_Fiscal)
VALUES (106, 'Clínica PQR', 'Avenida Norte', '321987654', 'YZA567');

INSERT INTO Clinica (ID_Clinica, Nombre_Clinica, Direccion, Telefono, Numero_Identificacion_Fiscal)
VALUES (107, 'Clínica STU', 'Avenida Sur', '987654321', 'BCD890');

INSERT INTO Clinica (ID_Clinica, Nombre_Clinica, Direccion, Telefono, Numero_Identificacion_Fiscal)
VALUES (108, 'Clínica VWX', 'Avenida Este', '654321987', 'EFG123');

INSERT INTO Clinica (ID_Clinica, Nombre_Clinica, Direccion, Telefono, Numero_Identificacion_Fiscal)
VALUES (109, 'Clínica YZA', 'Avenida Oeste', '321987654', 'HIJ456');

INSERT INTO Clinica (ID_Clinica, Nombre_Clinica, Direccion, Telefono, Numero_Identificacion_Fiscal)
VALUES (110, 'Clínica BCD', 'Avenida Central', '987654321', 'KLM789');

-- Inserción de datos en la tabla Consultorios
INSERT INTO Consultorios (ID_Consultorio, Nombre_Consultorio, Direccion, Telefono, Numero_Identificacion_Fiscal)
VALUES (1, 'Consultorio Dr. Pérez', 'Plaza Principal', '987654321', 'JKL012');

INSERT INTO Consultorios (ID_Consultorio, Nombre_Consultorio, Direccion, Telefono, Numero_Identificacion_Fiscal)
VALUES (101, 'Consultorio Dra. Gómez', 'Calle Principal', '789654123', 'MNO345');

INSERT INTO Consultorios (ID_Consultorio, Nombre_Consultorio, Direccion, Telefono, Numero_Identificacion_Fiscal)
VALUES (102, 'Consultorio Dr. López', 'Calle Norte', '654321789', 'PQR678');

INSERT INTO Consultorios (ID_Consultorio, Nombre_Consultorio, Direccion, Telefono, Numero_Identificacion_Fiscal)
VALUES (103, 'Consultorio Dra. Martínez', 'Calle Sur', '321987654', 'STU901');

INSERT INTO Consultorios (ID_Consultorio, Nombre_Consultorio, Direccion, Telefono, Numero_Identificacion_Fiscal)
VALUES (104, 'Consultorio Dr. Rodríguez', 'Calle Este', '987321654', 'VWX234');

INSERT INTO Consultorios (ID_Consultorio, Nombre_Consultorio, Direccion, Telefono, Numero_Identificacion_Fiscal)
VALUES (105, 'Consultorio Dra. Sánchez', 'Calle Oeste', '654789321', 'YZA567');

INSERT INTO Consultorios (ID_Consultorio, Nombre_Consultorio, Direccion, Telefono, Numero_Identificacion_Fiscal)
VALUES (106, 'Consultorio Dr. Torres', 'Avenida Norte', '321654987', 'BCD890');

INSERT INTO Consultorios (ID_Consultorio, Nombre_Consultorio, Direccion, Telefono, Numero_Identificacion_Fiscal)
VALUES (107, 'Consultorio Dra. Vargas', 'Avenida Sur', '987654321', 'EFG123');

INSERT INTO Consultorios (ID_Consultorio, Nombre_Consultorio, Direccion, Telefono, Numero_Identificacion_Fiscal)
VALUES (108, 'Consultorio Dr. Zúñiga', 'Avenida Este', '654987321', 'HIJ456');

INSERT INTO Consultorios (ID_Consultorio, Nombre_Consultorio, Direccion, Telefono, Numero_Identificacion_Fiscal)
VALUES (109, 'Consultorio Dra. Álvarez', 'Avenida Oeste', '321654987', 'KLM789');

INSERT INTO Consultorios (ID_Consultorio, Nombre_Consultorio, Direccion, Telefono, Numero_Identificacion_Fiscal)
VALUES (110, 'Consultorio Dr. Aguilar', 'Plaza Central', '987123654', 'NOP012');


-- Inserción de datos en la tabla Farmacia
INSERT INTO Farmacia (ID_Farmacia, Nombre, Direccion, Telefono, Horario, ID_Medicamento)
VALUES (1, 'Farmacia Popular', 'Avenida Comercial', '123456789', '8:00 AM - 10:00 PM', 1);

INSERT INTO Farmacia (ID_Farmacia, Nombre, Direccion, Telefono, Horario, ID_Medicamento)
VALUES (101, 'Farmacia La Salud', 'Calle Principal', '789654123', '9:00 AM - 8:00 PM', 2);

INSERT INTO Farmacia (ID_Farmacia, Nombre, Direccion, Telefono, Horario, ID_Medicamento)
VALUES (102, 'Farmacia San Rafael', 'Avenida Norte', '654321789', '8:30 AM - 7:30 PM', 3);

INSERT INTO Farmacia (ID_Farmacia, Nombre, Direccion, Telefono, Horario, ID_Medicamento)
VALUES (103, 'Farmacia Santa María', 'Calle Sur', '321987654', '10:00 AM - 9:00 PM', 104);

INSERT INTO Farmacia (ID_Farmacia, Nombre, Direccion, Telefono, Horario, ID_Medicamento)
VALUES (104, 'Farmacia La Esperanza', 'Calle Este', '987321654', '8:00 AM - 6:00 PM', 105);

INSERT INTO Farmacia (ID_Farmacia, Nombre, Direccion, Telefono, Horario, ID_Medicamento)
VALUES (105, 'Farmacia El Rosal', 'Calle Oeste', '654789321', '7:00 AM - 5:00 PM', 106);

INSERT INTO Farmacia (ID_Farmacia, Nombre, Direccion, Telefono, Horario, ID_Medicamento)
VALUES (106, 'Farmacia San Miguel', 'Avenida Norte', '321654987', '8:30 AM - 7:30 PM', 107);

INSERT INTO Farmacia (ID_Farmacia, Nombre, Direccion, Telefono, Horario, ID_Medicamento)
VALUES (107, 'Farmacia San José', 'Avenida Sur', '987654321', '9:00 AM - 8:00 PM', 108);

INSERT INTO Farmacia (ID_Farmacia, Nombre, Direccion, Telefono, Horario, ID_Medicamento)
VALUES (108, 'Farmacia El Bosque', 'Avenida Este', '654987321', '10:00 AM - 9:00 PM', 109);

INSERT INTO Farmacia (ID_Farmacia, Nombre, Direccion, Telefono, Horario, ID_Medicamento)
VALUES (109, 'Farmacia La Colina', 'Avenida Oeste', '321654987', '7:30 AM - 6:30 PM', 110);

INSERT INTO Farmacia (ID_Farmacia, Nombre, Direccion, Telefono, Horario, ID_Medicamento)
VALUES (110, 'Farmacia San Gabriel', 'Plaza Central', '987123654', '8:00 AM - 7:00 PM', 3);

-- Inserción de datos en la tabla Solicitud_Autorizacion
INSERT INTO Solicitud_Autorizacion (ID_Solicitud, ID_Paciente, Tipo_Servicio_Solicitado, Estado_Solicitud)
VALUES (1, 1, 'Consulta Médica', 'Pendiente');

INSERT INTO Solicitud_Autorizacion (ID_Solicitud, ID_Paciente, Tipo_Servicio_Solicitado, Estado_Solicitud)
VALUES (4, 1, 'Consulta Médica', 'Pendiente');

INSERT INTO Solicitud_Autorizacion (ID_Solicitud, ID_Paciente, Tipo_Servicio_Solicitado, Estado_Solicitud)
VALUES (5, 2, 'Examen de Laboratorio', 'Aprobada');

INSERT INTO Solicitud_Autorizacion (ID_Solicitud, ID_Paciente, Tipo_Servicio_Solicitado, Estado_Solicitud)
VALUES (6, 3, 'Cirugía', 'Rechazada');

INSERT INTO Solicitud_Autorizacion (ID_Solicitud, ID_Paciente, Tipo_Servicio_Solicitado, Estado_Solicitud)
VALUES (7, 101, 'Tratamiento Fisioterapia', 'Pendiente');

INSERT INTO Solicitud_Autorizacion (ID_Solicitud, ID_Paciente, Tipo_Servicio_Solicitado, Estado_Solicitud)
VALUES (8, 102, 'Consulta Especialista', 'Aprobada');

INSERT INTO Solicitud_Autorizacion (ID_Solicitud, ID_Paciente, Tipo_Servicio_Solicitado, Estado_Solicitud)
VALUES (9, 103, 'Radiografía', 'Pendiente');

INSERT INTO Solicitud_Autorizacion (ID_Solicitud, ID_Paciente, Tipo_Servicio_Solicitado, Estado_Solicitud)
VALUES (10, 104, 'Análisis de Sangre', 'Aprobada');

INSERT INTO Solicitud_Autorizacion (ID_Solicitud, ID_Paciente, Tipo_Servicio_Solicitado, Estado_Solicitud)
VALUES (11, 105, 'Terapia Psicológica', 'Rechazada');

INSERT INTO Solicitud_Autorizacion (ID_Solicitud, ID_Paciente, Tipo_Servicio_Solicitado, Estado_Solicitud)
VALUES (12, 106, 'Procedimiento Dental', 'Pendiente');

INSERT INTO Solicitud_Autorizacion (ID_Solicitud, ID_Paciente, Tipo_Servicio_Solicitado, Estado_Solicitud)
VALUES (13, 107, 'Resonancia Magnética', 'Aprobada');

-- Inserción de datos en la tabla Autorizacion
INSERT INTO Autorizacion (ID_Autorizacion, ID_Solicitud, Fecha_Autorizacion, Tipo_Servicio_Autorizado, Monto_Autorizado)
VALUES (1, 1, TO_DATE('2024-03-18', 'YYYY-MM-DD'), 'Consulta Médica', 50.00);

INSERT INTO Autorizacion (ID_Autorizacion, ID_Solicitud, Fecha_Autorizacion, Tipo_Servicio_Autorizado, Monto_Autorizado)
VALUES (101, 1, TO_DATE('2024-03-18', 'YYYY-MM-DD'), 'Consulta Médica', 50.00);

INSERT INTO Autorizacion (ID_Autorizacion, ID_Solicitud, Fecha_Autorizacion, Tipo_Servicio_Autorizado, Monto_Autorizado)
VALUES (2, 2, TO_DATE('2024-03-19', 'YYYY-MM-DD'), 'Examen de Laboratorio', 80.00);

INSERT INTO Autorizacion (ID_Autorizacion, ID_Solicitud, Fecha_Autorizacion, Tipo_Servicio_Autorizado, Monto_Autorizado)
VALUES (3, 3, TO_DATE('2024-03-20', 'YYYY-MM-DD'), 'Cirugía', 1500.00);

INSERT INTO Autorizacion (ID_Autorizacion, ID_Solicitud, Fecha_Autorizacion, Tipo_Servicio_Autorizado, Monto_Autorizado)
VALUES (4, 4, TO_DATE('2024-03-21', 'YYYY-MM-DD'), 'Tratamiento Fisioterapia', 100.00);

INSERT INTO Autorizacion (ID_Autorizacion, ID_Solicitud, Fecha_Autorizacion, Tipo_Servicio_Autorizado, Monto_Autorizado)
VALUES (5, 5, TO_DATE('2024-03-22', 'YYYY-MM-DD'), 'Consulta Especialista', 70.00);

INSERT INTO Autorizacion (ID_Autorizacion, ID_Solicitud, Fecha_Autorizacion, Tipo_Servicio_Autorizado, Monto_Autorizado)
VALUES (6, 6, TO_DATE('2024-03-23', 'YYYY-MM-DD'), 'Radiografía', 60.00);

INSERT INTO Autorizacion (ID_Autorizacion, ID_Solicitud, Fecha_Autorizacion, Tipo_Servicio_Autorizado, Monto_Autorizado)
VALUES (7, 7, TO_DATE('2024-03-24', 'YYYY-MM-DD'), 'Análisis de Sangre', 40.00);

INSERT INTO Autorizacion (ID_Autorizacion, ID_Solicitud, Fecha_Autorizacion, Tipo_Servicio_Autorizado, Monto_Autorizado)
VALUES (8, 8, TO_DATE('2024-03-25', 'YYYY-MM-DD'), 'Terapia Psicológica', 90.00);

INSERT INTO Autorizacion (ID_Autorizacion, ID_Solicitud, Fecha_Autorizacion, Tipo_Servicio_Autorizado, Monto_Autorizado)
VALUES (9, 9, TO_DATE('2024-03-26', 'YYYY-MM-DD'), 'Procedimiento Dental', 120.00);

INSERT INTO Autorizacion (ID_Autorizacion, ID_Solicitud, Fecha_Autorizacion, Tipo_Servicio_Autorizado, Monto_Autorizado)
VALUES (10, 10, TO_DATE('2024-03-27', 'YYYY-MM-DD'), 'Resonancia Magnética', 200.00);

-- Inserción de datos en la tabla Cita_Medica
INSERT INTO Cita_Medica (ID_Cita, ID_Paciente, ID_Proveedor, ID_Centro_Atencion, Fecha_Cita, Razon_Cita, Costo, Estado)
VALUES (1, 1, 1, 1, TO_DATE('2024-03-20', 'YYYY-MM-DD'), 'Consulta de rutina', 50.00, 'Programada');

INSERT INTO Cita_Medica (ID_Cita, ID_Paciente, ID_Proveedor, ID_Centro_Atencion, Fecha_Cita, Razon_Cita, Costo, Estado)
VALUES (100, 1, 1, 1, TO_DATE('2024-03-20', 'YYYY-MM-DD'), 'Consulta de rutina', 50.00, 'Programada');

INSERT INTO Cita_Medica (ID_Cita, ID_Paciente, ID_Proveedor, ID_Centro_Atencion, Fecha_Cita, Razon_Cita, Costo, Estado)
VALUES (2, 2, 101, 101, TO_DATE('2024-03-21', 'YYYY-MM-DD'), 'Examen de laboratorio', 75.00, 'Programada');

INSERT INTO Cita_Medica (ID_Cita, ID_Paciente, ID_Proveedor, ID_Centro_Atencion, Fecha_Cita, Razon_Cita, Costo, Estado)
VALUES (3, 3, 102, 102, TO_DATE('2024-03-22', 'YYYY-MM-DD'), 'Cirugía programada', 500.00, 'Programada');

INSERT INTO Cita_Medica (ID_Cita, ID_Paciente, ID_Proveedor, ID_Centro_Atencion, Fecha_Cita, Razon_Cita, Costo, Estado)
VALUES (4, 104, 105, 103, TO_DATE('2024-03-23', 'YYYY-MM-DD'), 'Consulta de seguimiento', 40.00, 'Programada');

INSERT INTO Cita_Medica (ID_Cita, ID_Paciente, ID_Proveedor, ID_Centro_Atencion, Fecha_Cita, Razon_Cita, Costo, Estado)
VALUES (5, 105, 106, 104, TO_DATE('2024-03-24', 'YYYY-MM-DD'), 'Consulta de especialista', 60.00, 'Programada');

INSERT INTO Cita_Medica (ID_Cita, ID_Paciente, ID_Proveedor, ID_Centro_Atencion, Fecha_Cita, Razon_Cita, Costo, Estado)
VALUES (6, 106, 107, 105, TO_DATE('2024-03-25', 'YYYY-MM-DD'), 'Estudio radiográfico', 80.00, 'Programada');

INSERT INTO Cita_Medica (ID_Cita, ID_Paciente, ID_Proveedor, ID_Centro_Atencion, Fecha_Cita, Razon_Cita, Costo, Estado)
VALUES (7, 107, 108, 106, TO_DATE('2024-03-26', 'YYYY-MM-DD'), 'Análisis de sangre', 35.00, 'Programada');

INSERT INTO Cita_Medica (ID_Cita, ID_Paciente, ID_Proveedor, ID_Centro_Atencion, Fecha_Cita, Razon_Cita, Costo, Estado)
VALUES (8, 108, 109, 107, TO_DATE('2024-03-27', 'YYYY-MM-DD'), 'Terapia psicológica', 55.00, 'Programada');

INSERT INTO Cita_Medica (ID_Cita, ID_Paciente, ID_Proveedor, ID_Centro_Atencion, Fecha_Cita, Razon_Cita, Costo, Estado)
VALUES (9, 109, 110, 108, TO_DATE('2024-03-28', 'YYYY-MM-DD'), 'Procedimiento dental', 100.00, 'Programada');

INSERT INTO Cita_Medica (ID_Cita, ID_Paciente, ID_Proveedor, ID_Centro_Atencion, Fecha_Cita, Razon_Cita, Costo, Estado)
VALUES (10, 110, 101, 109, TO_DATE('2024-03-29', 'YYYY-MM-DD'), 'Resonancia magnética', 150.00, 'Programada');

-- Inserción de datos en la tabla Historial_Médico
INSERT INTO Historial_Médico (ID_Historial, ID_Paciente, ID_Proveedor, Fecha_Visita, Diagnostico, Tratamiento_Prescrito, Medicamento_Recetado)
VALUES (1, 1, 1, TO_DATE('2024-03-20', 'YYYY-MM-DD'), 'Sin diagnóstico', 'Reposo', 'Paracetamol');

INSERT INTO Historial_Médico (ID_Historial, ID_Paciente, ID_Proveedor, Fecha_Visita, Diagnostico, Tratamiento_Prescrito, Medicamento_Recetado)
VALUES (101, 1, 101, TO_DATE('2024-03-20', 'YYYY-MM-DD'), 'Sin diagnóstico', 'Reposo', 'Paracetamol');

INSERT INTO Historial_Médico (ID_Historial, ID_Paciente, ID_Proveedor, Fecha_Visita, Diagnostico, Tratamiento_Prescrito, Medicamento_Recetado)
VALUES (102, 2, 102, TO_DATE('2024-03-21', 'YYYY-MM-DD'), 'Presión arterial alta', 'Control de la dieta', 'Losartán');

INSERT INTO Historial_Médico (ID_Historial, ID_Paciente, ID_Proveedor, Fecha_Visita, Diagnostico, Tratamiento_Prescrito, Medicamento_Recetado)
VALUES (103, 3, 103, TO_DATE('2024-03-22', 'YYYY-MM-DD'), 'Apnea del sueño', 'Uso de CPAP durante el sueño', 'CPAP');

INSERT INTO Historial_Médico (ID_Historial, ID_Paciente, ID_Proveedor, Fecha_Visita, Diagnostico, Tratamiento_Prescrito, Medicamento_Recetado)
VALUES (4, 101, 104, TO_DATE('2024-03-23', 'YYYY-MM-DD'), 'Esguince de tobillo', 'Inmovilización y terapia física', 'Ibuprofeno');

INSERT INTO Historial_Médico (ID_Historial, ID_Paciente, ID_Proveedor, Fecha_Visita, Diagnostico, Tratamiento_Prescrito, Medicamento_Recetado)
VALUES (5, 104, 105, TO_DATE('2024-03-24', 'YYYY-MM-DD'), 'Gripe común', 'Reposo y líquidos', 'Paracetamol');

INSERT INTO Historial_Médico (ID_Historial, ID_Paciente, ID_Proveedor, Fecha_Visita, Diagnostico, Tratamiento_Prescrito, Medicamento_Recetado)
VALUES (6, 103, 106, TO_DATE('2024-03-25', 'YYYY-MM-DD'), 'Fractura de muñeca', 'Inmovilización y fisioterapia', 'Ibuprofeno');

INSERT INTO Historial_Médico (ID_Historial, ID_Paciente, ID_Proveedor, Fecha_Visita, Diagnostico, Tratamiento_Prescrito, Medicamento_Recetado)
VALUES (7, 102, 107, TO_DATE('2024-03-26', 'YYYY-MM-DD'), 'Anemia leve', 'Suplementos de hierro y ácido fólico', 'Hierro');

INSERT INTO Historial_Médico (ID_Historial, ID_Paciente, ID_Proveedor, Fecha_Visita, Diagnostico, Tratamiento_Prescrito, Medicamento_Recetado)
VALUES (8, 105, 108, TO_DATE('2024-03-27', 'YYYY-MM-DD'), 'Ansiedad', 'Terapia cognitivo-conductual', 'Alprazolam');

INSERT INTO Historial_Médico (ID_Historial, ID_Paciente, ID_Proveedor, Fecha_Visita, Diagnostico, Tratamiento_Prescrito, Medicamento_Recetado)
VALUES (9, 106, 109, TO_DATE('2024-03-28', 'YYYY-MM-DD'), 'Caries dental', 'Extracción y cuidado oral', 'Anestesia local');

INSERT INTO Historial_Médico (ID_Historial, ID_Paciente, ID_Proveedor, Fecha_Visita, Diagnostico, Tratamiento_Prescrito, Medicamento_Recetado)
VALUES (10, 107, 110, TO_DATE('2024-03-29', 'YYYY-MM-DD'), 'Lesión en la rodilla', 'Reposo y terapia física', 'Diclofenaco');

-- Inserción de datos en la tabla Facturas
INSERT INTO Facturas (ID_Factura, ID_Paciente, ID_Proveedor, ID_Medicamento, Fecha_Factura, Descripcion_Servicio, Monto_Facturado, Estado)
VALUES (1, 1, 1, 1, TO_DATE('2024-03-20', 'YYYY-MM-DD'), 'Consulta de rutina', 50.00, 'Pagada');

INSERT INTO Facturas (ID_Factura, ID_Paciente, ID_Proveedor, ID_Medicamento, Fecha_Factura, Descripcion_Servicio, Monto_Facturado, Estado)
VALUES (101, 1, 1, 1, TO_DATE('2024-03-20', 'YYYY-MM-DD'), 'Consulta de rutina', 50.00, 'Pagada');

INSERT INTO Facturas (ID_Factura, ID_Paciente, ID_Proveedor, ID_Medicamento, Fecha_Factura, Descripcion_Servicio, Monto_Facturado, Estado)
VALUES (2, 2, 101, 2, TO_DATE('2024-03-21', 'YYYY-MM-DD'), 'Examen de laboratorio', 80.00, 'Pendiente');

INSERT INTO Facturas (ID_Factura, ID_Paciente, ID_Proveedor, ID_Medicamento, Fecha_Factura, Descripcion_Servicio, Monto_Facturado, Estado)
VALUES (3, 3, 102, 3, TO_DATE('2024-03-22', 'YYYY-MM-DD'), 'Cirugía de apendicitis', 1500.00, 'Pagada');

INSERT INTO Facturas (ID_Factura, ID_Paciente, ID_Proveedor, ID_Medicamento, Fecha_Factura, Descripcion_Servicio, Monto_Facturado, Estado)
VALUES (4, 104, 103, 101, TO_DATE('2024-03-23', 'YYYY-MM-DD'), 'Tratamiento de fisioterapia', 120.00, 'Pendiente');

INSERT INTO Facturas (ID_Factura, ID_Paciente, ID_Proveedor, ID_Medicamento, Fecha_Factura, Descripcion_Servicio, Monto_Facturado, Estado)
VALUES (5, 105, 104, 102, TO_DATE('2024-03-24', 'YYYY-MM-DD'), 'Consulta con especialista', 70.00, 'Pagada');

INSERT INTO Facturas (ID_Factura, ID_Paciente, ID_Proveedor, ID_Medicamento, Fecha_Factura, Descripcion_Servicio, Monto_Facturado, Estado)
VALUES (6, 106, 105, 103, TO_DATE('2024-03-25', 'YYYY-MM-DD'), 'Radiografía de muñeca', 60.00, 'Pendiente');

INSERT INTO Facturas (ID_Factura, ID_Paciente, ID_Proveedor, ID_Medicamento, Fecha_Factura, Descripcion_Servicio, Monto_Facturado, Estado)
VALUES (7, 107, 106, 104, TO_DATE('2024-03-26', 'YYYY-MM-DD'), 'Análisis de sangre', 40.00, 'Pagada');

INSERT INTO Facturas (ID_Factura, ID_Paciente, ID_Proveedor, ID_Medicamento, Fecha_Factura, Descripcion_Servicio, Monto_Facturado, Estado)
VALUES (8, 108, 107, 105, TO_DATE('2024-03-27', 'YYYY-MM-DD'), 'Terapia psicológica', 90.00, 'Pagada');

INSERT INTO Facturas (ID_Factura, ID_Paciente, ID_Proveedor, ID_Medicamento, Fecha_Factura, Descripcion_Servicio, Monto_Facturado, Estado)
VALUES (9, 109, 108, 106, TO_DATE('2024-03-28', 'YYYY-MM-DD'), 'Procedimiento dental', 100.00, 'Pendiente');

INSERT INTO Facturas (ID_Factura, ID_Paciente, ID_Proveedor, ID_Medicamento, Fecha_Factura, Descripcion_Servicio, Monto_Facturado, Estado)
VALUES (10, 110, 109, 107, TO_DATE('2024-03-29', 'YYYY-MM-DD'), 'Resonancia magnética', 200.00, 'Pagada');

-- Inserción de datos en la tabla Pago
INSERT INTO Pago (ID_Pago, ID_Factura, ID_Paciente, Fecha_Pago, Monto_Pagado, Metodo_Pago)
VALUES (1, 1, 1, TO_DATE('2024-03-21', 'YYYY-MM-DD'), 50.00, 'Efectivo');

INSERT INTO Pago (ID_Pago, ID_Factura, ID_Paciente, Fecha_Pago, Monto_Pagado, Metodo_Pago)
VALUES (101, 1, 1, TO_DATE('2024-03-21', 'YYYY-MM-DD'), 50.00, 'Efectivo');

INSERT INTO Pago (ID_Pago, ID_Factura, ID_Paciente, Fecha_Pago, Monto_Pagado, Metodo_Pago)
VALUES (12, 2, 2, TO_DATE('2024-03-22', 'YYYY-MM-DD'), 80.00, 'Tarjeta de crédito');

INSERT INTO Pago (ID_Pago, ID_Factura, ID_Paciente, Fecha_Pago, Monto_Pagado, Metodo_Pago)
VALUES (13, 3, 3, TO_DATE('2024-03-23', 'YYYY-MM-DD'), 1500.00, 'Transferencia bancaria');

INSERT INTO Pago (ID_Pago, ID_Factura, ID_Paciente, Fecha_Pago, Monto_Pagado, Metodo_Pago)
VALUES (14, 4, 4, TO_DATE('2024-03-24', 'YYYY-MM-DD'), 120.00, 'Efectivo');

INSERT INTO Pago (ID_Pago, ID_Factura, ID_Paciente, Fecha_Pago, Monto_Pagado, Metodo_Pago)
VALUES (15, 5, 5, TO_DATE('2024-03-25', 'YYYY-MM-DD'), 70.00, 'Tarjeta de débito');

INSERT INTO Pago (ID_Pago, ID_Factura, ID_Paciente, Fecha_Pago, Monto_Pagado, Metodo_Pago)
VALUES (16, 6, 6, TO_DATE('2024-03-26', 'YYYY-MM-DD'), 60.00, 'Efectivo');

INSERT INTO Pago (ID_Pago, ID_Factura, ID_Paciente, Fecha_Pago, Monto_Pagado, Metodo_Pago)
VALUES (17, 7, 7, TO_DATE('2024-03-27', 'YYYY-MM-DD'), 40.00, 'Tarjeta de crédito');

INSERT INTO Pago (ID_Pago, ID_Factura, ID_Paciente, Fecha_Pago, Monto_Pagado, Metodo_Pago)
VALUES (18, 8, 8, TO_DATE('2024-03-28', 'YYYY-MM-DD'), 90.00, 'Transferencia bancaria');

INSERT INTO Pago (ID_Pago, ID_Factura, ID_Paciente, Fecha_Pago, Monto_Pagado, Metodo_Pago)
VALUES (19, 9, 9, TO_DATE('2024-03-29', 'YYYY-MM-DD'), 100.00, 'Efectivo');

INSERT INTO Pago (ID_Pago, ID_Factura, ID_Paciente, Fecha_Pago, Monto_Pagado, Metodo_Pago)
VALUES (110, 10, 10, TO_DATE('2024-03-30', 'YYYY-MM-DD'), 200.00, 'Tarjeta de débito');

-- Inserción de datos en la tabla Reclamacion
INSERT INTO Reclamacion (ID_Reclamacion, ID_Paciente, ID_Proveedor, Fecha_Reclamacion, Servicio_Reclamado, Monto_Reclamado, Estado)
VALUES (1, 1, 1, TO_DATE('2024-03-21', 'YYYY-MM-DD'), 'Consulta de rutina', 50.00, 'En revisión');

INSERT INTO Reclamacion (ID_Reclamacion, ID_Paciente, ID_Proveedor, Fecha_Reclamacion, Servicio_Reclamado, Monto_Reclamado, Estado)
VALUES (101, 1, 1, TO_DATE('2024-03-21', 'YYYY-MM-DD'), 'Consulta de rutina', 50.00, 'En revisión');

INSERT INTO Reclamacion (ID_Reclamacion, ID_Paciente, ID_Proveedor, Fecha_Reclamacion, Servicio_Reclamado, Monto_Reclamado, Estado)
VALUES (2, 2, 101, TO_DATE('2024-03-22', 'YYYY-MM-DD'), 'Examen de laboratorio', 80.00, 'Pendiente');

INSERT INTO Reclamacion (ID_Reclamacion, ID_Paciente, ID_Proveedor, Fecha_Reclamacion, Servicio_Reclamado, Monto_Reclamado, Estado)
VALUES (3, 3, 102, TO_DATE('2024-03-23', 'YYYY-MM-DD'), 'Cirugía', 1500.00, 'Aprobada');

INSERT INTO Reclamacion (ID_Reclamacion, ID_Paciente, ID_Proveedor, Fecha_Reclamacion, Servicio_Reclamado, Monto_Reclamado, Estado)
VALUES (4, 104, 103, TO_DATE('2024-03-24', 'YYYY-MM-DD'), 'Tratamiento fisioterapia', 120.00, 'En revisión');

INSERT INTO Reclamacion (ID_Reclamacion, ID_Paciente, ID_Proveedor, Fecha_Reclamacion, Servicio_Reclamado, Monto_Reclamado, Estado)
VALUES (5, 105, 104, TO_DATE('2024-03-25', 'YYYY-MM-DD'), 'Consulta con especialista', 70.00, 'Pendiente');

INSERT INTO Reclamacion (ID_Reclamacion, ID_Paciente, ID_Proveedor, Fecha_Reclamacion, Servicio_Reclamado, Monto_Reclamado, Estado)
VALUES (6, 106, 105, TO_DATE('2024-03-26', 'YYYY-MM-DD'), 'Radiografía', 60.00, 'Aprobada');

INSERT INTO Reclamacion (ID_Reclamacion, ID_Paciente, ID_Proveedor, Fecha_Reclamacion, Servicio_Reclamado, Monto_Reclamado, Estado)
VALUES (7, 107, 106, TO_DATE('2024-03-27', 'YYYY-MM-DD'), 'Análisis de sangre', 40.00, 'En revisión');

INSERT INTO Reclamacion (ID_Reclamacion, ID_Paciente, ID_Proveedor, Fecha_Reclamacion, Servicio_Reclamado, Monto_Reclamado, Estado)
VALUES (8, 108, 107, TO_DATE('2024-03-28', 'YYYY-MM-DD'), 'Terapia psicológica', 90.00, 'Pendiente');

INSERT INTO Reclamacion (ID_Reclamacion, ID_Paciente, ID_Proveedor, Fecha_Reclamacion, Servicio_Reclamado, Monto_Reclamado, Estado)
VALUES (9, 109, 108, TO_DATE('2024-03-29', 'YYYY-MM-DD'), 'Procedimiento dental', 100.00, 'Aprobada');

INSERT INTO Reclamacion (ID_Reclamacion, ID_Paciente, ID_Proveedor, Fecha_Reclamacion, Servicio_Reclamado, Monto_Reclamado, Estado)
VALUES (10, 110, 109, TO_DATE('2024-03-30', 'YYYY-MM-DD'), 'Resonancia magnética', 200.00, 'En revisión');


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
SELECT table_name FROM user_tables;

--Select para los jobs
SELECT * FROM USER_SCHEDULER_JOB_RUN_DETAILS;

--Select de los sinonimos
SELECT * FROM sinonimo1;
SELECT * FROM sinonimo2;
SELECT * FROM sinonimo3;


--Select de index
SELECT index_name FROM user_indexes;

-- Select de las vistas
SELECT * FROM Vista_Pacientes_Planes_Seguro;
Select * from Vista_Facturas_Detallada;
Select * from Vista_Medicamentos_Farmacias;
Select * from Vista_Citas_Medicas;
Select * from Vista_Historial_Medico;

-- Select adicionales
select constraint_name from user_constraints;
select trigger_name from user_triggers;
select * from user_objects where object_type = 'PROCEDURE'
select * from user_objects where object_type = 'VIEW'
select * from user_db_links;

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