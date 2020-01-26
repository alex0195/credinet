<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<%nivel=3 'Nivel minimo de acceso%>
<!-- #include file ="../log.dll" -->
<!-- #include file ="../conexion.dll" -->
<link rel="stylesheet" type="text/css" href="../style/Oxygen.css" />
<body><SCRIPT language=JavaScript src="form_validator.js" type=text/javascript></SCRIPT>
<div id="puninstall" style="margin: auto 1% auto 1%">
<div class="pun"><div class="block"><h2 align="center"><span>CONTROL DE PAGOS POR RESTO DE INICIAL</span></h2><div class="box"><div class="inbox">
<script>
function cambiar(objeto,metodo)
{
document.datos.action="?id=<%=request("id")%>&metodo="+metodo
document.datos.submit()
}
</script>
<table width="100%" border="0" cellspacing="0" cellpadding="0"><tr>

<form method="post" action="gres_ini.asp?id=<%=request("id")%>" name="datos">
<!-- #include file ="../as/funciones.asp" -->
<%
campo "num","id","credito","NUMERO DE CREDITO","CREDITO AL QUE CORRESPONDE LA INICIAL "
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
<SCRIPT language=JavaScript 
src="../wz_tooltip.js" 
type=text/javascript></SCRIPT>
</div></div></div></div></div>
<!-- #include file ="../desconexion.dll" -->