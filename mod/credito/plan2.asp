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
    <td width="19%">Código: <%=tabla("codigo")%></td>
  </tr>
  <tr>
    <td>Números de Contacto: <%=tabla("t11")%> / <%=tabla("t23")%> / <%=tabla("t24")%> / <%=tabla("t26")%></td>
    <td>Fecha: <%=date()%></td>
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
<p><center>CONTROL DE SU CUENTA</center></p>
<table width="100%" border="1" cellspacing="0" cellpadding="0" style="font-size:9px">
  <tr align="center">
    <td width="7%">Cuota</td>
    <td width="13%">Fecha de Vencimiento</td>
    <td width="20%">Monto Original</td>
    <td width="20%">Con un Descuento</td>
    <td width="20%">Con doble Descuento</td>
    <td width="10%">Fecha de Pago</td>
    <td width="10%">Recibo o Deposito</td>
  </tr>
<%
set pagos=bdd.execute("Select * from cobranza where credito= '"&request("id")&"' and cuota <> '0'")
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
    <td>Bs.<%=bsf(cuotas("monto")*0.90)%></td>
	<%cuota1=bsf(cuotas("monto")*0.90)
	cuota2=bsf((cuotas("monto")*0.90)*0.90)%>
    <td>Bs.<%=bsf((cuotas("monto")*0.90)*0.90)%></td>
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
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
<%next%>

</table>
<p><strong>NOTA SOBRE LOS DESCUENTOS:</strong><br>
CON UN DESCUENTO: SE APLICA SI PAGA A TIEMPO A NUESTRO COBRADOR O SI DEPOSITA AL BANCO O SI PAGA POR OFICINA DESPUES DE VENCIDA LA CUOTA, ASI UD. SE AHORRARA HASTA Bs. <b><%=bsf((pc-inicial)*0.1)%></b><br>
CON DOBLE DESCUENTO: SE APLICA SI PAGA A TIEMPO Y, ADEMAS, DEPOSITA AL BANCO O PAGA POR LA OFICINA ASI, UD. SE AHORRARA HASTA Bs. <b><%=bsf((pc-inicial)*0.19)%></b></p>
<table width="100%" border="1" cellspacing="0" cellpadding="0">
  <tr>
    <td width="50%"><strong>Inversiones Jotaene, c.a</strong><br>
    Estimado Cliente: Le ofrecemos el beneficio de obtener descuento en su cuota de acuerdo a la forma de pago:<br>
<b>    Beneficio Especial:</b><br>
<li>    Obtendrá un 10% pagando a nuestro cobrador, en la fecha de vencimiento, o antes. Así ud. sólo pagara Bs .<%=bsf(cuota1)%> <br>
<li>    Si se vence su cuota, pero paga por nuestras oficinas o mediante depósito bancario, pague sólo Bs. <%=bsf(cuota1)%><br>
<b>   Beneficio Doble:</b><br>
<li>    Si, además de pagar a la fecha, lo hace por depósito bancario o por oficina, obtendrá  un 10% adicional, así solo pagará Bs. <b><%=bsf(cuota2)%></b><br></td>
    <td width="1%">&nbsp;</td>
    <td width="49%"><p>Para realizar su pago por oficina, diríjase a:<br>
        <strong>INVERSIONES JOTAENE, C.A</strong> en la Av. Bolívar Norte Torre Camoruco Piso 15, Oficina 05, Valencia, Telfs: 0241-6196090 04144346997 04166405823 04123430055<br>
      Para realizar su pago por deposito bancario utilice las siguientes cuentas corrientes a nombre de
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
</table>
<%end if%>
<!-- #include file ="../desconexion.dll" -->