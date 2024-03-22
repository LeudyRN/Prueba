SELECT T.Titulo, D.Nombre AS NombreDepartamento, E.Nombre || ' ' || E.Apellido AS NombreCompleto, T.FechaInicio
FROM Trabajos T
JOIN Empleados E ON T.EmpleadoID = E.EmpleadoID
JOIN Departamentos D ON E.DeptoID = D.DeptoID
WHERE T.FechaInicio BETWEEN TO_DATE('1993-01-01', 'YYYY-MM-DD') AND TO_DATE('1997-08-31', 'YYYY-MM-DD');
