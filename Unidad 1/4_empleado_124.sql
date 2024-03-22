SELECT nombre, salario, deptoID
FROM Empleados
WHERE salario IN (
    SELECT salario
    FROM Empleados
    WHERE deptoID = 20
);