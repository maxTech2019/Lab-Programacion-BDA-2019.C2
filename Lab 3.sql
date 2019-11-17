use pedidos
go
select E1.IdEmpleado, E1.Nombre, E1.Apellidos,
  (Select Case Datepart(q, E.FechaNac)
           When 1 then 'Verano'
           When 2 then 'Otoño'
           When 3 then 'Invierno'
           Else 'Primavera'
          End
   from Empleados As E 
   where E.IdEmpleado = E1.IdEmpleado) As 'Estación'
from Empleados As E1
go