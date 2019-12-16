--Implementamos la funcion
create function validarCedulaIdentidad (@ced nvarchar(15))
 returns int
as
begin
   declare @i int,@longi int, @sw int
   declare @sumimpar int, @sumpar int,@aux int,@total int, @digito int
   set @sumpar=0
   set @sumimpar=0  
   set @aux=0
   set @total=0
   set @digito=0
     set @longi=len(rtrim(@ced))
       if @longi<10 or @longi>10 begin
          set @sw=2
       end
       else begin
            set @i=1
            while(@i<=@longi-1) begin
                if (@i%2=0)begin
                  set @sumpar = @sumpar + convert(int,substring(@ced,@i,1))
                end
                else begin
                  set @aux=convert(int,substring(@ced,@i,1))*2
                  if @aux>9  set @aux=@aux-9
                  set @sumimpar=@sumimpar+@aux
                end
                set @i=@i+1
            end
            set @total=@sumpar+@sumimpar
            if(@total%10=0)begin
              set @digito=0
            end
            else begin
              set @digito =((@total/10)+1)*10
              set @digito =@digito-@total
            end
            if (convert(int,substring(@ced,@i,@longi))= @digito)
              set @sw=1
            else
              set @sw=0
        end
        return @sw
end;
go

--Ejecutamos el Store Procedure       
declare @r int 
exec spu_validCI '1802846186',@r output
 if (@r=1) select 'Numero de Cedula Correcta  ' as 'Resultado'
 if (@r=2) select 'Error en Longitud  ' as 'Resultado'
 if (@r=0) select 'Numero de Cedula Incorrecta  ' as 'Resultado'

    

