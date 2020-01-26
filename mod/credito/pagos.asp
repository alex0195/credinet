<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<!-- #include file ="../log.dll" -->
<!-- #include file ="../conexion.dll" -->
<link rel="stylesheet" type="text/css" href="../style/Oxygen.css" />
<%sql="Select * from "
sql=sql + "((credito INNER JOIN dpersonales ON (dpersonales.t1=credito.cliente)) "
sql=sql + "INNER JOIN inventario ON (inventario.id=credito.equipo)) "
sql=sql + "INNER JOIN dreferencia ON (dpersonales.t1=dreferencia.t1)"
sql=sql + "where credito.id='"&request("id")&"'"
set tabla = bdd.execute(sql)
if tabla.eof then response.Write("Se ha generado un error grave en sistema favor notifique al administrador")%>

<body><SCRIPT language=JavaScript src="form_validator.js" type=text/javascript></SCRIPT>
<div id="puninstall" style="margin: auto 1% auto 1%">
<div class="pun"><div class="block"><h2 align="center"><span>CRONOGRAMA DE PAGOS DE CREDITO</span></h2><div class="box"><div class="inbox">
<script>
function cambiar(objeto,metodo)
{
document.datos.action="?id=<%=request("id")%>&metodo="+metodo
document.datos.submit()
}
</script>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
<%if request("c1")<> "" then%>
<form method="post" action="gpagos.asp?id=<%=request("id")%>" name="datos">
<%else%>
<form method="post" action="#" name="datos">
<%end if%>

<!-- #include file ="../as/funciones.asp" -->
<%
campo "mue","id","te","DATOS",tabla("t2")&" "&tabla("t3")&" "&tabla("marca")&" "&tabla("modelo")&" "&tabla("serial")
campo "mue","id","tc","COSTO DEL EQUIPO",bsf(tabla("costo"))
campo "mue","id","tad","INICIAL MIN PROPUESTA",bsf(tabla("costo")*0.475)
campo "tex","id","ti","INICIAL A PAGAR BS.",bsf(tabla("costo")*0.475)

if request("ti") <> "" then
	if Cint(request("ti")) < Cint(tabla("costo")*0.475) then
	%>
	<script>
	alert('No se puede recibir menos inicial de la sugerida por el sistema');
	window.history.go(-1);
	</script>
	<%
'	end if

end if

campo "sel","ti","tf","FRECUENCIA DE PAGO",""
	opcion "ti","tf",""

	opcion "ti","tf","MENSUAL"
	opcion "ti","tf","QUINCENAL"
	opcion "ti","tf","SEMANAL"
	cierre "sel","ti","tf"

campo "sel","tf","tp","ESCOJA DE 1 A 7 MESES",""
	opcion "tf","tp",""
		for i = 1 to 7
	opcion "tf","tp",i
		next
	cierre "sel","tf","tp"
if request("tp")<> "" then

inicial=replace(request("ti"),".",",")
inicial=bsf(inicial)
mf=(bsf(tabla("costo"))-inicial)*1.9
pc=inicial+mf
c1=mf
c2=0.688105217516983*mf
c3=0.470299020599692*mf
c4=0.362950964496071*mf
c5=0.299844312825308*mf
c6=0.258913484423088*mf
c7=0.23070725785392*mf
c2=round(c2/1)*1
c3=round(c3/1)*1
c4=round(c4/1)*1
c5=round(c5/1)*1
c6=round(c6/1)*1
c7=round(c7/1)*1
c2=c2+1
c3=c3+1
c4=c4+1
c5=c5+1
c6=c6+1
c7=c7+1
Select case request("tp")
	case 1
	valor=c1
	case 2
	valor=c2
	case 3
	valor=c3
	case 4
	valor=c4
	case 5
	valor=c5
	case 6
	valor=c6
	case 7
	valor=c7
end select
select case request("tf")
	case "MENSUAL"
		valor=valor
		cantidad=request("tp")
		frecuencia="MENSUALES"
	case "QUINCENAL"
		valor=valor/2
		cantidad=request("tp")*2
		frecuencia="QUINCENALES"
	case "SEMANAL"
		valor=valor/4
		cantidad=request("tp")*4
		frecuencia="SEMANALES"
end select
campo "mue","tp","mdc","MONTO DE LA CUOTA BS.",FormatNumber(valor)
campo "mue","tp","de","DESCUENTO * BS.",FormatNumber(valor*0.1)%>

