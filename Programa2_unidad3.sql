DECLARE
  v_count NUMBER;
  e_no_empleados EXCEPTION;
BEGIN
  SELECT COUNT(*) INTO v_count FROM empleados;
  
  IF v_count = 0 THEN
    RAISE e_no_empleados;
  ELSE
    UPDATE empleados SET salario = salario * 1.1;
    COMMIT;
  END IF;
EXCEPTION
  WHEN e_no_empleados THEN
    DBMS_OUTPUT.PUT_LINE('No hay trabajadores en la empresa');
END;

Select * from empleados
