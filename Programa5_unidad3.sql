DECLARE
    v_resultado NUMBER;
BEGIN
    -- Intentar realizar la divisi�n
    v_resultado := 60 / 2;

    -- Si la divisi�n se realiza con �xito, mostrar el resultado
    DBMS_OUTPUT.PUT_LINE('El resultado de la divisi�n es: ' || v_resultado);
EXCEPTION
    -- Capturar la excepci�n cuando se intenta dividir por cero
    WHEN ZERO_DIVIDE THEN
        -- Mostrar el mensaje de error
        DBMS_OUTPUT.PUT_LINE('No se puede dividir por cero');
END;
/
