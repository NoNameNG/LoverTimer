<?php

define ( 'LOVETIMER', true);
define ( 'ROOTDIR', dirname ( __FILE__ ) );
define ( 'COREDIR', ROOTDIR . '/core' );
define ( 'TEMPLATE_DIR', ROOTDIR . '/templates/' );

require_once COREDIR . '/mysql.php';
require_once COREDIR . '/templates.class.php';
require_once COREDIR . '/dbconfig.php';

$GenTpl = new template();
$ModTpl = new template();
$ModTpl->dir = $GenTpl->dir = ROOTDIR . '/templates/';

$do = $_REQUEST['do'];

#Авторизация
if($_COOKIE["uname"] != null AND $_COOKIE["upass"] != null){
	
	$User = $db->super_query("SELECT * FROM users WHERE uname = '{$db->safesql($_COOKIE["uname"])}' AND upass = '{$db->safesql($_COOKIE["upass"])}'");

	if($User == null){
		
		setcookie ("uname","",0);
		setcookie ("upass","",0);

	}else{
			
		if($_REQUEST['noupdate'] != 1){
			
			$date = date("Y.m.d H:m:s",time()+(60*60*4));
			
			$db->query ( "UPDATE users set visits=visits+1,lastlogin='{$date}' WHERE uid = ".$User['uid'] );
			
		}
		
	}
	
}else
	$User = null;

$count = $db->super_query ( "SELECT sum(visits) AS count FROM users" );

#Модули
if($User == null) $do = "login";

$GenTpl->load_template( 'main.tpl' );

switch($do){
	
	case "login":

		if(isset($_POST["uname"]) AND isset($_POST["upass"])){
			
			$User = $db->super_query("SELECT * FROM users WHERE uname = '{$db->safesql($_POST["uname"])}' AND upass = '{$db->safesql($_POST["upass"])}'");
			
			if($User != null){
				
				setcookie ("uname",$_POST["uname"],time() + 60*60*24*365);
				setcookie ("upass",$_POST["upass"],time() + 60*60*24*365);

			}else{
				
				$error = "Неверный логин или пароль";
				
			}
			
		}
		
		if($User != null){

			header('Location:'.substr($_SERVER["PHP_SELF"], 0, -strlen(pathinfo(__FILE__)['basename'])));
			die();
			
		}
	
		$ModName = "Авторизация";
		
		$ModTpl->load_template( 'login.tpl' );
		$ModTpl->set( '{error}', $error );
		$ModTpl->compile( 'login' );
		$ModTpl->clear();
		
		$GenTpl->set( '{content}', $ModTpl->result['login'] );
	
	break;
	
	case "logout":

		$ModName = "Выход";
		
		setcookie ("uname","",0);
		setcookie ("upass","",0);
		
		header('Location:'.substr($_SERVER["PHP_SELF"], 0, -strlen(pathinfo(__FILE__)['basename'])));
		die();
	
	break;
	
	case "fulltime":
	
		$ModName = "Сколько мы встречаемся";
		
		header('Location:'.substr($_SERVER["PHP_SELF"], 0, -strlen(pathinfo(__FILE__)['basename'])));
		die();
	
	break;
	
	default:
	
		$ModName = "Таймер до нашей встречи";

		$ModTpl->load_template( 'timer.tpl' );
		$ModTpl->compile( 'timer' );
		$ModTpl->clear();
		
		$GenTpl->set( '{content}', $ModTpl->result['timer'] );
	
	break;
	
}

$GenTpl->set( '{modname}', $ModName );
$GenTpl->set( '{uname}', $User["uname"] );
$GenTpl->set( '{count}', $count["count"] );

if($User == null){
	
	$GenTpl->set_block( "'\\[logged\\](.*?)\\[/logged\\]'si", "" );
	
}else{
	
	$GenTpl->set( '[logged]', "" );
	$GenTpl->set( '[/logged]', "" );
	
}

$GenTpl->compile( 'main' );
$GenTpl->clear();

echo $GenTpl->result['main'];

function totranslit($var, $lower = true, $punkt = true) {
	global $langtranslit;
	
	if ( is_array($var) ) return "";

	$var = str_replace(chr(0), '', $var);

	if (!is_array ( $langtranslit ) OR !count( $langtranslit ) ) {
		$var = trim( strip_tags( $var ) );

		if ( $punkt ) $var = preg_replace( "/[^a-z0-9\_\-.]+/mi", "", $var );
		else $var = preg_replace( "/[^a-z0-9\_\-]+/mi", "", $var );

		$var = preg_replace( '#[.]+#i', '.', $var );
		$var = str_ireplace( ".php", ".ppp", $var );

		if ( $lower ) $var = strtolower( $var );

		return $var;
	}
	
	$var = trim( strip_tags( $var ) );
	$var = preg_replace( "/\s+/ms", "-", $var );
	$var = str_replace( "/", "-", $var );

	$var = strtr($var, $langtranslit);
	
	if ( $punkt ) $var = preg_replace( "/[^a-z0-9\_\-.]+/mi", "", $var );
	else $var = preg_replace( "/[^a-z0-9\_\-]+/mi", "", $var );

	$var = preg_replace( '#[\-]+#i', '-', $var );
	$var = preg_replace( '#[.]+#i', '.', $var );

	if ( $lower ) $var = strtolower( $var );

	$var = str_ireplace( ".php", "", $var );
	$var = str_ireplace( ".php", ".ppp", $var );

	if( strlen( $var ) > 200 ) {
		
		$var = substr( $var, 0, 200 );
		
		if( ($temp_max = strrpos( $var, '-' )) ) $var = substr( $var, 0, $temp_max );
	
	}
	
	return $var;
}

?>