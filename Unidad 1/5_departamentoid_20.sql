SELECT nombre, salario, deptoID
FROM empleados
WHERE salario > (
    SELECT MIN(salario)
    FROM empleados
    WHERE deptoID = 60
);