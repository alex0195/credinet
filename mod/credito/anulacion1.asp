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
  <h2 align="center">Anulacion de Credito</h2>
  <div class="box">
<div class="inbox">
<form action="anulacion2.asp" method="post" name="datos">
<table width="100%" border="0" cellspacing="0" cellpadding="0"><tr>
<!-- #include file ="../as/funciones.asp" -->
<%
modificar "","credito","CREDITO"
campo "btn","id","cont2","",""
%>
</table></form>
 <SCRIPT language=JavaScript type=text/javascript>
var frmvalidator  = new Validator("datos");
frmvalidator.addValidation("credito","req","Es necesaria esta informacion");
</script>
		</div></div> </div></div></div></body></html>
<!-- #include file ="../desconexion.dll" -->