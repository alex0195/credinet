<!-- #include file ="../conexion.dll" -->
<%
credito=request("credito")
set tabla=bdd.execute("update credito set activo = 0 where Id = "&credito)
%>
<script>
alert('Credito Anulado');
window.location='anulacion1.asp?id=111';
</script>
