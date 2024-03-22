DECLARE 
  num NUMBER := 7;  -- Aquí puedes cambiar el número que deseas elevar al cuadrado
  result NUMBER;
BEGIN 
  result := num * num;
  DBMS_OUTPUT.PUT_LINE('El cuadrado de ' || num || ' es ' || result);
END;
/
