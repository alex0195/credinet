<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<%nivel=3 'Nivel minimo de acceso%>
<!-- #include file ="../log.dll" -->
<!-- #include file ="../conexion.dll" -->
<link rel="stylesheet" type="text/css" href="../style/Oxygen.css" />
<%sql="Select * from "
sql=sql + "(((credito INNER JOIN dpersonales ON (dpersonales.t1=credito.cliente)) "
sql=sql + "INNER JOIN inventario ON (inventario.id=credito.equipo)) "
sql=sql + "INNER JOIN temp_cobranza ON (temp_cobranza.credito=credito.id)) "
sql=sql + "INNER JOIN dreferencia ON (dpersonales.t1=dreferencia.t1)"
sql=sql + "where credito.id='"&request("id")&"' and temp_cobranza.cuota='0'"
set tabla = bdd.execute(sql)
if tabla.eof then response.Write("Se ha generado un error grave en sistema favor notifique al administrador")%>
<body><SCRIPT language=JavaScript src="form_validator.js" type=text/javascript></SCRIPT>
<div id="puninstall" style="margin: auto 1% auto 1%">
<div class="pun"><div class="block"><h2 align="center"><span>DATOS DE CANCELACION DE INICIAL DE CREDITO</span></h2><div class="box"><div class="inbox">
<script>
function cambiar(objeto,metodo)
{
document.datos.action="?id=<%=request("id")%>&metodo="+metodo
document.datos.submit()
}
</script>
<table width="100%" border="0" cellspacing="0" cellpadding="0"><tr>

<form method="post" action="gactivar.asp?id=<%=request("id")%>" name="datos">
<!-- #include file ="../as/funciones.asp" -->
<%
campo "mue","id","ati","INICIAL A PAGAR BS.",bsf(tabla("monto"))
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