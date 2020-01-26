<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<!-- #include file ="../log.dll" -->
<!-- #include file ="../conexion.dll" -->
<%
id=request("id")

'Consultamos la tabla de credito temporal para saber que el credito existe
set credito=bdd.execute("Select * from temp_credito where id = "&id)
if not credito.eof then 'si el credito existe

	'Consultamos la tabla temp_cobranza para pasar los datos a la tabla real cobranza
	set temp_cobranza=bdd.execute("Select * from temp_cobranza where credito = '"&id&"' ")
		do while not temp_cobranza.eof
			
			set cobranza=bdd.execute("Select * from cobranza where credito = '"&id&"' and cuota = '"&temp_cobranza("cuota")&"'")
				
dia=Day(temp_cobranza("fecha"))
mes=Month(temp_cobranza("fecha"))
ano=Year(temp_cobranza("fecha"))
finicial=ano&"-"&mes&"-"&dia
								
					set cobranza1=bdd.execute("Insert into cobranza (cuota,credito,monto,estado,pagado,fecha) values ('"&temp_cobranza("cuota")&"','"&temp_cobranza("credito")&"','"&temp_cobranza("monto")&"','"&temp_cobranza("estado")&"','"&temp_cobranza("pagado")&"','"&finicial&"')")

					set elim_tempcobranza=bdd.execute("delete from temp_cobranza where credito = '"&id&"' and cuota = '"&temp_cobranza("cuota")&"'")				
				
				
			cobranza.close
		temp_cobranza.movenext
		loop
		temp_cobranza.close
		
	set credito2=bdd.execute("Select * from credito2 where credito = '"&id&"' ")
		if credito2.eof then
			set temp_credito2=bdd.execute("Select * from temp_credito2 where credito = '"&id&"'")
			
			set creditos2=bdd.execute("Insert into credito2 (credito,tipo,plazo) values ('"&temp_credito2("credito")&"','"&temp_credito2("tipo")&"','"&temp_credito2("plazo")&"')")

			set elim_tempcredito2=bdd.execute("delete from temp_credito2 where credito = '"&id&"'")
		
		end if
	
	set gestion_cobranza=bdd.execute("Select * from gestion_cobranza where credito = '"&id&"' ")
		if gestion_cobranza.eof then
			set temp_gestion_cobranza=bdd.execute("Select * from temp_gestion_cobranza where credito = '"&id&"'")
			
			set gestion_cobranza2=bdd.execute("Insert into gestion_cobranza (credito,desea,observaciones) values ('"&temp_gestion_cobranza("credito")&"','"&temp_gestion_cobranza("desea")&"','"&temp_gestion_cobranza("observaciones")&"')")
	
			set elim_gestion_cobranza=bdd.execute("delete from temp_gestion_cobranza where credito = '"&id&"'")
			
		end if
		
	set ingresos=bdd.execute("Select * from ingresos where credito = '"&id&"' ")
		if ingresos.eof then
			set temp_ingresos=bdd.execute("Select * from temp_ingresos where credito = '"&id&"'")	
	
dia=Day(temp_ingresos("fecha"))
mes=Month(temp_ingresos("fecha"))
ano=Year(temp_ingresos("fecha"))
finicial=ano&"-"&mes&"-"&dia	

			set ingresos2=bdd.execute("Insert into ingresos (hora,cobrador,tipo,banco,numero,clave,monto,cuota,credito,observacion,recibo,estado,fecha) values ('"&temp_ingresos("hora")&"','"&temp_ingresos("cobrador")&"','"&temp_ingresos("tipo")&"','"&temp_ingresos("banco")&"','"&temp_ingresos("numero")&"','"&temp_ingresos("clave")&"','"&temp_ingresos("monto")&"','"&temp_ingresos("cuota")&"','"&temp_ingresos("credito")&"','"&temp_ingresos("observacion")&"','"&temp_ingresos("recibo")&"','"&temp_ingresos("estado")&"','"&finicial&"')")
			
		 set elim_ingresos=bdd.execute("delete from temp_ingresos where credito = '"&id&"'")
		
		end if	
		
		set elim_temp_credito=bdd.execute("delete from temp_credito where id = '"&id&"'")
		
end if

response.Redirect("factura_saint.php?credito="&id)

%>
<!-- #include file ="../desconexion.dll" -->