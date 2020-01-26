<style type="text/css">
<!--
.Estilo1 {font-weight: bold}
-->
</style>
<body topmargin="0" leftmargin="0">
<!-- #include file ="../log.dll" -->
<!-- #include file ="../conexion.dll" -->

<%sql="Select * from "
sql=sql + "(((((credito INNER JOIN dpersonales ON (dpersonales.t1=credito.cliente)) "
sql=sql + "INNER JOIN dlaborales ON (dlaborales.t1=dpersonales.t1)) "
sql=sql + "INNER JOIN inventario ON (inventario.id=credito.equipo)) "
sql=sql + "INNER JOIN cobranza ON (cobranza.credito=credito.id)) "
sql=sql + "INNER JOIN credito2 ON (credito2.credito=credito.id)) "
sql=sql + "INNER JOIN dreferencia ON (dpersonales.t1=dreferencia.t1)"
sql=sql + "where credito.id='"&request("id")&"' and cobranza.cuota='0'"
set tabla = bdd.execute(sql)
if tabla.eof then
response.Write("Se ha generado un error grave en sistema favor notifique al administrador, la venta no esta concluida")
else
%>
<style type="text/css">
<!--
body,td,th {
	font-family: Arial, Helvetica, sans-serif;
	font-size: 10px;
}
.Estilo1 {
	font-size: 18px;
	color: #FFFFFF;
}
-->
</style>

<table width="100%" border="1" cellpadding="1" cellspacing="0" bgcolor="#999999">
  <tr>
    <td><div align="center" class="Estilo1">INVERSIONES JOTAENE, C.A </div></td>
  </tr>
</table>
<table width="100%" border="1" cellspacing="0" cellpadding="0">
  <tr>
    <td width="81%">Cliente:<b> <%=tabla("t2")%> - <%=tabla("t3")%> </b>/ <%=tabla("t14")%> / NIC: <%=tabla("nic")%></td>
    <td width="19%">Código: <%=tabla("codigo")%> / Cr&eacute;dito: <%=request("id")%> / C&eacute;dula: <%=tabla ("t1")%></td>
  </tr>
  <tr>
    <td>Números de Contacto:  <%=tabla("t13")%> / <%=tabla("t11")%> / <%=tabla("t23")%> / <%=tabla("t24")%> / <%=tabla("t26")%></td>
    <td>Fecha: <%=tabla("fecha")%></td>
  </tr>
  <tr>
    <td>Detalles del Equipo: <%=tabla("marca")%> - <%=tabla("modelo")%> - <%=tabla("serial")%> / Factura: <%=tabla("factura")%> / Proveedor: 
	
	<%set tablaprovedor=bdd.execute("Select * from provedores where id ="&tabla("Provedor"))
	if not tabla.eof then
	response.Write(tablaprovedor("nombre"))
	end if
	tablaprovedor.close%>
	
	</td>
	<%
	
	set pagos=bdd.execute("Select * from cobranza where credito= '"&request("id")&"' and cuota <> '0'")
	if not pagos.eof then
	m_cuota=pagos("monto")
	else
	m_cuota=0
	end if
	pagos.close
	
	set pagos=bdd.execute("Select * from credito2 where credito= '"&request("id")&"'")
	m_tipo=pagos("Tipo")
	m_plazo=pagos("Plazo")
	pagos.close
	
	select case m_tipo
	case "MENSUAL"
	pc=(m_cuota*m_plazo)
	case "QUINCENAL"
	pc=(m_cuota*m_plazo)*2
	case "SEMANAL"
	pc=(m_cuota*m_plazo)*4
	end select
	pc=pc+tabla("monto")
	'pc=((tabla("costo")-tabla("monto"))*1.8)+tabla("monto")
	inicial=tabla("monto")
	%>
    <td>Precio Equipo: <%=bsf(pc)%></td>
  </tr>
  <tr>
    <td>Forma de Pago: <%=tabla("tipo")%> / Meses de Pago: <%=tabla("plazo")%></td>
    <td>Inicial: <%response.Write(bsf(tabla("monto")))
	%></td>
  </tr>
