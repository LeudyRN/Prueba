SELECT E.Nombre, E.Apellido, D.DeptoID, D.Nombre AS NombreDepartamento
FROM Empleados E
LEFT JOIN Departamentos D ON E.DeptoID = D.DeptoID;
