<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<!-- #include file ="../log.dll" -->
<!-- #include file ="../conexion.dll" -->
<%finicial=date()
dia=Day(finicial)
mes=Month(finicial)
ano=Year(finicial)
hora=time()
finicial=ano&"-"&mes&"-"&dia
monto=request("monto")
set tabla=bdd.execute("Insert into gastos_admin (hora,cobrador,tipo,banco,numero,clave,monto,cuota,cedula,observacion,recibo,estado,fecha) Values ('"&hora&"','"&session("codigo")&"','"&request("tipo")&"','"&request("banco")&"','"&request("numero")&"','"&request("clave")&"','"&monto&"','0','"&request("cedula")&"','"&request("observacion")&"','"&request("recibo")&"','0','"&finicial&"')")
%>
<script>
alert('Registro exitoso');
location.href='admin2.asp?id=1';
</script>
<body><SCRIPT language=JavaScript src="form_validator.js" type=text/javascript></SCRIPT>
<!-- #include file ="../desconexion.dll" -->