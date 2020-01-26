<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<link rel="stylesheet" type="text/css" href="../style/Oxygen.css" />
<body><SCRIPT language=JavaScript src="../form_validator.js" type=text/javascript></SCRIPT>
<script>
function cambiar(objeto,metodo)
{
document.datos.action="?id=<%=request("id")%>&metodo="+metodo
document.datos.submit()
}
</script>
<!-- #include file ="../conexion.dll" -->
</head>
<style type="text/css">
<!--
.Estilo1 {
	font-family: Arial, Helvetica, sans-serif;
	font-size: 10px;
}
-->
</style>
<body>
<div id="puninstall" style="margin: auto 5% auto 5%"><div class="pun"><div class="block">
  <h2 align="center">Reporte de Creditos por Facturar en Saint</h2>
  <div class="box">
<div class="inbox">
<table width="100%" border="0" cellspacing="0" cellpadding="0"><tr>
  <tr>
    <td width="20%">Nombre</td>
    <td width="20%">Equipo</td>
    <td width="20%">Fecha</td>
    <td width="20%">Analista</td>
    <td width="5%">Credito</td>
	<td width="15%">Facturar</td>		
  </tr>
<%
set tabla=bdd.execute("Select * from credito where factura_saint = 'no' and activo = 1")
	do while not tabla.eof
		set tabla2=bdd.execute("Select t2,t3 from dpersonales where t1 = '"&tabla("Cliente")&"' ")
			if not tabla2.eof then
				apellido=tabla2("t2")
				nombre=tabla2("t3")
				tabla2.close
			else
				nombre="Error"
				apellido="Error"
			end if

		set tabla2=bdd.execute("Select Marca, Modelo from inventario where Id = '"&tabla("Equipo")&"' ")
			if not tabla2.eof then
				Marca=tabla2("marca")
				Modelo=tabla2("modelo")
				tabla2.close
			else
				Marca="Error"
				Modelo="Error"
			end if

		set tabla2=bdd.execute("Select Nombre from acceso where Codigo = '"&tabla("analista")&"' ")
			if not tabla2.eof then
				Analista=tabla2("Nombre")
				tabla2.close
			else
				Analista="Error"
			end if


%>
  <tr>
    <td><%=nombre&" "&apellido%></td>

	<td><%=Marca&" "&Modelo%></td>

	<td><%=tabla("Fecha")%></td>

	<td><%=Analista%></td>
	
	<td><%=tabla("id")%></td>

	<td><a href="fsaint2.asp?id=<%=tabla("id")%>">SAINT</a></td>		
  </tr>
<%
tabla.movenext
loop
tabla.close
%>


</table>
		</div></div> </div></div></div></body></html>
<!-- #include file ="../desconexion.dll" -->