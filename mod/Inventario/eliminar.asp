<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<!-- #include file ="../conexion.dll" -->
<%
bdd.execute("delete from inventario where Id = "&request("id"))
response.Redirect("index.asp")
%>
<!-- #include file ="../desconexion.dll" -->