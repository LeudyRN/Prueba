DECLARE
    v_numero_entero NUMBER := &numero_entero;
BEGIN
    IF v_numero_entero < 0 THEN
        DBMS_OUTPUT.PUT_LINE('El n�mero no puede ser negativo.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('El n�mero es v�lido.');
    END IF;
END;
/