<input type="hidden" name="mcuota" value="<%=valor%>">
<%
'campo "mue","tp","2de","DESCUENTO ** BS.",FormatNumber((valor-(valor*0.1))*0.1)
campo "mue","tp","mnp",cantidad&" CUOTAS "&frecuencia&" DE BS.","<b>"&FormatNumber((valor*0.9))&"</b>"

select case request("tf")
	case "MENSUAL"
		cantidad=request("tp")
fecha=date+30
fec "tp","c1","CUOTA 1",fecha,"La fecha predeterminada para cancelar la cuota 1 es el "&Fecha
%>
<script type="text/javascript">
    Calendar.setup({
        inputField     :    "c1",      // id del campo de texto
        ifFormat       :    "%d/%m/%Y",       // formato de la fecha, cuando se escriba en el campo de texto
        button         :    "c1"   // el id del botón que lanzará el calendario
    });
</script>
<%
if request("c1") <> "" then 
fecha=cdate(request("c1"))+30
for i = 2 to cantidad
fec "c1","c"&i,"CUOTA "&i,fecha,"La fecha predeterminada para cancelar la cuota "&i&" es el "&Fecha
%>
<script type="text/javascript">
    Calendar.setup({
        inputField     :    "<%="c"&i%>",      // id del campo de texto
        ifFormat       :    "%d/%m/%Y",       // formato de la fecha, cuando se escriba en el campo de texto
        button         :    "<%="c"&i%>"   // el id del botón que lanzará el calendario
    });
</script>
<%
fecha=cdate(fecha)+30
next
end if
	case "QUINCENAL"
		cantidad=request("tp")*2
fecha=date+15
fec "tp","c1","CUOTA 1",fecha,"La fecha predeterminada para cancelar la cuota 1 es el "&Fecha
%>
<script type="text/javascript">
    Calendar.setup({
        inputField     :    "<%="c1"%>",      // id del campo de texto
        ifFormat       :    "%d/%m/%Y",       // formato de la fecha, cuando se escriba en el campo de texto
        button         :    "<%="c1"%>"   // el id del botón que lanzará el calendario
    });
</script>
<%
if request("c1") <> "" then 
fecha=cdate(request("c1"))+15
for i = 2 to cantidad
fec "c1","c"&i,"CUOTA "&i,fecha,"La fecha predeterminada para cancelar la cuota "&i&" es el "&Fecha
%>
<script type="text/javascript">
    Calendar.setup({
        inputField     :    "<%="c"&i%>",      // id del campo de texto
        ifFormat       :    "%d/%m/%Y",       // formato de la fecha, cuando se escriba en el campo de texto
        button         :    "<%="c"&i%>"   // el id del botón que lanzará el calendario
    });
</script>
<%
fecha=cdate(fecha)+15
next
end if
	case "SEMANAL"
		cantidad=request("tp")*4
fecha=date+7
fec "tp","c1","CUOTA 1",fecha,"La fecha predeterminada para cancelar la cuota 1 es el "&Fecha
%>
<script type="text/javascript">
    Calendar.setup({
        inputField     :    "<%="c1"%>",      // id del campo de texto
        ifFormat       :    "%d/%m/%Y",       // formato de la fecha, cuando se escriba en el campo de texto
        button         :    "<%="c1"%>"   // el id del botón que lanzará el calendario
    });
</script>
<%
if request("c1") <> "" then 
fecha=cdate(request("c1"))+7
for i = 2 to cantidad
fec "c1","c"&i,"CUOTA "&i,fecha,"La fecha predeterminada para cancelar la cuota "&i&" es el "&Fecha
%>
<script type="text/javascript">
    Calendar.setup({
        inputField     :    "<%="c"&i%>",      // id del campo de texto
        ifFormat       :    "%d/%m/%Y",       // formato de la fecha, cuando se escriba en el campo de texto
        button         :    "<%="c"&i%>"   // el id del botón que lanzará el calendario
    });
</script>
<%
fecha=cdate(fecha)+7
next
end if
end select
'campo "mue","tp","link","¿TE GUSTA ESTE PLAN?","<b><a href=dp.asp>CONTINUAR</a></b>"
campo "btn","c1","cont","",""
end if
%>
</table></form>
<SCRIPT language=JavaScript 
src="../wz_tooltip.js" 
type=text/javascript></SCRIPT>
</div></div></div></div></div>
<!-- #include file ="../desconexion.dll" -->