SELECT E.Nombre || ' ' || E.Apellido AS NombreCompleto, T.Titulo
FROM Empleados E
JOIN Trabajos T ON E.EmpleadoID = T.EmpleadoID
WHERE E.DeptoID = 80;
