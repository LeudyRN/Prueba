DECLARE
  v_emp_id empleados.empleadoid%TYPE := &emp_id;
  v_salary empleados.salario%TYPE;
BEGIN
  SELECT salario INTO v_salary
  FROM empleados
  WHERE EMPLEADOID = v_emp_id;
  
  v_salary := v_salary * 1.1;
  
  UPDATE empleados
  SET salario = v_salary
  WHERE EMPLEADOID = v_emp_id;
  
  COMMIT;
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('No se encontró ningún empleado con el ID proporcionado.');
  WHEN TOO_MANY_ROWS THEN
    DBMS_OUTPUT.PUT_LINE('Se encontraron demasiados empleados con el mismo ID.');
END;

Select * from empleados
