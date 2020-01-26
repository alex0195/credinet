<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<link rel="stylesheet" type="text/css" href="../style/Oxygen.css" />
<%
credito=request("id")
nivel=3 'Nivel minimo de acceso
%>
<!-- #include file ="../log.dll" -->
	<!-- #include file ="../conexion.dll" -->
<body><SCRIPT language=JavaScript src="form_validator.js" type=text/javascript></SCRIPT>
<div id="puninstall" style="margin: auto 1% auto 1%">
<div class="pun"><div class="block"><h2 align="center"><span>RECORDATORIO DE PAGO</span></h2><div class="box"><div class="inbox">
<form action="ggestionc.asp?id=<%=credito%>" method="post" name="datos">
<table width="100%" border="0" cellspacing="0" cellpadding="0"><tr>
<!-- #include file ="../as/funciones.asp" -->
<%
campo "sel","id","desea","¿DESEA QUE LO CONTACTEN PARA RECORDARLE SU FECHA DE PAGO?",""
	opcion "id","desea",""
	opcion "id","desea","Si - Via Telefonica"
	opcion "id","desea","Si - Via Mensaje de Texto"
	opcion "id","desea","Si - Via Correo Electronico"
	opcion "id","desea","No - No Contactarme"
	cierre "sel","id","desea"

campo "tex","id","detalles","OBSERVACIONES ADICIONALES","detalles"

campo "btn","id","cont","",""%>
</table></form>
 <SCRIPT language=JavaScript type=text/javascript>
var frmvalidator  = new Validator("datos");
frmvalidator.addValidation("desea","req","Es necesaria esta informacion");
frmvalidator.addValidation("detalles","req","Es necesaria esta informacion");
</script>
<!-- #include file ="../desconexion.dll" -->
<SCRIPT language=JavaScript 
src="wz_tooltip.js" 
type=text/javascript></SCRIPT>
</div></div></div></div></div>