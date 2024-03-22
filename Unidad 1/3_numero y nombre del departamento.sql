SELECT Nombre, Salario, DeptoID
FROM Empleados
WHERE DeptoID = (
    SELECT DeptoID
    FROM Empleados
    WHERE EMPLEADOID = 124
);
