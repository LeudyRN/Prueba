SELECT nombre, salario, deptoID
FROM empleados
WHERE salario < (
    SELECT AVG(salario)
    FROM empleados
) AND deptoID IN (
    SELECT deptoID
    FROM Empleados
    WHERE nombre = 'Kevin'
);
