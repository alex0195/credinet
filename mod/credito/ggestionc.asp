<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<!-- #include file ="../log.dll" -->
<!-- #include file ="../conexion.dll" -->
<%
credito=request("id")
desea=request("desea")
observaciones=request("detalles")
sql="Insert into temp_gestion_cobranza (credito,desea,observaciones) Values ("&credito&",'"&desea&"','"&observaciones&"')"
set tabla = bdd.execute(sql)
response.Redirect("../cliente/subida2.asp?id="&credito)

%>
<script>
//window.location='plan.asp?id=<=credito%>'
</script>
<!-- #include file ="../desconexion.dll" -->