<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<%
nivel=5 'Nivel minimo de acceso
%>
<!-- #include file ="../log.dll" -->
	<!-- #include file ="../conexion.dll" -->
<%
select case request("id")
case ""
credito=request("credito")
descuento=(request("descuento")-100)*(-1)
descuento=(descuento/100)
set tabla=bdd.execute("Select * from cobranza where credito = '"&credito&"' and cuota > '0'")
	if not tabla.eof then
		mnc=tabla("monto")*descuento
%>
<script>
if (confirm("Estimado <%=session("nombre")%>, el nuevo monto de las cuotas seria <%=FormatNumber(mnc)%> \n \n ¿Esta seguro con realizar esta transaccion?"))
window.location='?id=1&mnc=<%=mnc%>&credito=<%=credito%>'
else
window.location='descuento.asp?id=15'
</script>
<%		
	end if
case "1"
set tabla=bdd.execute("Update cobranza set monto = '"&request("mnc")&"' where credito = '"&request("credito")&"' and cuota > '0'")
%>
<script>
alert('descuento realizado')
window.location='descuento.asp?id=15'
</script>
<%
end select
%>