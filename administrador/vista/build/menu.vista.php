<?php 
    $arr = explode("/",$_SERVER["PHP_SELF"]);        
    $url = $arr[count($arr) - 2];
    $menu = "";
    switch($url){
        case "categoria":
            $menu .=   '<li class="active">
                            <a href="../categoria">
                                <i class="material-icons">layers</i>
                                <span>Categoria</span>
                            </a>
                        </li>
                        <li>
                            <a href="../empleado">
                                <i class="material-icons">transfer_within_a_station</i>
                                <span>Empleado</span>
                            </a>
                        </li>
                        <li>
                            <a href="../mesa">
                                <i class="material-icons">apps</i>
                                <span>Mesa</span>
                            </a>
                        </li>
                        <li>
                            <a href="../producto">
                                <i class="material-icons">restaurant_menu</i>
                                <span>Producto</span>
                            </a>
                        </li>
                        <li>
                            <a href="../utensilio">
                                <i class="material-icons">local_activity</i>
                                <span>Agregados</span>
                            </a>
                        </li>
                        
                        <li>
                            <a href="../agregar_utensilio">
                                <i class="material-icons">beenhere</i>
                                <span>Asignar agregados</span>
                            </a>
                        </li>
                        <li>
                            <a href="../usuario">
                                <i class="material-icons">person_outline</i>
                                <span>Usuario</span>
                            </a>
                        </li>
                        <li>
                            <a href="../serie_comprobante">
                                <i class="material-icons">content_copy</i>
                                <span>Serie comprobante</span>
                            </a>
                        </li>
                        <li>
                            <a href="../bonus">
                                <i class="material-icons">star_border</i>
                                <span>Promocion bonus</span>
                            </a>
                        </li>
                        <li>
                            <a href="../puntos">
                                <i class="material-icons">star_border</i>
                                <span>Promoción puntos</span>
                            </a>
                        </li>';
            break;
        case "empleado":
            $menu .=   '<li>
                            <a href="../categoria">
                                <i class="material-icons">layers</i>
                                <span>Categoria</span>
                            </a>
                        </li>
                        <li class="active">
                            <a href="../empleado">
                                <i class="material-icons">transfer_within_a_station</i>
                                <span>Empleado</span>
                            </a>
                        </li>
                        <li>
                            <a href="../mesa">
                                <i class="material-icons">apps</i>
                                <span>Mesa</span>
                            </a>
                        </li>
                        <li>
                            <a href="../producto">
                                <i class="material-icons">restaurant_menu</i>
                                <span>Producto</span>
                            </a>
                        </li>
                        <li>
                            <a href="../utensilio">
                                <i class="material-icons">local_activity</i>
                                <span>Agregados</span>
                            </a>
                        </li>
                        
                        <li>
                            <a href="../agregar_utensilio">
                                <i class="material-icons">beenhere</i>
                                <span>Asignar agregados</span>
                            </a>
                        </li>
                        <li>
                            <a href="../usuario">
                                <i class="material-icons">person_outline</i>
                                <span>Usuario</span>
                            </a>
                        </li>
                        <li>
                            <a href="../serie_comprobante">
                                <i class="material-icons">content_copy</i>
                                <span>Serie comprobante</span>
                            </a>
                        </li>
                        <li>
                            <a href="../bonus">
                                <i class="material-icons">star_border</i>
                                <span>Promocion bonus</span>
                            </a>
                        </li>
                        <li>
                            <a href="../puntos">
                                <i class="material-icons">star_border</i>
                                <span>Promoción puntos</span>
                            </a>
                        </li>';
            break;
        case "mesa":
            $menu .=   '<li>
                            <a href="../categoria">
                                <i class="material-icons">layers</i>
                                <span>Categoria</span>
                            </a>
                        </li>
                        <li>
                            <a href="../empleado">
                                <i class="material-icons">transfer_within_a_station</i>
                                <span>Empleado</span>
                            </a>
                        </li>
                        <li class="active">
                            <a href="../mesa">
                                <i class="material-icons">apps</i>
                                <span>Mesa</span>
                            </a>
                        </li>
                        <li>
                            <a href="../producto">
                                <i class="material-icons">restaurant_menu</i>
                                <span>Producto</span>
                            </a>
                        </li>
                        <li>
                            <a href="../utensilio">
                                <i class="material-icons">local_activity</i>
                                <span>Agregados</span>
                            </a>
                        </li>
                        
                        <li>
                            <a href="../agregar_utensilio">
                                <i class="material-icons">beenhere</i>
                                <span>Asignar agregados</span>
                            </a>
                        </li>
                        <li>
                            <a href="../usuario">
                                <i class="material-icons">person_outline</i>
                                <span>Usuario</span>
                            </a>
                        </li>
                        <li>
                            <a href="../serie_comprobante">
                                <i class="material-icons">content_copy</i>
                                <span>Serie comprobante</span>
                            </a>
                        </li>
                        <li>
                            <a href="../bonus">
                                <i class="material-icons">star_border</i>
                                <span>Promocion bonus</span>
                            </a>
                        </li>
                        <li>
                            <a href="../puntos">
                                <i class="material-icons">star_border</i>
                                <span>Promoción puntos</span>
                            </a>
                        </li>';
            break;
        case "producto":
            $menu .=   '<li>
                            <a href="../categoria">
                                <i class="material-icons">layers</i>
                                <span>Categoria</span>
                            </a>
                        </li>
                        <li>
                            <a href="../empleado">
                                <i class="material-icons">transfer_within_a_station</i>
                                <span>Empleado</span>
                            </a>
                        </li>
                        <li>
                            <a href="../mesa">
                                <i class="material-icons">apps</i>
                                <span>Mesa</span>
                            </a>
                        </li>
                        <li class="active">
                            <a href="../producto">
                                <i class="material-icons">restaurant_menu</i>
                                <span>Producto</span>
                            </a>
                        </li>
                        <li>
                            <a href="../utensilio">
                                <i class="material-icons">local_activity</i>
                                <span>Agregados</span>
                            </a>
                        </li>                        
                        <li>
                            <a href="../agregar_utensilio">
                                <i class="material-icons">beenhere</i>
                                <span>Asignar agregados</span>
                            </a>
                        </li>
                        <li>
                            <a href="../usuario">
                                <i class="material-icons">person_outline</i>
                                <span>Usuario</span>
                            </a>
                        </li>
                        <li>
                            <a href="../serie_comprobante">
                                <i class="material-icons">home</i>
                                <span>Serie comprobante</span>
                            </a>
                        </li>
                        <li>
                            <a href="../bonus">
                                <i class="material-icons">star_border</i>
                                <span>Promocion bonus</span>
                            </a>
                        </li>
                        <li>
                            <a href="../puntos">
                                <i class="material-icons">star_border</i>
                                <span>Promoción puntos</span>
                            </a>
                        </li>';
            break;
        case "utensilio":
            $menu .=   '<li>
                            <a href="../categoria">
                                <i class="material-icons">layers</i>
                                <span>Categoria</span>
                            </a>
                        </li>
                        <li>
                            <a href="../empleado">
                                <i class="material-icons">transfer_within_a_station</i>
                                <span>Empleado</span>
                            </a>
                        </li>
                        <li>
                            <a href="../mesa">
                                <i class="material-icons">apps</i>
                                <span>Mesa</span>
                            </a>
                        </li>
                        <li>
                            <a href="../producto">
                                <i class="material-icons">restaurant_menu</i>
                                <span>Producto</span>
                            </a>
                        </li>
                        <li class="active">
                            <a href="../utensilio">
                                <i class="material-icons">local_activity</i>
                                <span>Agregados</span>
                            </a>
                        </li>                        
                        <li>
                            <a href="../agregar_utensilio">
                                <i class="material-icons">beenhere</i>
                                <span>Asignar agregados</span>
                            </a>
                        </li>
                        <li>
                            <a href="../usuario">
                                <i class="material-icons">person_outline</i>
                                <span>Usuario</span>
                            </a>
                        </li>
                        <li>
                            <a href="../serie_comprobante">
                                <i class="material-icons">content_copy</i>
                                <span>Serie comprobante</span>
                            </a>
                        </li>
                        <li>
                            <a href="../bonus">
                                <i class="material-icons">star_border</i>
                                <span>Promocion bonus</span>
                            </a>
                        </li>
                        <li>
                            <a href="../puntos">
                                <i class="material-icons">star_border</i>
                                <span>Promoción puntos</span>
                            </a>
                        </li>';
            break;
        case "usuario":
            $menu .=   '<li>
                            <a href="../categoria">
                                <i class="material-icons">layers</i>
                                <span>Categoria</span>
                            </a>
                        </li>
                        <li>
                            <a href="../empleado">
                                <i class="material-icons">transfer_within_a_station</i>
                                <span>Empleado</span>
                            </a>
                        </li>
                        <li>
                            <a href="../mesa">
                                <i class="material-icons">apps</i>
                                <span>Mesa</span>
                            </a>
                        </li>
                        <li>
                            <a href="../producto">
                                <i class="material-icons">restaurant_menu</i>
                                <span>Producto</span>
                            </a>
                        </li>
                        <li>
                            <a href="../utensilio">
                                <i class="material-icons">local_activity</i>
                                <span>Agregados</span>
                            </a>
                        </li>                        
                        <li>
                            <a href="../agregar_utensilio">
                                <i class="material-icons">beenhere</i>
                                <span>Asignar agregados</span>
                            </a>
                        </li>
                        <li class="active">
                            <a href="../usuario">
                                <i class="material-icons">person_outline</i>
                                <span>Usuario</span>
                            </a>
                        </li>
                        <li>
                            <a href="../serie_comprobante">
                                <i class="material-icons">content_copy</i>
                                <span>Serie comprobante</span>
                            </a>
                        </li>
                        <li>
                            <a href="../bonus">
                                <i class="material-icons">star_border</i>
                                <span>Promocion bonus</span>
                            </a>
                        </li>
                        <li>
                            <a href="../puntos">
                                <i class="material-icons">star_border</i>
                                <span>Promoción puntos</span>
                            </a>
                        </li>';
            break;
        case "agregar_utensilio":
            $menu .=   '<li>
                            <a href="../categoria">
                                <i class="material-icons">layers</i>
                                <span>Categoria</span>
                            </a>
                        </li>
                        <li>
                            <a href="../empleado">
                                <i class="material-icons">transfer_within_a_station</i>
                                <span>Empleado</span>
                            </a>
                        </li>
                        <li>
                            <a href="../mesa">
                                <i class="material-icons">apps</i>
                                <span>Mesa</span>
                            </a>
                        </li>
                        <li>
                            <a href="../producto">
                                <i class="material-icons">restaurant_menu</i>
                                <span>Producto</span>
                            </a>
                        </li>
                        <li>
                            <a href="../utensilio">
                                <i class="material-icons">local_activity</i>
                                <span>Agregados</span>
                            </a>
                        </li>                        
                        <li  class="active">
                            <a href="../agregar_utensilio">
                                <i class="material-icons">beenhere</i>
                                <span>Asignar agregados</span>
                            </a>
                        </li>
                        <li>
                            <a href="../usuario">
                                <i class="material-icons">person_outline</i>
                                <span>Usuario</span>
                            </a>
                        </li>
                        <li>
                            <a href="../serie_comprobante">
                                <i class="material-icons">content_copy</i>
                                <span>Serie comprobante</span>
                            </a>
                        </li>
                        <li>
                            <a href="../bonus">
                                <i class="material-icons">star_border</i>
                                <span>Promocion bonus</span>
                            </a>
                        </li>
                        <li>
                            <a href="../puntos">
                                <i class="material-icons">star_border</i>
                                <span>Promoción puntos</span>
                            </a>
                        </li>';
            break;
        case "serie_comprobante":
            $menu .=   '<li>
                            <a href="../categoria">
                                <i class="material-icons">layers</i>
                                <span>Categoria</span>
                            </a>
                        </li>
                        <li>
                            <a href="../empleado">
                                <i class="material-icons">transfer_within_a_station</i>
                                <span>Empleado</span>
                            </a>
                        </li>
                        <li>
                            <a href="../mesa">
                                <i class="material-icons">apps</i>
                                <span>Mesa</span>
                            </a>
                        </li>
                        <li>
                            <a href="../producto">
                                <i class="material-icons">restaurant_menu</i>
                                <span>Producto</span>
                            </a>
                        </li>
                        <li>
                            <a href="../utensilio">
                                <i class="material-icons">local_activity</i>
                                <span>Agregados</span>
                            </a>
                        </li>                        
                        <li>
                            <a href="../agregar_utensilio">
                                <i class="material-icons">beenhere</i>
                                <span>Asignar agregados</span>
                            </a>
                        </li>
                        <li>
                            <a href="../usuario">
                                <i class="material-icons">person_outline</i>
                                <span>Usuario</span>
                            </a>
                        </li>
                        <li class="active">
                            <a href="../serie_comprobante">
                                <i class="material-icons">content_copy</i>
                                <span>Serie comprobante</span>
                            </a>
                        </li>
                        <li>
                            <a href="../bonus">
                                <i class="material-icons">star_border</i>
                                <span>Promocion bonus</span>
                            </a>
                        </li>
                        <li>
                            <a href="../puntos">
                                <i class="material-icons">star_border</i>
                                <span>Promoción puntos</span>
                            </a>
                        </li>';
            break;
        case "bonus":
            $menu .=   '<li>
                            <a href="../categoria">
                                <i class="material-icons">layers</i>
                                <span>Categoria</span>
                            </a>
                        </li>
                        <li>
                            <a href="../empleado">
                                <i class="material-icons">transfer_within_a_station</i>
                                <span>Empleado</span>
                            </a>
                        </li>
                        <li>
                            <a href="../mesa">
                                <i class="material-icons">apps</i>
                                <span>Mesa</span>
                            </a>
                        </li>
                        <li>
                            <a href="../producto">
                                <i class="material-icons">restaurant_menu</i>
                                <span>Producto</span>
                            </a>
                        </li>
                        <li>
                            <a href="../utensilio">
                                <i class="material-icons">local_activity</i>
                                <span>Agregados</span>
                            </a>
                        </li>                        
                        <li>
                            <a href="../agregar_utensilio">
                                <i class="material-icons">beenhere</i>
                                <span>Asignar agregados</span>
                            </a>
                        </li>
                        <li>
                            <a href="../usuario">
                                <i class="material-icons">person_outline</i>
                                <span>Usuario</span>
                            </a>
                        </li>
                        <li>
                            <a href="../serie_comprobante">
                                <i class="material-icons">content_copy</i>
                                <span>Serie comprobante</span>
                            </a>
                        </li>
                        <li class="active">
                            <a href="../bonus">
                                <i class="material-icons">star_border</i>
                                <span>Promocion bonus</span>
                            </a>
                        </li>
                        <li>
                            <a href="../puntos">
                                <i class="material-icons">star_border</i>
                                <span>Promoción puntos</span>
                            </a>
                        </li>';
            break;
        case "puntos":
            $menu .=   '<li>
                            <a href="../categoria">
                                <i class="material-icons">layers</i>
                                <span>Categoria</span>
                            </a>
                        </li>
                        <li>
                            <a href="../empleado">
                                <i class="material-icons">transfer_within_a_station</i>
                                <span>Empleado</span>
                            </a>
                        </li>
                        <li>
                            <a href="../mesa">
                                <i class="material-icons">apps</i>
                                <span>Mesa</span>
                            </a>
                        </li>
                        <li>
                            <a href="../producto">
                                <i class="material-icons">restaurant_menu</i>
                                <span>Producto</span>
                            </a>
                        </li>
                        <li>
                            <a href="../utensilio">
                                <i class="material-icons">local_activity</i>
                                <span>Agregados</span>
                            </a>
                        </li>                        
                        <li>
                            <a href="../agregar_utensilio">
                                <i class="material-icons">beenhere</i>
                                <span>Asignar agregados</span>
                            </a>
                        </li>
                        <li>
                            <a href="../usuario">
                                <i class="material-icons">person_outline</i>
                                <span>Usuario</span>
                            </a>
                        </li>
                        <li>
                            <a href="../serie_comprobante">
                                <i class="material-icons">content_copy</i>
                                <span>Serie comprobante</span>
                            </a>
                        </li>
                        <li>
                            <a href="../bonus">
                                <i class="material-icons">star_border</i>
                                <span>Promocion bonus</span>
                            </a>
                        </li>
                        <li class="active">
                            <a href="../puntos">
                                <i class="material-icons">star_border</i>
                                <span>Promoción puntos</span>
                            </a>
                        </li>';
            break;
    }
?>

<div class="menu">
    <ul class="list">
        <li class="header">Menú principal</li>
        <?php echo $menu; ?>
        <!-- #Construir Menú -->
        <li>
            <a href="../cerrar_sesion.php"  class="waves-effect waves-block">
                <i class="material-icons col-green">donut_large</i>
                <span>Cerrar Sesión</span>
            </a>
        </li>                    
    </ul>
</div>