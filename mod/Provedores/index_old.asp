<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<link rel="stylesheet" type="text/css" href="../style/Oxygen.css" />
<body><SCRIPT language=JavaScript src="../form_validator.js" type=text/javascript></SCRIPT>
<script>
function cambiar(objeto,metodo)
{
document.datos.action="?id="+objeto+"&metodo="+metodo
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
  <h2 align="center">Proveedores de equipos</h2>
  <div class="box">
<div class="inbox">

<%select case request("id")
case ""
set tabla=bdd.execute("Select * from provedores order by Nombre asc")
if tabla.eof then response.Write("<br><center>No se encontraron Provedores</center><br>")
do while not tabla.eof%>
<p><table width="100%" border="0" cellspacing="0" cellpadding="0"><tr>
<td width="20%"><%=tabla("rif")%></td>
<td width="40%"><%=tabla("nombre")%></td>
<td width="20%"><%=tabla("telefono")%></td>
<td width="20%"><%=tabla("telefonia")%>
</td></tr></table>
</p>
<%tabla.movenext
loop
response.Write("<a href=index.asp?id=rif>Agregar Nuevo Proveedor</a>")
case "rif"
%>
<%if request("rif") <> "" then%>
<form action="gdp.asp" method="post" name="datos">
<%else%>
<form action="#" method="post" name="datos">
<%end if%>
<table width="100%" border="0" cellspacing="0" cellpadding="0"><tr>
<!-- #include file ="../as/funciones.asp" -->
<%campo "tex","id","rif","RIF","Esciba el Rif del Proveedor"
campo "tex","rif","nombre","EMPRESA","Escriba el Nombre de la empresa"
campo "tex","rif","direccion","DIRECCION","Escriba la direccion"
campo "tex","rif","telefono","TELEFONO","Escriba el telefono"
campo "tex","rif","operadora","OPERADORA","Escriba la operadora con la que trabaja"
campo "num","rif","incentivo","INCENTIVO POR COMPRA","Escriba el monto de incentivo por ventas"
campo "btn","rif","cont","",""
%>
</table></form>
<%end select%>
		</div>
	</div>
</div>
</div>
</div>
</body>
</html>
<!-- #include file ="../desconexion.dll" -->