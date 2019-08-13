<?php

require_once '../acceso/Conexion.clase.php';

class Sesion extends Conexion {
    private $usuario;
    private $clave;

    public function getUsuario(){
        return $this->usuario;
    }
    
    public function setUsuario($usuario){
        $this->usuario = $usuario;
        return $this;
    }

    public function getClave(){
        return $this->clave;
    }
    
    public function setClave($clave){
        $this->clave = $clave;
        return $this;
    }

    public function inicioSesion() {
        try {
            $sql = "SELECT
                        e.id,
                        e.dni,
                        CONCAT(nombres,' ',apellido_paterno,' ',apellido_materno) as empleado,
                        e.id_tipo_empleado,
                        te.descripcion as perfil,
                        IF(u.clave IS NULL,'',u.clave) as clave,                    
                        u.estado as estado
                    FROM empleado e
                    INNER JOIN usuario u ON u.id_empleado = e.id
                    INNER JOIN tipo_empleado te ON te.id = e.id_tipo_empleado
                    WHERE e.dni = :0";
            $resultado = $this->consultarFila($sql,[$this->getUsuario()]);

            if ( $resultado ) { //
                if ( !empty($resultado["clave"]) ) {
                    if ( $resultado["clave"] === md5($this->getClave()) ) {
                        if ( $resultado["estado"] === "1" ) {
                            session_name("CAFETIN");
                            session_start();
                            $_SESSION["cod_usuario"] = $resultado["id"]; 
                            $_SESSION["usuario"] = $resultado["empleado"];
                            $_SESSION["cargo"] = $resultado["perfil"];
                            return array("rpt"=>true,"estado"=>true,"msj"=>$resultado);
                        }else{
                            return array("rpt"=>true,"estado"=>false,"msj"=>"Este usuario se encuentra inactivo actualmente");
                        }
                    }else{
                        return array("rpt"=>true,"estado"=>false,"msj"=>"La clave de este usuario no coincide");    
                    }
                }else{
                    return array("rpt"=>true,"estado"=>false,"msj"=>"Este usuario no tiene permisos");  
                }
            }else{
                return array("rpt"=>true,"estado"=>false,"msj"=>"Este usuario no se encuentra registrado");
            }
        } catch (Exception $exc) {
            return array("rpt"=>false,"msj"=>$exc);
            throw $exc;
        }
    }

}