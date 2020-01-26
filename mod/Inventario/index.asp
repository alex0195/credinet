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
<!-- #include file ="../mssql.dll" -->
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
<form action="gdi.asp" method="post" name="datos">
<%select case request("id")
case ""

set tabla=bdd.execute("Select * from inventario where estado is null")
if tabla.eof then response.Write("<br><center>No se encontraron Productos</center><br>")
do while not tabla.eof%>
<p><table width="100%" border="0" cellspacing="0" cellpadding="0"><tr>
<td width="40%"><%=tabla("Marca")&" "&tabla("Modelo")%> 
<%if session("nivel") >= 8 then%>
<a href="eliminar.asp?id=<%=tabla("Id")%>">(Eliminar)</a>
<%end if%>
</td><td width="40%"><%=tabla("Serial")%></td><td width="20%"><%=tabla("costo")%>
</td></tr></table>
</p>
<%tabla.movenext
loop
response.Write("<a href=index.asp?id=rif>Agregar Nuevo Producto</a>")
case "rif"
%>
<form action="gdi.asp" method="post" name="datos">
<table width="100%" border="0" cellspacing="0" cellpadding="0"><tr>
<!-- #include file ="../as/funciones.asp" -->
<%campo "tex","id","marca","MARCA","Marca del Equipo"
campo "tex","id","modelo","MODELO","Modelo del Equipo"
campo "tex","id","serial","SERIAL","Serial Electronico"
campo "num","id","base","COSTO PROVEEDOR","Escriba el monto del costo del Equipo"
campo "num","id","costo","COSTO VENTA CLIENTE","Escriba el monto del costo del Equipo"
campo "tex","id","factura","FACTURA","Factura del Equipo"

campo "sel","id","provedor","PROVEEDOR",""
	opcion1 "id","provedor","",""
set tabla=bdd_mssql.execute("Select CodProv,Descrip from SAPROV")
do while not tabla.eof
	opcion1 "id","provedor",tabla("Descrip"),tabla("CodProv")
tabla.movenext
loop
tabla.close
	cierre "sel","id","provedor"

campo "sel","id","doc","DOCUMENTO",""
	opcion "id","doc","FACTURA"
	cierre "sel","id","doc"
campo "btn","doc","cont","",""
%>
</table></form>
 <SCRIPT language=JavaScript type=text/javascript>
var frmvalidator  = new Validator("datos");
frmvalidator.addValidation("provedor","req","Es necesaria esta informacion");
frmvalidator.addValidation("marca","req","Es necesaria esta informacion");
frmvalidator.addValidation("modelo","req","Es necesaria esta informacion");
frmvalidator.addValidation("serial","req","Es necesaria esta informacion");
frmvalidator.addValidation("base","req","Es necesaria esta informacion");
frmvalidator.addValidation("costo","req","Es necesaria esta informacion");
//frmvalidator.addValidation("costo","num","Unicamente Numeros");
frmvalidator.addValidation("factura","req","Es necesaria esta informacion");
frmvalidator.addValidation("doc","req","Es necesaria esta informacion");
</script>
<%end select%>
		</div></div> </div></div></div></body></html>
<!-- #include file ="../desconexion.dll" -->