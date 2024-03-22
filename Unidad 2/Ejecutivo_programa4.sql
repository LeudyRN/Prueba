DECLARE 
  nombre VARCHAR2(50);
  departamento VARCHAR2(50);
  localidad VARCHAR2(50);
BEGIN 
  SELECT e.nombre, d.nombre, d.localidad
  INTO nombre, departamento, localidad
  FROM empleados e
  JOIN departamentos d ON e.departamento = d.nombre
  WHERE e.cargo = 'Vicepresidente Ejecutivo'
  AND ROWNUM = 1;

  DBMS_OUTPUT.PUT_LINE('Nombre: ' || nombre);
  DBMS_OUTPUT.PUT_LINE('Departamento: ' || departamento);
  DBMS_OUTPUT.PUT_LINE('Localidad: ' || localidad);
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('No se encontró un Vicepresidente Ejecutivo en la base de datos.');
END;
/
