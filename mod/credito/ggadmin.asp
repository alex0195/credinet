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
campo "mue","id","tc","COSTO DEL EQUIPO",FormatNumber(tabla("costo"))
campo "mue","id","tad","INICIAL PROPUESTA BS.",FormatNumber(tabla("costo")*0.475)
campo "mue","id","ati","INICIAL A PAGAR BS.",FormatNumber(request("ti"))
campo "mue","id","atf","FRECUENCIA DE PAGO",request("tf")
campo "mue","id","atp","MESES",request("tp")
set mytabla = bdd.execute("Insert into temp_credito2(credito,tipo,plazo) values ('"&request("id")&"','"&request("tf")&"','"&request("tp")&"')")
inicial=replace(request("ti"),".",",")
inicial=bsf(inicial)
mf=(tabla("costo")-inicial)*1.9
pc=inicial+mf
c1=mf
c2=0.688105217516983*mf
c3=0.470299020599692*mf
c4=0.362950964496071*mf
c5=0.299844312825308*mf
c6=0.258913484423088*mf
c7=0.23070725785392*mf
c2=round(c2/1)*1
c3=round(c3/1)*1
c4=round(c4/1)*1
c5=round(c5/1)*1
c6=round(c6/1)*1
c7=round(c7/1)*1
c2=c2+1
c3=c3+1
c4=c4+1
c5=c5+1
c6=c6+1
c7=c7+1
Select case request("tp")
	case 1
	valor=c1
	case 2
	valor=c2
	case 3
	valor=c3
	case 4
	valor=c4
	case 5
	valor=c5
	case 6
	valor=c6
	case 7
	valor=c7
end select
select case request("tf")
	case "MENSUAL"
		valor=valor
		cantidad=request("tp")
		frecuencia="MENSUALES"
	case "QUINCENAL"
		valor=valor/2
		cantidad=request("tp")*2
		frecuencia="QUINCENALES"
	case "SEMANAL"
		valor=valor/4
		cantidad=request("tp")*4
		frecuencia="SEMANALES"
end select
campo "mue","id","mdc","MONTO DE LA CUOTA BS.",FormatNumber(valor)
campo "mue","id","de","DESCUENTO * BS.",FormatNumber(valor*0.1)
campo "mue","id","2de","DESCUENTO ** BS.",FormatNumber((valor-(valor*0.1))*0.1)
campo "mue","id","mnp",cantidad&" CUOTAS "&frecuencia&" DE BS.","<b>"&FormatNumber(((valor*0.9)*0.9))&"</b>"
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