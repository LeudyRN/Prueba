DECLARE
  v_dept_id departamentos.DEPTOID%TYPE := &dept_id;
  v_dname departamentos.NOMBRE%TYPE := '&dname';
  v_loc departamentos.CIUDAD%TYPE := '&loc';
  v_count NUMBER;
  v_error_msg VARCHAR2(200);
BEGIN
  -- Verificar si el departamento ya existe
  SELECT COUNT(*) INTO v_count FROM departamentos WHERE DEPTOID = v_dept_id;

  IF v_count > 0 THEN
    v_error_msg := 'El departamento ya existe';
  ELSIF LENGTH(v_dname) > 50 OR LENGTH(v_loc) > 50 THEN -- Ajustar la longitud máxima según la estructura de la tabla departamentos
    v_error_msg := 'Algún dato insertado es de mayor longitud que la especificada en la tabla';
  ELSE
    -- Insertar datos en la tabla departamentos
    INSERT INTO departamentos (DEPTOID, NOMBRE, CIUDAD) VALUES (v_dept_id, v_dname, v_loc);
  END IF;

EXCEPTION
  WHEN OTHERS THEN
    v_error_msg := TO_CHAR(SQLCODE) || ': ' || SQLERRM;

  -- Insertar el mensaje de error en TEMP
  INSERT INTO TEMP_DEPT("ERROR") VALUES (v_error_msg);
  -- Realizar un COMMIT para finalizar la transacción
  COMMIT;
END;
/

CREATE OR REPLACE PROCEDURE INSERT_TEMP_DEPT_ERROR(p_error_message VARCHAR2) AS
BEGIN
  INSERT INTO TEMP_DEPT ("ERROR") VALUES (p_error_message);
  COMMIT;
EXCEPTION
  WHEN OTHERS THEN
    NULL; -- Manejar cualquier error de inserción silenciosamente
END;
/

DESCRIBE departamentos;
select * from TEMP_DEPT
SELECT COUNT(*) FROM TEMP_DEPT;

Select * from departamentos


