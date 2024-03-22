DECLARE
    v_resultado NUMBER;
BEGIN
    -- Intentar realizar la división
    v_resultado := 60 / 2;

    -- Si la división se realiza con éxito, mostrar el resultado
    DBMS_OUTPUT.PUT_LINE('El resultado de la división es: ' || v_resultado);
EXCEPTION
    -- Capturar la excepción cuando se intenta dividir por cero
    WHEN ZERO_DIVIDE THEN
        -- Mostrar el mensaje de error
        DBMS_OUTPUT.PUT_LINE('No se puede dividir por cero');
END;
/
