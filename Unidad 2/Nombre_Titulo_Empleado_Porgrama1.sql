DECLARE 
  v_nombre VARCHAR2(100);
  v_titulo_trabajo VARCHAR2(100);
BEGIN 
  SELECT e.nombre, j.titulo_trabajo
  INTO v_nombre, v_titulo_trabajo
  FROM empleados e
  JOIN trabajos j ON e.id_trabajo = j.id
  ORDER BY e.fecha_inicio ASC
  FETCH FIRST 1 ROW ONLY;

  DBMS_OUTPUT.PUT_LINE('Nombre: ' || v_nombre);
  DBMS_OUTPUT.PUT_LINE('Título del trabajo: ' || v_titulo_trabajo);
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('No se encontraron datos.');
END;
/
