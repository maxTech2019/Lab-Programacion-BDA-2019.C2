SELECT * FROM SYS.TRIGGERS

--->TRIGGER INSERCION
CREATE TRIGGER trg_Producto_Inserta
ON Productos
FOR INSERT
AS
Declare @total int
SELECT  @total=COUNT (*) 
FROM INSERTED, Productos 
WHERE INSERTED.NombreProducto = Productos.NombreProducto
IF  (@total>1) BEGIN
  ROLLBACK TRANSACTION 
  PRINT 'EL PRODUCTO YA SE ENCUENTRA REGISTRADO' 
END
ELSE
PRINT 'EL PRODUCTO FUE INGRESADO EN LA BASE DE DATOS' 
GO 

INSERT INTO Productos Values ('Tortillas Mexicanas',7,3,12.5,15,50,0)

---->TRIGGERS ELIMINACION
CREATE TRIGGER trg_EliminacionCliente
ON Clientes
FOR DELETE
AS
 IF EXISTS (SELECT * FROM Pedidos
            WHERE Pedidos.IdCliente = (SELECT IdCliente FROM DELETED) )
 BEGIN
    ROLLBACK TRANSACTION 
    PRINT 'EL CLIENTE TIENE REGISTRADO POR LO MENOS 1 PEDIDOS' 
END
--->EJECUCIÓN
BEGIN TRY
  delete
  from Clientes
  where Clientes.IdCliente='WOLZA'
END TRY
BEGIN CATCH
 PRINT 'SE HA PRODUCIDO UN ERROR '+ ERROR_MESSAGE()
END CATCH

------>TRIGGERS ACTUALIZACION
CREATE TRIGGER trg_Producto_Actualizando
ON Productos
FOR UPDATE
AS
IF (SELECT PrecioUnidad  FROM INSERTED) <=0 OR 
   (SELECT UnidadesEnExistencia FROM INSERTED)<=0
BEGIN
 PRINT 'EL PRECIO O UNIDADESENEXISTENCIA DEBEN SER MAYOR A CERO' 
 ROLLBACK TRANSACTION 
END 
----->
DROP TRIGGER trg_Producto_Actualizando
--->EJECUCIÓN
BEGIN TRY
 update Productos
 set PrecioUnidad=PrecioUnidad + (PrecioUnidad * 0.2)
 where IdProducto=17
END TRY
BEGIN CATCH
 PRINT 'SE HA PRODUCIDO UN ERROR '+ ERROR_MESSAGE()
END CATCH

--->TRIGGER 
CREATE TRIGGER trg_Producto_Actualizar_STOCK
ON Productos
FOR UPDATE
AS
 IF UPDATE(UnidadesEnExistencia) BEGIN
   PRINT 'NO SE PUEDE ACTUALIZAR LA EXISTENCIA DEL PRODUCTO' 
   ROLLBACK TRANSACTION 
 END 

 --->EJECUCIÓN
BEGIN TRY
 update Productos
 set UnidadesEnExistencia= UnidadesEnExistencia - 1
 where IdProducto=33
END TRY
BEGIN CATCH
 PRINT 'SE HA PRODUCIDO UN ERROR '+ ERROR_MESSAGE()
END CATCH

----> ACTUALIZAR STOCK AL INSERTAR UN PEDIDO
CREATE TRIGGER TRG_CONSTROL_STOCK_PEDIDOS
  ON DPEDIDOS
  FOR INSERT
  AS
   DECLARE @Stock_Producto INT, @Cant_Vender INT
   SELECT @Stock_Producto = UnidadesEnExistencia FROM Productos , inserted
   WHERE Productos.IdProducto = inserted.IdProducto

   SELECT @Cant_Vender = Cantidad FROM inserted
   
   IF (@Cant_Vender < @Stock_Producto ) BEGIN
     UPDATE Productos SET UnidadesEnExistencia = UnidadesEnExistencia - @Cant_Vender
     WHERE IdProducto = (Select IdProducto From Inserted)
  END
  ELSE BEGIN
    RAISERROR ('HAY MENOS PRODUCTOS EN STOCK DE LOS SOLICITADOS PARA LA VENTA', 16, 1)
    ROLLBACK TRANSACTION
  END
GO

--->EJECUTAR TRIGGER
DISABLE TRIGGER trg_Producto_Actualizar_STOCK
   ON Productos
GO

Select IdProducto, NombreProducto,UnidadesEnExistencia, PrecioUnidad
From Productos
Where idProducto=59;

Select * 
From DPedidos
Where IdPedido=10249;

BEGIN TRY
 INSERT INTO DPedidos (IdPedido,IdProducto,PrecioVenta,Cantidad,Descuento) 
 VALUES(10249,59,125,1,0);
END TRY
BEGIN CATCH
 PRINT 'SE HA PRODUCIDO UN ERROR '+ ERROR_MESSAGE()
END CATCH
