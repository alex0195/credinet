<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<link rel="stylesheet" type="text/css" href="../style/Oxygen.css" />
<body><SCRIPT language=JavaScript src="../form_validator.js" type=text/javascript></SCRIPT>
<script>
function cambiar(objeto,metodo)
{
document.datos.action="?id=<%=request("id")%>&metodo="+metodo
document.datos.submit()
}
</script>
<!-- #include file ="../conexion.dll" -->
</head>
<style type="text/css">
<!--
.Estilo1 {
	font-family: Arial, Helvetica, sans-serif;
	font-size: 10px;
}
-->
</style>
<body>
<div id="puninstall" style="margin: auto 5% auto 5%"><div class="pun"><div class="block">
  <h2 align="center">Inventario de Equipos</h2>
  <div class="box">
<div class="inbox">
<%
credito=request("id")
set tabla=bdd.execute("Select Equipo from credito where id = "&credito)
if not tabla.eof then
set tabla2=bdd.execute("Select * from inventario where Id = "&tabla("Equipo"))
%>
<form action="credito3.asp?equipo=<%=tabla("Equipo")%>" method="post" name="datos">
<table width="100%" border="0" cellspacing="0" cellpadding="0"><tr>
<!-- #include file ="../as/funciones.asp" -->
<%
modificar tabla2("Factura"),"factura","FACTURA"
modificar tabla2("Serial"),"serial","SERIAL"
campo "btn","id","cont2","",""
%>
</table></form>
 <SCRIPT language=JavaScript type=text/javascript>
var frmvalidator  = new Validator("datos");
frmvalidator.addValidation("factura","req","Es necesaria esta informacion");
frmvalidator.addValidation("serial","req","Es necesaria esta informacion");
</script>
		</div></div> </div></div></div></body></html>
<%else
%>
<script>
alert('Credito anulado o inexistente');
window.location='credito1.asp?id=15';
</script>
<%
end if
%>
<!-- #include file ="../desconexion.dll" -->