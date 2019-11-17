use pedidos
declare @nomCategoria varchar(20)
set @nomCategoria= UPPER('Bebidas')

IF (Select count(p.IdProducto)
    From productos p INNER JOIN Categorias c 
         ON p.IdCategoria = c.IdCategoria
    Where UPPER(c.Nombre) = @nomCategoria) >= 10 
BEGIN
     Update Productos 
	 Set PrecioUnidad = PrecioUnidad + (PrecioUnidad * 0.20)
	 Where IdCategoria = (Select IdCategoria 
                          From Categorias 
                          Where UPPER(Nombre) = @nomCategoria)
END
ELSE BEGIN
   Print 'No existe sufientes productos para incremetar'
END
GO