DECLARE 
  CURSOR c_empleados IS
    SELECT empleado_id, nombre_empleado FROM empleados;
  v_empleado c_empleados%ROWTYPE;
BEGIN
  OPEN c_empleados;
  LOOP
    FETCH c_empleados INTO v_empleado;
    EXIT WHEN c_empleados%NOTFOUND;
    INSERT INTO empleados_temp VALUES (v_empleado.empleado_id, v_empleado.nombre_empleado);
  END LOOP;
  CLOSE c_empleados;
  COMMIT;
END;
/

SELECT * FROM empleados_temp;
