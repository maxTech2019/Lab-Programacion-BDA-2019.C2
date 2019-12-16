use pedidos
go
drop function calcularIVA;
go

--Creando la Función calcularIVA.
CREATE FUNCTION calcularIVA (@monto float)
RETURNS float
AS
BEGIN
   RETURN (@monto * 0.12)
END 
--Ejecutar la función calcularIva como una expresión.
SELECT p.NombreProducto, p.PrecioUnidad, dbo.calcularIVA(PrecioUnidad) as IVA
FROM Productos p INNER JOIN Categorias c ON p.IdCategoria = c.IdCategoria
WHERE UPPER(c.Nombre) = 'BEBIDAS';
--->
create function montoTotal (@precio float)
returns float
as
begin
 declare
   @iva float,
   @total float = 0
   set @iva = @precio * 0.12 --Calculamos IVA
   set @total = @precio + @iva --Sumanos PVP + IVA
   return @total
end
---->
SELECT p.NombreProducto, p.PrecioUnidad, 
       dbo.calcularIVA(p.PrecioUnidad) as IVA, dbo.montoTotal(p.PrecioUnidad) as Total
FROM Productos p INNER JOIN Categorias c ON p.IdCategoria = c.IdCategoria
WHERE UPPER(c.Nombre) = 'BEBIDAS';

--->Funcion Tabla en linea.
drop function listaClientesCiudad;

CREATE FUNCTION listaClientesCiudad (@nomCiudad varchar(30))
RETURNS TABLE
AS
 RETURN( Select c.Nombre, c.Direccion, c.Telefono
                  From Clientes c
                  Where UPPER(c.Ciudad) = UPPER(@nomCiudad))
GO
--->
select *
from dbo.listaClientesCiudad('Londres');