</table>
<p><h5><center>CONTROL DE SU CUENTA</center></h5></p>
<table width="100%" border="1" cellspacing="0" cellpadding="2" style="font-size:9px">
  <tr align="center">
    <td width="5%" >Cuota</td>
    <td width="10%">Fecha de Vencimiento</td>
    <td width="10%">Monto Original</td>
    <td width="13%">Fecha de Pago</td>
    <td width="57%">Recibo o Deposito</td>
  </tr>
<%
set pagos=bdd.execute("Select * from cobranza where credito= '"&request("id")&"' and cuota <> '0' order by fecha asc")
cu=1
do while not pagos.eof
set cuotas = bdd.execute("Select * from cobranza where cuota='"&pagos("cuota")&"' and credito = '"&pagos("credito")&"'")
if cuotas.eof then
response.Write("Se ha generado un error la venta no esta concluida, favor notifique al departamento de sistemas")
cuotas.close
else

pago=pagos("fecha")
		
%>
  <tr align="center">
    <td><%=pagos("cuota")%></td>
    <td><%=pago%></td>
    <td>Bs.<%=bsf(cuotas("monto"))%></td>
	<%cuota1=bsf(cuotas("monto")*0.90)%>
    <td>&nbsp;</td>
	<td>&nbsp;</td>
  </tr>
 <%
cu=cu+1
cuotas.close
end if
pagos.movenext
loop 
pagos.close 
'cu=cu-1
for i=cu to 28
 %>

  <tr align="center">
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>

  </tr>
<%next%>

</table>

<table width="100%" border="1" cellspacing="0" cellpadding="0">
  <tr>
    <td width="50%" valign="top" align="center"><p><strong>NOTA SOBRE EL DESCUENTO:</strong></p>
    EL DESCUENTO POR PRONTO PAGO SE APLICA: UN DIEZ PORCIENTO (10%) EN LA CUOTA A CANCELAR Y UN DIEZ PORCIENTO (10%) EN LA ÚLTIMA CUOTA, SIENDO ÉSTE ÚLTIMO ACUMULABLE. DICHO DESCUENTO SE DA SI PAGA EN LA FECHA ACORDADA O ANTERIOR A LA MISMA, ASÍ UD. SE AHORRARÁ HASTA Bs. <b><%=bsf((pc-inicial)*0.2)%> DEL TOTAL DEL CRÉDITO OTORGADO</b><br>
 <br>
</td>
    <td width="1%" rowspan="2">&nbsp;</td>
    <td width="49%" rowspan="2"><p>Para realizar su pago por oficina, diríjase a:<br>
        <strong>INVERSIONES JOTAENE, C.A</strong> en la Av. Bolívar Norte, Torre Camoruco Piso 15, Oficina 05, Valencia. Telfs: (0241) 6196090 - (0414) 4346997 - (0416) 6405823 - (0412) 3430055<br>
      Para realizar su pago por depósito bancario utilice las siguientes cuentas corrientes a nombre de:
      <br> <strong>Inversiones Jotaene, c.a</strong><br>
        <strong><li>Banco BOD 0116-0039-59-0005261414</strong><br>
        <strong><li>Banco Mercantil 0105-0097-46-1097175286</strong><br>
        <strong><li>Banco Banesco 0134-0067-97-0671020081</strong><br>
        <strong><li>Banco Provincial 0108-0222-96-0100043464</strong><br>
        <strong><li>Banco Corp Banca 0121-0223-21-0102501122 </strong><br>
        <strong><li>Banco BFC 0151-0078-88-4478009956</strong><br>
        <strong><li>Banco Banorte 0147-0035-85-1000059527 </strong><br>
</td>
  </tr>
  <tr>
    <td valign="top">
	
	  <div align="center">
	    <p>&nbsp;</p>
	    <p><strong>INFORMACI&Oacute;N DE RECORDATORIO DE PAGOS </strong></p>

<%
set ctabla=bdd.execute("Select * from gestion_cobranza where credito = "&request("id"))
if not ctabla.eof then
%>
	    <p><%=ctabla("desea")%></p>
	    <p><%=ctabla("observaciones")%></p>
<%
else
%>
	    <p>Informaci&oacute;n no disponible</p>
<%
end if
ctabla.close
%>
	  </div></td>
  </tr>
</table>
<%end if%>
<!-- #include file ="../desconexion.dll" -->