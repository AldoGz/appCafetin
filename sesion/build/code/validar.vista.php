<?php
session_name("CAFETIN");
session_start();
if ( isset($_SESSION["cod_usuario"]) ) {
    switch ($_SESSION["cargo"]) {
        case 'CAJERO':
            header("Location:../../cajero/");        
            break;
        case 'ADMINISTRADOR':            
            header("Location:../../administrador/vista/tipo_empleado/");        
            break;
        case 'MESERO':            
            header("Location:../../mesero/");        
            break;
        case 'COCINERO':            
            header("Location:../../server/kitchen/");        
            break;
        case 'BAR':            
            header("Location:../../server/pub/");        
            break;
    }
    exit; //Detiene la ejecución de la página    
}
?>
