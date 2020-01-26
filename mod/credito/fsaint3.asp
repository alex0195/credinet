<!-- #include file ="../conexion.dll" -->
<%
credito=request("ref")
set tabla=bdd.execute("update credito set factura_saint = '"&request("factura")&"' where Id = "&credito)
%>
<script>
alert('Credito Actualizado');
window.location='fsaint1.asp';
</script>
