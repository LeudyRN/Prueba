DECLARE 
  n NUMBER := 0;
BEGIN 
  LOOP
    DBMS_OUTPUT.PUT_LINE('Dentro del bucle, el valor de n es: ' || TO_CHAR(n));
    n := n + 1;
    EXIT WHEN n > 5;
  END LOOP;
  DBMS_OUTPUT.PUT_LINE('Fuera del bucle, el valor de n es: ' || TO_CHAR(n));
END;
/

