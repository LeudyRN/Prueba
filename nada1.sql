DECLARE 
  num NUMBER := 7;  -- Aqu� puedes cambiar el n�mero que deseas elevar al cuadrado
  result NUMBER;
BEGIN 
  result := num * num;
  DBMS_OUTPUT.PUT_LINE('El cuadrado de ' || num || ' es ' || result);
END;
/
