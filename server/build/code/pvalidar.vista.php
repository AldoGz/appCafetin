<?php
//VALIDAR USER
session_name("CAFETIN");
session_start();
if ( !isset($_SESSION["cod_usuario"]) ) {
    header("Location:../../sesion/");
    exit; //Detiene la ejecución de la página    
}
if ( $_SESSION["cargo"] != "BAR" ) {
    header("Location:../../".strtolower($_SESSION["cargo"])."/");
    exit; //Detiene la ejecución de la página    
}