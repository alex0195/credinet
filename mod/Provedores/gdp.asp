<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<!-- #include file ="../conexion.dll" -->
<%csql="Select * from provedores where rif='"&request("rif")&"'"
set tabla = bdd.execute(csql)
if not tabla.eof then 
response.Redirect("index.asp") 
tabla.close
end if
sql="insert into provedores(rif,nombre,direccion,telefono,incentivo,telefonia) values ('"&UCase(request("rif"))&"','"&UCase(request("nombre"))&"','"&UCase(request("direccion"))&"','"&UCase(request("telefono"))&"','"&UCase(request("incentivo"))&"','"&UCase(request("Operadora"))&"')"
set tabla = bdd.execute(sql)
response.Redirect("index.asp") 
%>
<!-- #include file ="../desconexion.dll" -->