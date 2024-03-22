SELECT E.Nombre, E.Apellido, E.DeptoID
FROM Empleados E
WHERE E.DeptoID = (
    SELECT MAX(DeptoID)
    FROM Empleados
    WHERE Apellido = 'Taylor'
);
