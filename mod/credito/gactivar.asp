<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<!-- #include file ="../log.dll" -->
<!-- #include file ="../conexion.dll" -->
<%finicial=date()
dia=Day(finicial)
mes=Month(finicial)
ano=Year(finicial)
hora=time()
finicial=ano&"-"&mes&"-"&dia
monto=replace(request("monto"),".",",")
monto=bsf(monto)
sql="Insert into temp_ingresos (hora,cobrador,tipo,banco,numero,clave,monto,cuota,credito,observacion,recibo,estado,fecha) Values ('"&hora&"','"&session("codigo")&"','"&request("tipo")&"','"&request("banco")&"','"&request("numero")&"','"&request("clave")&"','"&monto&"','0','"&request("id")&"','"&request("observacion")&"','"&request("recibo")&"','0','"&finicial&"')"

set tabla = bdd.execute(sql)

sql="UPDATE temp_cobranza set pagado = '"&monto&"' where credito='"&request("id")&"' and cuota='0'"
set tabla = bdd.execute(sql)

sql="Select * from temp_cobranza where credito='"&request("id")&"' and cuota='0'"
set tabla = bdd.execute(sql)
debe=bsf(tabla("monto")*1)
pago=bsf(tabla("pagado")*1)
if pago < debe then
falta=debe-pago
set finicial_x = bdd.execute("Insert into xdat_inicial_faltantes(credito,inicial) values ("&request("id")&",'"&Cint(falta)&"')")
%>
<script>
alert('El pago realizado no es suficiente para cancelar la inicial')
alert('El resto debe ser pagado antes de la primera cuota')
window.location='gestionc.asp?id=<%=request("id")%>'
</script>
<%elseif pago=debe then
sql2="UPDATE temp_cobranza set estado = '1' where credito='"&request("id")&"' and cuota='0'"
set tabla2 = bdd.execute(sql2)%>
<script>
alert('Inicial cancelada satisfactoriamente')
window.location='gestionc.asp?id=<%=request("id")%>'
</script>
<%elseif pago>debe then
	sql2="UPDATE temp_cobranza set estado = '1' where credito='"&request("id")&"' and cuota='0'"
set tabla2 = bdd.execute(sql2)%>
<script>
alert('El monto cancelado es mayor a la inicial')
alert('Se le ha descontado el sobrante a la primera cuota')
window.location='gestionc.asp?id=<%=request("id")%>'
</script>
<%end if
tabla.close%>
<body><SCRIPT language=JavaScript src="form_validator.js" type=text/javascript></SCRIPT>
<!-- #include file ="../desconexion.dll" -->