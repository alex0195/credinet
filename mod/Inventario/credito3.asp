<!-- #include file ="../conexion.dll" -->
<%
equipo=request("equipo")
set tabla=bdd.execute("update inventario set Factura = '"&request("factura")&"', Serial = '"&request("serial")&"' where Id = "&equipo)
%>
<script>
alert('Equipo actualizado');
window.location='credito1.asp?id=15';
</script>
