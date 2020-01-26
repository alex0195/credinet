<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<link rel="stylesheet" type="text/css" href="../style/Oxygen.css" />
<%
nivel=7 'Nivel minimo de acceso
%>
<!-- #include file ="../log.dll" -->
	<!-- #include file ="../conexion.dll" -->
<body><SCRIPT language=JavaScript src="form_validator.js" type=text/javascript></SCRIPT>
<div id="puninstall" style="margin: auto 1% auto 1%">
<div class="pun"><div class="block"><h2 align="center"><span>INGRESE EL CREDITO A DESCONTAR</span></h2><div class="box"><div class="inbox">
<form action="descuento2.asp" method="post" name="datos">
<table width="100%" border="0" cellspacing="0" cellpadding="0"><tr>
<!-- #include file ="../as/funciones.asp" -->
<%
campo "num","id","credito","CREDITO A DESCONTAR","Escriba el numero de Credito"
campo "num","id","descuento","PORCENTAJE DE DESCUENTO %","Descuento a otorgar"
campo "btn","id","cont","",""
%>
</table></form>
 <SCRIPT language=JavaScript type=text/javascript>
var frmvalidator  = new Validator("datos");
frmvalidator.addValidation("credito","req","Es necesaria esta informacion");
frmvalidator.addValidation("credito","num","Es necesaria esta informacion");
frmvalidator.addValidation("descuento","req","Es necesaria esta informacion");
frmvalidator.addValidation("descuento","num","Es necesaria esta informacion");
</script>
<!-- #include file ="../desconexion.dll" -->
<SCRIPT language=JavaScript 
src="wz_tooltip.js" 
type=text/javascript></SCRIPT>
</div></div></div></div></div>