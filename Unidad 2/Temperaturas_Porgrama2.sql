DECLARE 
  temp NUMBER := &temp; -- Temperatura a convertir
  scale CHAR := '&scale'; -- Escala de la temperatura (F o C)
  converted_temp NUMBER; -- Temperatura convertida
BEGIN 
  IF scale = 'F' THEN
    -- Convertir de Fahrenheit a Celsius
    converted_temp := (temp - 32) * 5 / 9;
    DBMS_OUTPUT.PUT_LINE(temp || ' grados Fahrenheit son ' || converted_temp || ' grados Celsius.');
  ELSIF scale = 'C' THEN
    -- Convertir de Celsius a Fahrenheit
    converted_temp := temp * 9 / 5 + 32;
    DBMS_OUTPUT.PUT_LINE(temp || ' grados Celsius son ' || converted_temp || ' grados Fahrenheit.');
  ELSE
    DBMS_OUTPUT.PUT_LINE('La escala ingresada no es válida. Por favor, ingrese F para Fahrenheit o C para Celsius.');
  END IF;
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Ha ocurrido un error al convertir la temperatura.');
END;
/
