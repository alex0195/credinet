<!-- #include file ="../conexion.dll" -->
<%
cedula=request("cedula")
codigo=request("codigo")
set tabla=bdd.execute("update credito set Codigo = '"&codigo&"' where Cliente = '"&cedula&"'")
%>
<script>
alert('Codigo de cliente modificado');
window.location='mod_codigo.asp?id=111';
</script>
