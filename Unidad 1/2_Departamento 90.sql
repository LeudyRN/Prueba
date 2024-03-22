SELECT deptoID, nombre
FROM Departamentos
WHERE UbicacionID = (
    SELECT UbicacionID
    FROM Departamentos
    WHERE departamentos.ciudad = 'Toronto'
);
