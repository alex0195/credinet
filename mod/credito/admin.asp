<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<%nivel=3 'Nivel minimo de acceso%>
<!-- #include file ="../log.dll" -->
<!-- #include file ="../conexion.dll" -->
<link rel="stylesheet" type="text/css" href="../style/Oxygen.css" />

<body><SCRIPT language=JavaScript src="form_validator.js" type=text/javascript></SCRIPT>
<div id="puninstall" style="margin: auto 1% auto 1%">
<div class="pun"><div class="block"><h2 align="center"><span>DATOS DE CANCELACION DE INICIAL DE CREDITO</span></h2><div class="box"><div class="inbox">
<form action="gadmin.asp" method="post" name="datos">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<!-- #include file ="../as/funciones.asp" -->
<%
campo "num","id","cedula","CEDULA DEL CLIENTE","C.I. DEL CLIENTE "
campo "tex","id","monto","MONTO QUE ESTA CANCELANDO BS.","0"
campo "sel","id","tipo","TIPO DE PAGO",""
	opcion "id","tipo",""
	opcion "id","tipo","EFECTIVO"
	opcion "id","tipo","DEPOSITO"
	opcion "id","tipo","TRANSFERENCIA"	
	opcion "id","tipo","CHEQUE"	
	opcion "id","tipo","DEBITO"
	opcion "id","tipo","CREDITO"	
	opcion "id","tipo","OTRO"		
	cierre "sel","id","tipo"
if request("tipo")<> "" then
select case request("tipo")
case "CHEQUE","T.DEBITO","T.CREDITO","DEPOSITO"
campo "tex","tipo","banco","BANCO","BANCO AL CUAL PERTENECE"
campo "tex","tipo","numero","NUMERO","NUMERO DE DOCUMENTO BANCARIO"
campo "tex","tipo","clave","CLAVE","CLAVE DE CONFORMACION"
end select
end if
campo "tex","tipo","recibo","RECIBO","NUMERO DE RECIBO"
campo "tex","tipo","observacion","OBSERVACIONES","COLOQUE LAS OBSERVACIONES SOBRE ESTE PAGO"
campo "btn","tipo","cont","",""
%>

</table></form>
 <SCRIPT language=JavaScript type=text/javascript>
var frmvalidator  = new Validator("datos");
frmvalidator.addValidation("cedula","req","Es necesaria esta informacion");
frmvalidator.addValidation("monto","req","Es necesaria esta informacion");
frmvalidator.addValidation("tipo","req","Es necesaria esta informacion");
frmvalidator.addValidation("recibo","req","Es necesaria esta informacion");
</script>
<SCRIPT language=JavaScript 
src="../wz_tooltip.js" 
type=text/javascript></SCRIPT>
</div></div></div></div></div>
<!-- #include file ="../desconexion.dll" -->