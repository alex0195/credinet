<?php
function Conectarse() 
{
	if (!($bdd=mysql_connect("localhost","root","6151326"))) //Local
//	if (!($bdd=mysql_connect("localhost","adosolc_datos","6151326"))) //Server
   { 
      echo "No se puede conectar a mysql"; 
      exit(); 
   } 
   if (!mysql_select_db("credinet",$bdd))
   { 
      echo "La bdd no existe"; 
      exit(); 
   } 
   return $bdd;
} 

function cerrar($conexion)
{
  mysql_close($conexion);
}

function consulta($consulta)
{
	//Actualizamos al mortal a ver cuando fue la ultima interaccion en el sistema
if (isset($_SESSION['usuario']))
{
	sql("Update si_acceso set fecha = ".mktime()." where id=".$_SESSION['usuario']['id']);
}
	//Fin actualizacion
	
  $tabla=mysql_query($consulta);
  $num=registros($tabla);
  	if($num!=0)
	{
		return $tabla;
	}
	else
	{
		return false;
	}
}

//Para consultas problematicas

function consulta2($consulta)
{
  return mysql_query($consulta);
}

function sql($consulta)
{
	mysql_query($consulta);
}

function resultados($consulta)
{
  return mysql_fetch_array($consulta, MYSQL_ASSOC);
}

function registros($consulta)
{
  return mysql_num_rows($consulta);
}

function libera($consulta)
{
mysql_free_result($consulta);
}
$bdd=Conectarse();

function ingreso($tabla,$ref)
{
sql("update ".$tabla. " set culpable = ".$_SESSION['usuario']['id'].",fechap=".mktime().",fecham=".$ahora." where id = ".$ref);

}

function actualiza($tabla,$ref)
{
sql("update ".$tabla. " set culpable = ".$_SESSION['usuario']['id'].",fecham=".mktime()." where id = ".$ref);

}

function historia($ref)
{
	sql("Insert into si_historico(ref,operador,fecha) values (".$ref.",".$_SESSION['usuario']['id'].",".mktime().")");
}

function num($cifra)
{
	return number_format($cifra,2,',','.');
}
?>