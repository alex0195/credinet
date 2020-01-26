<%
nivel=3 'Nivel minimo de acceso
%>
<link rel="stylesheet" type="text/css" href="../style/Oxygen.css" />
<!-- #include file ="../log.dll" -->

<body><SCRIPT language=JavaScript src="form_validator.js" type=text/javascript></SCRIPT>
<div id="puninstall" style="margin: auto 1% auto 1%">
<div class="pun"><div class="block"><h2 align="center"><span>MODULO DE ADJUDICACION DE EQUIPOS</span></h2><div class="box"><div class="inbox">

<script>
function cambiar(objeto,metodo)
{
document.fecha.action="?id="+<%=request("id")%>+"&guid="+metodo
document.fecha.submit()
}
</script>
<!-- #include file ="../conexion.dll" -->
<%select case request("id")
case ""
'El caso blanco es para consultar al analista si desea realizar la operacion en caso de ser afirmativo pasa al id=1 si no lo devuelve hasta antes de inventar...
sql="Select * from"
sql = sql + " dpersonales, inventario where dpersonales.t1="&request("t1")&" and inventario.Id="&request("equipo")
Set tabla=bdd.execute(sql)
marca=tabla("marca")
modelo=tabla("modelo")
serial=tabla("serial")
nombres=tabla("t3")
apellidos=tabla("t2")
tabla.close%>
<script>
if (confirm("Estimado <%=session("nombre")%>, va a adjudicar un producto con las siguientes caracteristicas \n \n Producto: <%=Marca%> - <%=Modelo%> \n Serial: <%=Serial%> \n Cliente: <%=nombres%> - <%=apellidos%> \n \n ¿Esta de acuerdo con realizar esta transaccion?"))
window.location='?id=1&t1=<%=request("t1")%>&equipo=<%=request("equipo")%>&codigo=<%=request("codigo")%>';
else
window.history.go(-4);
</script>
<%case "1"
set tabla=bdd.execute("Insert into credito(Cliente,Equipo,Fecha,Codigo,analista) values ('"&request("t1")&"','"&request("equipo")&"',now(),'"&request("codigo")&"','"&session("codigo")&"')")
set tabla1=bdd.execute("Select id from credito where Cliente='"&request("t1")&"' and equipo='"&request("equipo")&"'")
idtemp=tabla1("id")
tabla1.close
set tabla=bdd.execute("Insert into temp_credito(id,Cliente,Equipo,Fecha,Codigo,analista) values ("&idtemp&",'"&request("t1")&"','"&request("equipo")&"',now(),'"&request("codigo")&"','"&session("codigo")&"')")
'Este caso actualiza el equipo y el cliente para que no sigan a la espera ni el quipo disponible
'El estado 1 corresponde a que el equipo ha sido entregado
set tabla=bdd.execute("Update inventario set estado = '1', cliente='"&request("t1")&"', analista='"&session("codigo")&"' where id="&request("equipo"))
'El estado 5 corresponse que se le acaba de otorgar un equipo
set tabla=bdd.execute("Update dsolicitud set estado = '5' where t1="&request("t1"))
'Area de Historia
fhistoria=date()
dia=Day(fhistoria)
mes=Month(fhistoria)
ano=Year(fhistoria)
fhistoria=ano&"-"&mes&"-"&dia
set historia=bdd.execute("Insert into historia (autor,operacion,ref,fecha) values ('"&session("codigo")&"','105','"&request("t1")&"','"&fhistoria&"') ")
'Fin historia	
	'set tabla=bdd.execute("Select * from dvendedor where t1='"&request("t1")&"'")
		'if tabla.eof then
		'	tabla.close
'			set tabla=bdd.execute("Insert into dvendedor(t1,vendedor) values ('"&request("t1")&"','"&request("vendedor")&"')")
		'end if

'Modulo que agrega el NIC para la manipulacion de datos desde internet.
	set tabla2=bdd.execute("Select * from credito where Cliente = '"&request("t1")&"' and nic is not null")
	if not tabla2.eof then
		set tabla3=bdd.execute("Update credito set nic = '"&tabla2("nic")&"' where Cliente = '"&request("t1")&"'")
	else
		randomize
		num = Int((999999999999999 - 111111111111111 + 1) * Rnd + 1) 
		contador=num
		cantdigitos = 15
		'Comprobamos la cantidad de caracteres del contador
		cantcont = Len(contador) 
		For i = 1 to cantdigitos - cantcont
			   contador = "0" & contador 
		Next 
		set tabla3=bdd.execute("Update credito set nic = '"&contador&"' where Cliente = '"&request("t1")&"'")
	end if
	tabla2.close

'Fin de modulo
%>
<script>
alert('Se adjudico correctamente el equipo al cliente')
//alert('Se registro el cliente para el vendedor asignado')
window.location='?id=2&equipo=<%=request("equipo")%>';
</script>
<%case "2"
'///////////////////////////////////////////////////////////////////////////////////////////////////
'Esta es una consulta multiple que utiliza 3 tablas..... (Invetario a, Provedores b, Dpersonales c)
'Sql="Select * from"
'sql = sql + " ((inventario as a Join provedores as b on (a.provedor=b.Id))"
'sql = sql + " Join dpersonales as c on (a.cliente=c.t1))"
'sql = sql + " where a.id="&request("equipo")
'Set tabla=bdd.execute(sql)
'set mytabla=bdd.execute("Insert into ccobrar(fecha,equipo,monto,empresa,observaciones,estado) values (now(),'"&request("equipo")&"','"&tabla("incentivo")&"','"&tabla("nombre")&"','Comision por compra de "&tabla("marca")&" - "&tabla("modelo")&" para "&tabla("t2")&" "&tabla("t3")&"',0)")
'tabla.close%>
<script>
//alert('Se notifico al departamento de administracion los detalles de la operacion')
window.location='?id=3&equipo=<%=request("equipo")%>';
</script>
<%case "3"
	set tabla=bdd.execute("Select id from credito where equipo='"&request("equipo")&"'")
	
	response.Redirect("pagos.asp?id="&tabla("Id"))
tabla.close

%>
<SCRIPT language=JavaScript 
src="wz_tooltip.js" 
type=text/javascript></SCRIPT>
</div></div></div></div></div>
<%end select%>
<!-- #include file ="../desconexion.dll" -->