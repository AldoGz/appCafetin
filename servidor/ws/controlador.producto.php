<?php

require_once '../acceso/local_config.php';
require_once MODELO_FUNCIONES;
require_once '../negocio/Producto.clase.php';

if (!isset($_POST["p_array_datos"])) {
    Funciones::imprimeJSON(500, "Faltan parametros", "");
    exit();
}
parse_str($_POST["p_array_datos"], $datosFormulario);
try {
    $obj = new Producto();
    $obj->setId($datosFormulario["intCodigoProducto"]);
    $obj->setNombre($datosFormulario["strNombre"]);
    $obj->setPrecio($datosFormulario["douPrecio"]);
    $obj->setId_categoria($datosFormulario["intCodigoCategoria"]);    
    $obj->setFoto(empty($_FILES["p_foto"]) == 1 ? 'defecto.jpg' : $obj->correlativo());
    $obj->setDescripcion($datosFormulario["strDescripcion"]);

    if (isset($_FILES["p_foto"])) {          
        $tmp = str_replace(" ", "_", $_FILES["p_foto"]["tmp_name"]);
        move_uploaded_file($tmp, "../../admin/images/productos/".$obj->correlativo());    
    }

    $accion = $datosFormulario["operacion"] == 'agregar' ? $obj->agregar() : $obj->editar();
    Funciones::imprimeJSON(200, "OK",$accion);    
} catch (Exception $exc) {
    Funciones::imprimeJSON(500, $exc->getMessage(), "");
}