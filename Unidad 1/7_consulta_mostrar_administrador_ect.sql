SELECT E.Nombre || ' ' || E.Apellido AS NombreCompleto, E.Rol
FROM Empleados E
JOIN Departamentos D ON E.DeptoID = D.DeptoID
WHERE E.Rol = 'Administrador';
