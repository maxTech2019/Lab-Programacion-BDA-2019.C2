Use Pedidos
Declare
@mCategoria nvarchar(20),
@inversion numeric(19,2)
set @mCategoria = 'CONDIMENTOS'
Set @inversion = (Case 
                    when @mCategoria='BEBIDAS'  Then (Select SUM(PrecioUnidad) 
					                                  From Productos
													  Where IdCategoria =1)
					when @mCategoria='CONDIMENTOS'  Then (Select SUM(PrecioUnidad) 
					                                  From Productos
													  Where IdCategoria =2)
                    else 0.00
                  End)
Print 'La inversión es: '+ cast(@inversion as nvarchar(20))
GO