DECLARE 
  Nombre VARCHAR2(20) := 'Leudy ';
  Apellido VARCHAR2(20) := 'Nolasco';
  resultado VARCHAR2(40);
BEGIN 
  resultado := Nombre || Apellido;
  DBMS_OUTPUT.PUT_LINE(resultado);
END;
/
