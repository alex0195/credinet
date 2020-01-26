<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<link rel="stylesheet" type="text/css" href="../style/Oxygen.css" />
<%nivel=3 'Nivel minimo de acceso%>
<!-- #include file ="../log.dll" -->
<body><SCRIPT language=JavaScript src="../form_validator.js" type=text/javascript></SCRIPT>
<div id="puninstall" style="margin: auto 1% auto 1%">
<div class="pun"><div class="block"><h2 align="center"><span>ADJUDICAR EQUIPOS</span></h2><div class="box"><div class="inbox">
<script>
function cambiar(objeto,metodo)
{
document.datos.action="?id="+objeto+"&metodo="+metodo+"&t1="+<%=request("t1")%>
document.datos.submit()
}
</script>
<form action="gadjudicar.asp" method="post" name="datos">
<table width="100%" border="0" cellspacing="0" cellpadding="0"><tr>
<!-- #include file ="../as/funciones.asp" -->
<%'campo "num","id","t1","t1 DE IDENTIDAD","Escriba su numero de t1"
if request("t1") <> "" then%>
<!-- #include file ="../conexion.dll" -->

<%
'Aqui solicitamos el codigo del cliente
set tabla=bdd.execute("select * from credito where Cliente='"&request("t1")&"'")
	if not tabla.eof then
%>
<input type="hidden" name="codigo" value="<%=tabla("Codigo")%>">
<%
campo "mue","t1","codigoaaaa","CODIGO",tabla("Codigo")
tabla.close
	else
		set codigo=bdd.execute("select id from xdat_cod_clie_saint where t1='"&request("t1")&"'")
			if codigo.eof then
		set codigo=bdd.execute("Insert into xdat_cod_clie_saint (t1) values ('"&request("t1")&"')")
		set codigo=bdd.execute("select id from xdat_cod_clie_saint where t1='"&request("t1")&"'")
			end if
%>
<input type="hidden" name="codigo" value="<%=codigo("id")%>">
<%
campo "mue","t1","codigoaaaa","CODIGO ASIGNADO POR SISTEMA",codigo("id")
'sql="Select * from vendedores order by nombre asc"
'set tabla=bdd.execute(sql)
'campo "sel","t1","vendedor","CODIGO DE VENDEDOR",""
'	opcion "t1","vendedor",""
'do while not tabla.eof
'	opcion1 "t1","vendedor",Ucase(tabla("nombre")),tabla("cod")
'tabla.movenext
'loop
'	cierre "sel","t1","vendedor"
'tabla.close
	end if
sql="Select distinct(marca) from inventario where estado is null"
set tabla=bdd.execute(sql)
campo "sel","t1","marca","MARCA DEL EQUIPO",""
	opcion "t1","marca",""
do while not tabla.eof
	opcion "t1","marca",tabla("marca")
tabla.movenext
loop
	cierre "sel","t1","marca"
tabla.close
sql="Select * from inventario where marca='"&request("marca")&"' and estado is null"
set tabla=bdd.execute(sql)
campo "sel","marca","modelo","MODELO - SERIAL",""
	opcion "marca","modelo",""
do while not tabla.eof
	opcion1 "marca","modelo",tabla("modelo")&" Serial: "&tabla("serial"),tabla("id")
tabla.movenext
loop
	cierre "sel","marca","modelo"
tabla.close
if request("modelo")<> "" then response.Redirect("gadjudicar.asp?t1="&request("t1")&"&equipo="&request("modelo")&"&codigo="&request("codigo"))%>
<!-- #include file ="../desconexion.dll" -->
<%end if%>
<SCRIPT language=JavaScript 
src="wz_tooltip.js" 
type=text/javascript></SCRIPT>
</div></div></div></div></div>