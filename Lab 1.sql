-- Esto es un comentario de línea simple.

/*  Este es un comentario con varias líneas. 
    Conjunto de Líneas. */ 

declare @nombre varchar(50)-- declare declara una variable
                           -- @nombre es el identificador de la
                           -- variable de tipo varchar 

set @nombre = 'www.Microsoft.com' -- El signo = es un operador
                                  -- www.Microsoft.com es un literal 

print @Nombre -- Imprime por pantalla el valor de @nombre.                
              -- No diferencia mayúsculas ni minúsculas
---------------------------------------------------------------->>>>>
DECLARE @bit bit,   
@tinyint tinyint,
@smallint smallint,   
@int int,    
@bigint bigint,   
@decimal decimal(10,3), -- 10 digitos, 7 enteros y 3 decimales
@real real,   
@double float(53),
@money money 

set @bit = 1 
print @bit 
set @tinyint = 255 
print @tinyint 
set @smallint = 32767 
print @smallint  
set @int = 642325 
print @int 
set @decimal = 56565.234  -- Punto como separador decimal 
print @decimal 
set @money = 12.34 
print @money 

--------------------------------------------------------------->>>>
DECLARE @codigounico UNIQUEIDENTIFIER
set @codigounico = NEWID()
print cast(@codigounico as varchar(36))

CREATE TYPE tipoMD5 
FROM CHAR(7) NULL   
GO   
DECLARE @mivariable tipoMD5   
set @mivariable = ‘123456A'   
print @mivariable
GO 

/*Tipos de Asignación de Variables*/

USE Pedidos
DECLARE @nombre VARCHAR(50)
SET @nombre =  (SELECT NombreProducto
                FROM Productos
                WHERE IdProducto = 1)
PRINT @nombre
----------------------------------------------->>>>>
USE Pedidos
DECLARE 
@nombre VARCHAR(50),
@apellido VARCHAR(50),
@cargo VARCHAR(30)

SELECT @nombre=Nombre, @apellido=Apellidos, 
       @cargo=Cargo
FROM Empleados
WHERE IdEmpleado = 1
PRINT 'Su nombre completo es: ' + @nombre + ' ' +
      @apellido +' y su cargo : '+ @cargo
GO 
-------------------------------------------------------->>>>
USE Pedidos
DECLARE @nombre nvarchar(40),
@categoria nvarchar(15),
@precio numeric(19,2)
DECLARE cProductos CURSOR FOR
SELECT p.NombreProducto, c.Nombre, p.PrecioUnidad
FROM Productos p INNER JOIN Categorias c
ON p.IdCategoria = c.IdCategoria
WHERE UPPER(c.Nombre) = UPPER('Bebidas')
OPEN cProductos
FETCH cProductos INTO @nombre, @categoria, @precio
WHILE (@@FETCH_STATUS = 0) BEGIN
  PRINT @nombre + '--'+ @categoria+'--'+ Cast(@PRECIO as nvarchar(20))
  FETCH cProductos INTO @nombre, @categoria, @precio
END
CLOSE cProductos
DEALLOCATE cProductos
GO 

