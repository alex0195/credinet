<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<!-- #include file ="../conexion.dll" -->
<%
set c_cedula=bdd.execute("Select * from dsolicitud where t1 = '"&request("factura")&"' or t1 = '"&request("serial")&"' ")
	if not c_cedula.eof then
		%>
		<script>
alert('Para registrar la compra se hacen necesarios el número de serial y el número de factura');
window.history.go(-2);		
		</script>
		<%	
else
costo=replace(request("costo"),".",",")
base=replace(request("base"),".",",")
sql="insert into inventario(provedor,marca,modelo,serial,base,costo,fecha,factura,documento) values ('"&UCase(request("provedor"))&"','"&UCase(request("marca"))&"','"&UCase(request("modelo"))&"','"&UCase(request("serial"))&"','"&bsf(base)&"','"&bsf(costo)&"',now(),'"&UCase(request("factura"))&"','"&UCase(request("doc"))&"')"
set tabla = bdd.execute(sql)

'Area de Historia
fhistoria=date()
dia=Day(fhistoria)
mes=Month(fhistoria)
ano=Year(fhistoria)
fhistoria=ano&"-"&mes&"-"&dia
sql="Insert into historia (autor,operacion,ref,fecha) values ('"&session("codigo")&"','104','"&request("t1")&"','"&fhistoria&"') "

set historia=bdd.execute(sql)
'Fin historia
'response.Write(sql)
response.Redirect("index.asp")

	end if
c_cedula.close

%>
<!-- #include file ="../desconexion.dll" -->