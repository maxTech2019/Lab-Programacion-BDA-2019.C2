Use pedidos
Declare @categoria nvarchar(20)
Set @categoria = 'REPOSTERÍA'
WHILE ( SELECT AVG(p.PrecioUnidad) 
        FROM Productos p INNER JOIN Categorias c 
		ON p.IdCategoria = c.IdCategoria
		WHERE UPPER(C.Nombre)= @categoria) < 30  
BEGIN  
    UPDATE Productos  
    SET PrecioUnidad = PrecioUnidad * 2  
	Where IdCategoria = (Select IdCategoria 
                       From Categorias 
                       Where UPPER(Nombre) = @categoria)
    IF (SELECT MAX (PrecioUnidad) FROM Productos) > 500  BEGIN
        BREAK
	END	  
END 