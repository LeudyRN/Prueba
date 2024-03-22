DECLARE 
  nombre VARCHAR2(50);
  salario NUMBER(8,2);
  ciudad VARCHAR2(50);
  provincia VARCHAR2(50);
  pais VARCHAR2(50);
BEGIN 
  SELECT e.nombre, e.salario, d.ciudad, d.provincia, d.pais
  INTO nombre, salario, ciudad, provincia, pais
  FROM empleados e
  JOIN departamentos d ON e.id_departamento = d.id
  WHERE e.cargo = 'Presidente'
  AND ROWNUM = 1;

  DBMS_OUTPUT.PUT_LINE('Nombre: ' || nombre);
  DBMS_OUTPUT.PUT_LINE('Salario: ' || salario);
  DBMS_OUTPUT.PUT_LINE('Ciudad: ' || ciudad);
  DBMS_OUTPUT.PUT_LINE('Provincia: ' || provincia);
  DBMS_OUTPUT.PUT_LINE('País: ' || pais);
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('No se encontró un Presidente en la base de datos.');
END;
/

