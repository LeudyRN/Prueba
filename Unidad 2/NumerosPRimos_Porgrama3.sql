DECLARE 
  n NUMBER;
  i NUMBER;
  contador NUMBER; -- Cambiado de 'count' a 'contador'
BEGIN
  FOR n IN 2..50 LOOP
    contador := 0; -- Cambiado de 'count' a 'contador'
    FOR i IN 2..n-1 LOOP
      IF MOD(n, i) = 0 THEN
        contador := contador + 1; -- Cambiado de 'count' a 'contador'
      END IF;
    END LOOP;
    IF contador = 0 THEN -- Cambiado de 'count' a 'contador'
      DBMS_OUTPUT.PUT_LINE(n || ' es un número primo');
    END IF;
  END LOOP;
END;
/
