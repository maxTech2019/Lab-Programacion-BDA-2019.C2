Use Pedidos
Declare
@mPrecio numeric(19,2),
@mDescuento numeric(4,2)
Select @mPrecio=AVG(p.PrecioUnidad)
From Productos p inner join Categorias c  on p.IdCategoria = c.IdCategoria
Where UPPER(c.Nombre) = 'CARNES'
Set @mDescuento= (Case 
                    when @mPrecio < 99 Then 0.10
                    when @mPrecio between 100 and 200 Then 0.20
                    when @mPrecio between 201 and 300 Then 0.30
                    else 0.05
                  End)
Print 'El descuento es: '+ cast(@mDescuento as nvarchar(20))
GO