<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<!-- #include file ="../log.dll" -->
<!-- #include file ="../conexion.dll" -->
<link rel="stylesheet" type="text/css" href="../style/Oxygen.css" />
<%sql="Select * from "
sql=sql + "((credito INNER JOIN dpersonales ON (dpersonales.t1=credito.cliente)) "
sql=sql + "INNER JOIN inventario ON (inventario.id=credito.equipo)) "
sql=sql + "INNER JOIN dreferencia ON (dpersonales.t1=dreferencia.t1)"
sql=sql + "where credito.id='"&request("id")&"'"
set tabla = bdd.execute(sql)
if tabla.eof then response.Write("Se ha generado un error grave en sistema favor notifique al administrador")%>
<body><SCRIPT language=JavaScript src="form_validator.js" type=text/javascript></SCRIPT>
<div id="puninstall" style="margin: auto 1% auto 1%">
<div class="pun"><div class="block"><h2 align="center"><span>CRONOGRAMA DE PAGOS DE CREDITO</span></h2><div class="box"><div class="inbox">
<script>
function cambiar(objeto,metodo)
{
document.datos.action="?id=<%=request("id")%>&metodo="+metodo
document.datos.submit()
}
</script>
<table width="100%" border="0" cellspacing="0" cellpadding="0"><tr>

<form method="post" action="gpagos.asp?id=<%=request("id")%>" name="datos">

<!-- #include file ="../as/funciones.asp" -->
<%

set mytabla = bdd.execute("Insert into temp_credito2(credito,tipo,plazo) values ('"&request("id")&"','"&request("tf")&"','"&request("tp")&"')")
inicial=replace(request("ti"),".",",")
inicial=bsf(inicial)
valor=replace(request("ti"),".",",")
valor=bsf(inicial)
cantidad=request("tp")

finicial=date()
dia=Day(finicial)
mes=Month(finicial)
ano=Year(finicial)
finicial=ano&"-"&mes&"-"&dia
set tabla=bdd.execute("Select * from temp_cobranza where credito = '"&request("id")&"' and cuota = '0'")
if tabla.eof then
tabla.close
set tabla = bdd.execute("Insert into dcobrar(cuota,credito,fecha) values ('0','"&request("id")&"','"&finicial&"')")
set tabla = bdd.execute("Insert into temp_cobranza(cuota,credito,monto,estado,fecha) values ('0','"&request("id")&"','"&inicial&"','0','"&finicial&"')")
else
tabla.close
end if
for i = 1 to 28
if request("c"&i) <> "" then '1
if IsDate(request("c"&i)) = True then '2
'Verificamos q la fecha de la cuota sea mayor a la anterior
'	if(request("c"&i)<=request("c"&i-1)) then '3
		
		
	campo "mue","id","cx","CUOTA "&i,request("c"&i)
	dia=Day(request("c"&i))
	mes=Month(request("c"&i))
	ano=Year(request("c"&i))
finicial=ano&"-"&mes&"-"&dia
	set tabla=bdd.execute("Select * from temp_cobranza where credito = '"&request("id")&"' and cuota = '"&i&"'")
	if tabla.eof then'4	
	tabla.close
	set tabla = bdd.execute("Insert into dcobrar(cuota,credito,fecha) values ('"&i&"','"&request("id")&"','"&finicial&"')")
	set tabla = bdd.execute("Insert into temp_cobranza(cuota,credito,monto,estado,fecha) values ('"&i&"','"&request("id")&"','"&valor&"','0','"&finicial&"')")
	else'4
	set tabla3 = bdd.execute("Update temp_dcobrar set fecha = '"&finicial&"' where credito = '"&request("id")&"' and cuota = '"&i&"'")
set tabla4 = bdd.execute("Update temp_cobranza set fecha = '"&finicial&"' and monto = '"&valor&"' where credito = '"&request("id")&"' and cuota = '"&i&"'")
	tabla.close
	end if'4
	'end if'3
	else'2%>
<script>
alert('Estimado analista <%=request("c"&i)%> no es una fecha verifique primero antes de solicitar enviar informacion al sistema')
history.back()
</script>
<%end if'2
end if'1
next%>
<script>
//alert('Se ha notificado al departamento de cobranza')
alert('Registre los datos del pago de la inicial para imprimir los datos del financiamiento')
location.href='activar.asp?id=<%=request("id")%>'
</script>
</table></form>
<SCRIPT language=JavaScript 
src="../wz_tooltip.js" 
type=text/javascript></SCRIPT>
</div></div></div></div></div>
<!-- #include file ="../desconexion.dll" -->