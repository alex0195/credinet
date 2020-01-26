<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<link rel="stylesheet" type="text/css" href="../style/Oxygen.css" />
<%
nivel=3 'Nivel minimo de acceso
%>
<!-- #include file ="../log.dll" -->
	<!-- #include file ="../conexion.dll" -->
	
	<%
set factura=bdd.execute("Select * from credito where facturado = 0 and analista = "&session("codigo"))
		do while not factura.eof
			%>
			<script>
alert('El credito <%=factura("Id")%>, al parecer no se ha facturado en Saint, favor verifique')
			</script>
			<%
		factura.movenext
		loop
		factura.close
	%>
	
<body><SCRIPT language=JavaScript src="form_validator.js" type=text/javascript></SCRIPT>
<div id="puninstall" style="margin: auto 1% auto 1%">
<div class="pun"><div class="block"><h2 align="center"><span>INGRESE LA CEDULA A ADJUDICAR</span></h2><div class="box"><div class="inbox">
<script>
function cambiar(objeto,metodo)
{
document.datos.action="?id="+objeto+"&metodo="+metodo
document.datos.submit()
}
</script>
<%if request("t1")<> ""  then%>
	<%csql="Select * from dsolicitud where t1='"&request("t1")&"'"
	set tabla = bdd.execute(csql)
	if not tabla.eof then 
		select case tabla("estado")
		case "7","11"
		response.Redirect("adjudicar.asp?t1="&tabla("t1"))
		case "2","3","4"
		%>
		<script>
alert('Credito RECHAZADO');
window.location='../adjudica_rapido.asp?id=nuevo'; 
</script>
		<%
		case "5"
		%>
		<script>
if (confirm("Estimado <%=session("nombre")%>, va a adjudicar un producto a un cliente que posee un credito \n \n ¿Esta seguro con realizar esta transaccion?"))
window.location='../excusa.asp?tipo=2&t1=<%=request("t1")%>'
else
alert('Operacion cancelada')
</script>
		<%
		case "0"
		%>
		<script>
		alert('Esta solicitud esta aun en analisis')
		</script>
		<%

		end select
	else
	%>
		<script>
		alert('No se encontro la solicitud')
		</script>
		<%
	end if
end if%>
<form action="?id=evaluar" method="post" name="datos">
<table width="100%" border="0" cellspacing="0" cellpadding="0"><tr>
<!-- #include file ="../as/funciones.asp" -->
<%
campo "num","id","t1","INGRESE CEDULA DE IDENTIDAD","Escriba su numero de Cedula"
'campo "btn","t1","cont","",""%>
</table></form>
<%if request("t1")<> "" then%>
 <SCRIPT language=JavaScript type=text/javascript>
var frmvalidator  = new Validator("datos");
frmvalidator.addValidation("t1","req","Es necesaria esta informacion");
</script>
<%end if%>
<!-- #include file ="../desconexion.dll" -->
<SCRIPT language=JavaScript 
src="wz_tooltip.js" 
type=text/javascript></SCRIPT>
</div></div></div></div></div>