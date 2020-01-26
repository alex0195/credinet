<?php
include_once("conexion.php");

$fechaX=time();
$fecha = date("d/m/Y h:i:s",$fechaX);
$periodo = date("Ym",$fechaX);

$server = 'credinet\credinet';//'ADOSOL-E8ADB20A';

// Connect to MSSQL
$link = mssql_connect($server, 'alexander', '6151326');

if ($link) 
{
mssql_select_db('creditel', $link);


$tabla=consulta("Select * from credito where Id = ".$_REQUEST['credito']." and facturado = 0");
	if($tabla)
	{
		$resultado=resultados($tabla);
	}
	else
	{
header("Location: plan.asp?id=".$_REQUEST['credito']);
		exit;
	}
	
				$t_cliente=consulta("Select * from dpersonales where t1 = '".$resultado['Cliente']."'");
				$r_cliente=resultados($t_cliente);

				$t_prd=consulta("Select * from inventario where id = ".$resultado['Equipo']);
				$r_prd=resultados($t_prd);
				
					$costo=($r_prd['Costo']/1.12)*1000;
					$iva=($r_prd['Costo']*0.12)*1000;
					$total=$costo+$iva;
			$t_pro=mssql_query("Select * from SAPROV where CodProv = '".$r_prd['Provedor']."'",$link);
				$r_pro = mssql_fetch_array($t_pro);				
//Area de cliente para saint
$q = mssql_query("Select * from SACLIE where CodClie = '".$resultado['Codigo']."'",$link);
	$num=mssql_num_rows($q);
//El cliente no existe por lo tanto agregamos la informacion de cliente a saint...
	if($num==0)
		{
			mssql_query("Insert into SACLIE_01 (CodClie) values ('".$resultado['Codigo']."')");
			echo "Tabla SACLIE_01<br>";
			mssql_query("Insert into SAICLI (CodClie) values ('".$resultado['Codigo']."')");
			echo "Tabla SAICLI<br>";
			mssql_query("Insert into DBTHIRD (TipoID3,ID3,ID3Org,Id_Alte) values (2,'V".$resultado['Cliente']."','V".$resultado['Cliente']."','".$resultado['Codigo']."')");
			echo "Tabla DBTHIRD<br>";

			mssql_query("Insert into SACLIE (CodClie,Descrip,ID3,Direc1,Activo,Pais,Estado,Ciudad,Telef,CodVend,TipoCli,TipoPVP,IntMora,EsCredito,LimiteCred,DiasCred,EsToleran,DiasTole,FechaE,Saldo,MontoMax,MtoMaxCred,PagosA,PromPago,RetenIVA,Descto,MontoUV,MontoUP,EsMoneda,TipoID3,Municipio) values ('".$resultado['Codigo']."','".$r_cliente['t3']." ".$r_cliente['t2']."','V".$resultado['Codigo']."','".$r_cliente['t14']."',1,0,0,0,'".$r_cliente['t11']."','00',0,0,0,1,500000,0,0,0,'".$fecha."',0,0,0,0,0,0,0,0,0,0,1,0)");
			echo "Tabla SACLIE<br>";

				
		}
//Fin area de cliente

//Area de productos
$q = mssql_query("Select * from SAPROD where CodProd = 'CPROD_".$resultado['Id']."'",$link);
	$num=mssql_num_rows($q);
//El Producto no existe por lo tanto agregamos la informacion delProducto
	if($num==0)
		{
			mssql_query("Insert into SAIPRD (CodProd) values ('CPROD_".$resultado['Id']."')");
			echo "Tabla SAIPRD<br>";
mssql_query("Insert into SAPROD_01 (CodProd,Cantidad_Extra,Precio_Extra,Impresora) values ('CPROD_".$resultado['Id']."',0,0,0)");
			echo "Tabla SAPROD_01<br>";

mssql_query("Insert into SATAXPRD (CodProd,CodTaxs,Monto,EsPorct) values ('CPROD_".$resultado['Id']."','IVA',12,1)");
			echo "Tabla SATAXPRD<br>";

mssql_query("Insert into SACODBAR (CodProd,CodAlte) values ('CPROD_".$resultado['Id']."','CPROD_".$resultado['Id']."')");
			echo "Tabla SACODBAR<br>";

			
mssql_query("Insert into SAPROD (CodProd,Descrip,CodInst,Activo,CantEmpaq,Precio1,Precio2,Precio3,PrecioU,CostAct,CostPro,CostAnt,Existen,ExUnidad,ExistenCon,ExUnidadCon,Compro,Pedido,Minimo,Maximo,Tara,DEsComp,DEsComi,DEsSeri,DEsLote,DEsVence,EsPublish,EsImport,EsExento,EsEnser,EsOferta,EsPesa,EsEmpaque,ExDecimal,DiasEntr,PrecioU2,PrecioU3,Volumen,EsReten) values ('CPROD_".$resultado['Id']."','".$r_prd['Marca']." ".$r_prd['Modelo']."',10,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0)");
			echo "Tabla SAPROD<br>";
		
		}
//Fin productos
//Area Nota de Entrega
$q = mssql_query("Select * from SAITEMCOM where NumeroD = 'CNE_".$resultado['Id']."'",$link);
	$num=mssql_num_rows($q);
//El Item no existe por lo tanto agregamos la informacion del Equipo
	if($num==0)
		{
			mssql_query("Insert into SAEPRD (
CodProd,Periodo,CntInicial,ExInicial,MtoCompra,CntCompra,MtoVentas,CntVentas,Costo,MtoCargos,CntCargos,MtoDescarg,CntDescarg,ExFinal,CostoFinal) values 
('CPROD_".$resultado['Id']."','".$periodo."',0,0,0,0,0,0,0,0,0,0,0,0,0)");
			echo "Tabla SAEPRD<br>";

			mssql_query("Insert into SAEXIS (
CodProd,CodUbic,Existen,ExUnidad,CantPed,UnidPed,CantCom,UnidCom) values 
('CPROD_".$resultado['Id']."','01',1,0,0,0,0,0)");
			echo "Tabla SAEXIS<br>";
			
mssql_query("Insert into SAINITI (CodProd,CodUbic,Periodo,ExInicial,ExUndIni,ExFinal,ExUndFinal,Costo,CostoFinal) values 
('CPROD_".$resultado['Id']."','01','".$periodo."',0,0,0,0,0,0)");
			echo "Tabla SAINITI<br>";


mssql_query("Insert into SAITEMCOM (TipoCom,NumeroD,CodProv,NroLinea,CodItem,CodUbic,Descrip1,Signo,Cantidad,CantidadO,ExistAntU,ExistAnt,Faltante,CantidadC,CantidadU,CantidadA,CantidadUA,Costo,Precio1,Precio2,Precio3,PrecioU,Precio,Descto,FechaE,FechaL,EsServ,EsUnid,EsFreeP,EsPesa,EsExento,UsaServ,DEsLote,DEsSeri,Tara,TotalItem,PrecioU2,PrecioU3,NroUnicoL) values 
('J','CNE_".$resultado['Id']."','".$r_prd['Provedor']."',1,'CPROD_".$resultado['Id']."','01','".$r_prd['Marca']." ".$r_prd['Modelo']."',1,1,0,0,0,0,0,0,0,0,$costo,$costo,$costo,$costo,0,0,0,'".$fecha."','".$fecha."',0,0,0,0,0,0,0,1,0,$costo,0,0,0)");
			echo "Tabla SAITEMCOM<br>";
			
mssql_query("Insert into SASEPRCOM (TipoCom,NumeroD,CodProv,NroLinea,NroSerial,CodItem,CodUbic,Esconsig) values 
('J','CNE_".$resultado['Equipo']."','".$r_prd['Provedor']."',1,'".$r_prd['Serial']."','CPROD_".$resultado['Equipo']."','01',0)");

			echo "Tabla SASEPRCOM<br>";


mssql_query("Insert into SASERI (CodProd,CodUbic,NroSerial) values 
('CPROD_".$resultado['Id']."','01','".$r_prd['Serial']."')");
			echo "Tabla SASERI<br>";
			
			
mssql_query("Insert into SACOMP (TipoCom,NumeroD,CodProv,CodSucu,CodEsta,CodUsua,Signo,Factor,MontoMEx,CodUbic,Descrip,Pais,Estado,Ciudad,ID3,Monto,OtrosC,MtoTax,Fletes,TGravable,TExento,EsConsig,DesctoP,RetenIVA,FechaE,FechaV,CancelI,CancelE,CancelT,CancelC,CancelA,CancelG,Descto1,MtoInt1,Descto2,MtoInt2,MtoFinanc,TotalPrd,TotalSrv,NGiros,NMeses,SaldoAct,MtoPagos,MtoNCredito,MtoNDebito,FechaI,MtoTotal,Contado,Credito,FechaT,Municipio
) values 
('J','CNE_".$resultado['Id']."','".$r_prd['Provedor']."','0000','CREDINET','001',1,1,0,'01','".$r_pro['Descrip']."',0,0,0,'".$r_pro['ID3']."',$costo,0,$iva,0,$costo,0,0,0,0,'".$fecha."','".$fecha."',0,0,0,0,0,0,0,0,0,0,0,$costo,0,0,0,0,0,0,0,0,0,0,0,'".$fecha."',0)");

			echo "Tabla SACOMP<br>";

		}
//Fin Nota de Entrega

//Area de Pedido
$q = mssql_query("Select * from SAFACT where NumeroD = 'CPED_".$resultado['Id']."'",$link);
	$num=mssql_num_rows($q);
//El Item no existe por lo tanto agregamos la informacion del Equipo
	if($num==0)
		{

			$t_prd=consulta("Select * from inventario where id = ".$resultado['Equipo']);
				$r_prd=resultados($t_prd);
					$costo=($r_prd['Costo']/1.12)*1000;
					$iva=($r_prd['Costo']*0.12)*1000;
			$t_pro=mssql_query("Select * from SAPROV where CodProv = '".$r_prd['Provedor']."'",$link);
				$r_pro = mssql_fetch_array($t_pro);

mssql_query("Insert into SAFACT (TipoFac,NumeroD,CodSucu,CodEsta,CodUsua,Signo,EsExPickup,Factor,MontoMEx,CodClie,CodVend,CodUbic,Descrip,Direc1,Pais,Estado,Ciudad,Telef,ID3,Monto,MtoTax,Fletes,TGravable,TExento,CostoPrd,CostoSrv,DesctoP,RetenIVA,FechaI,FechaE,FechaV,CancelI,CancelA,CancelE,CancelC,CancelT,CancelG,CancelP,Cambio,EsConsig,MtoExtra,ValorPtos,Descto1,PctAnual,MtoInt1,Descto2,PctManejo,MtoInt2,MtoPagos,MtoNCredito,MtoNDebito,MtoFinanc,TotalPrd,TotalSrv,CodOper,NGiros,NMeses,MtoComiVta,MtoComiCob,MtoComiVtaD,MtoComiCobD,MtoTotal,Contado,Credito,Fechat,saldoact,Municipio) values 
('E','CPED_".$resultado['Id']."','0000','CREDINET','001',1,0,1,0,'".$resultado['Codigo']."','00','01','".$r_cliente['t3']." ".$r_cliente['t2']."','".$r_cliente['t14']."',0,0,0,0,'".$resultado['Cliente']."',$costo,$iva,0,$costo,0,0,0,0,0,'".$fecha."','".$fecha."','".$fecha."',0,0,0,0,0,0,0,0,0,0,$costo,0,0,0,0,0,0,0,0,0,0,$costo,0,'001',0,0,0,0,0,0,$total,0,$total,'".$fecha."',0,0)");
			echo "Tabla SAFAC<br>";

mssql_query("Insert into SAITEMFAC (
TipoFac,NumeroD,NroLinea,NroLineaC,CodItem,CodUbic,CodVend,Descrip1,Refere,Signo,CantMayor,Cantidad,CantidadO,ExistAntU,ExistAnt,CantidadU,CantidadC,CantidadA,CantidadUA,Costo,Precio,Descto,FechaE,EsServ,EsUnid,EsFreeP,EsPesa,EsExento,UsaServ,DEsLote,DEsSeri,DEsComp,NroUnicoL,Tara,TotalItem
) values 
('E','CPED_".$resultado['Id']."',1,0,'CPROD_".$resultado['Id']."','01','00','".$r_prd['Marca']." ".$r_prd['Modelo']."','CPROD_".$resultado['Id']."',1,1,1,0,0,1,0,0,0,0,$costo,$costo,0,'".$fecha."',0,0,0,0,0,0,0,1,0,0,0,0)");
			echo "Tabla SAITEMFAC<br>";			

		}
//Fin area Pedido
header("Location: p_giros.asp?credito=".$_REQUEST['credito']);
}
?>

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
