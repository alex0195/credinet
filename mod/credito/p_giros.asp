<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<%
Set bdd2 = Server.CreateObject ("ADODB.Connection")
Set tabla2 = Server.CreateObject ("ADODB.RecordSet")
tabla2.cursorLocation=3
tabla2.cursortype=3
bdd2.Open "DRIVER={MySQL ODBC 3.51 Driver}; Server=localhost; Database=credinet; UID=root; PWD=6151326"

Set bdd = Server.CreateObject ("ADODB.Connection")
Set tabla = Server.CreateObject ("ADODB.RecordSet")
tabla.cursorLocation=1
tabla2.cursortype=1
bdd.Open "DRIVER={SQL Native Client};Server=CREDINET\CREDINET; Database=creditel; UID=alexander; PWD=6151326"

	set tabla_sf=bdd2.execute("Select * from credito where Id = "&request("credito"))
		do while not tabla_sf.eof
credito=tabla_sf("Id")
codigo=tabla_sf("Codigo")
cedula=tabla_sf("Cliente")
response.Write(credito&"<br>")
'sqlsaint="Select * from Saacxc where tipocxc = '10' and document = '"&credito&"'"
'set tabla = bdd.execute(sqlsaint)

'	if not tabla.bof then
'		response.Write(tabla("NroUnico")&"<br>")	

			set tabla2 = bdd2.execute("select * from credito2 where credito = "&credito)
			select case tabla2("Tipo")
			case "MENSUAL"
			cantidad=tabla2("Plazo")
			case "QUINCENAL"
			cantidad=tabla2("Plazo")*2
			case "SEMANAL"
			cantidad=tabla2("Plazo")*4
			end select
			tabla2.close
			response.Write(cantidad)

fechaa=now()
fecha=date()&" "&Hour(fechaa)&":"&Minute(fechaa)&":"&Second(fechaa)
'monto=replace(tabla("monto"),",",".")
'mtotax=replace(tabla("mtotax"),",",".")
'baseimpo=replace(tabla("baseimpo"),",",".")
'set tabla_nc=bdd.execute("Insert into saacxc (CodClie,FechaE,FechaI,FechaV,Codsucu,CodEsta,CodUsua,CodVend,NumeroD,NumeroN,TipoCxC,Factor,Document,Monto,MtoTax,BaseImpo,CancelG,FechaT) values ('"&tabla("codclie")&"','"&fecha&"','"&fecha&"','"&fecha&"','0000','CREDINET','001','"&tabla("CodVend")&"','"&tabla("numerod")&"','"&tabla("numerod")&"','41','1','CANC. FAC. X GIROS',"&monto&","&MtoTax&","&BaseImpo&","&monto&",'"&fecha&"')")

cuota=1 
'set tabla_nc = bdd.execute("update saacxc set saldo = 0, saldoorg = 0 where NroUnico = "&tabla("NroUnico"))

	set tabla2 = bdd2.execute("select * from cobranza where credito = "&credito&" and cuota > 0 order by fecha asc")
		do while not tabla2.eof

fechav=tabla2("fecha")&" 08:00:00"
document=cuota&" de "&cantidad
monto=replace(tabla2("monto"),",",".")
set tabla_nc =bdd.execute("Insert into saacxc (CodClie,FechaE,FechaI,FechaV,Codsucu,CodEsta,CodUsua,CodVend,NumeroD,NumeroN,TipoCxC,Factor,Document,Monto,Saldo,SaldoOrg,FechaT) values ('"&codigo&"','"&fecha&"','"&fecha&"','"&fechav&"','0000','CREDINET','001','00','"&document&"','"&document&"','60','1','"&credito&"',"&monto&","&monto&","&monto&",'"&fecha&"')")
response.Write("<br>Procesada la cuota "&cuota)
cuota=cuota+1
		tabla2.movenext
		loop
		tabla2.close
set actualiza_credinet=bdd2.execute("update credito set facturado = 1 where Id="&credito)
response.redirect("plan.asp?id="&credito)
'else
'response.write(sqlsaint&"<br>")
'	end if
'tabla.close
		tabla_sf.movenext
		loop
		tabla_sf.close
%>