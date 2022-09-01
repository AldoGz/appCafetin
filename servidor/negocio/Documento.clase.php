<?php
require_once '../acceso/Conexion.clase.php';

class Documento extends Conexion {
    private $documento;

    public function getDocumento(){
        return $this->documento;
    }
    
    public function setDocumento($documento){
        $this->documento = $documento;
        return $this;
    }

    public function preguntar($tipo) {
        try {
            $resultado["documento"] = $tipo === "RUC" ? $this->consultarRUC($this->getDocumento()) : $this->consultarDNI($this->getDocumento());

            $sql = "SELECT 
                        documento,
                        razon_social,
                        SUM(puntos) as puntos
                    FROM facturacion WHERE documento = :0 AND estado_puntos = 1
                    GROUP BY razon_social";          
            $resultado["puntos"] = $this->consultarFila($sql,[$this->getDocumento()]);
            return array("rpt"=>true,"msj"=>$resultado);
        } catch (Exception $exc) {
            return array("rpt"=>false,"msj"=>$exc);
            throw $exc;
        }
    }

    public function consultarRUC($DNI){
        $url = "https://dniruc.apisperu.com/api/v1/ruc/".$DNI."?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJlbWFpbCI6InNvdWxhbGRvMTk5MUBnbWFpbC5jb20ifQ.U6zLssReUc4xj70hmUXnEHvzB4bpvAmZXIQwRryfnbc";

        $file_headers = @get_headers($url);

        //var_dump(file_get_contents($url));
        if(strpos($file_headers[0],"200 OK")==false){
            $resultado["rpt"] = false;
            $resultado["informacion"] = [];
            $resultado["estado"] = false;
        }else{
            $resultado["rpt"] = false;
            $resultado["informacion"] = json_decode(file_get_contents($url));
            $resultado["estado"] = true;  
        }
        return $resultado;
    }

    public function consultarDNI($DNI){
        $url = "https://dniruc.apisperu.com/api/v1/dni/".$DNI."?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJlbWFpbCI6InNvdWxhbGRvMTk5MUBnbWFpbC5jb20ifQ.U6zLssReUc4xj70hmUXnEHvzB4bpvAmZXIQwRryfnbc";

        $file_headers = @get_headers($url);

        //var_dump(file_get_contents($url));
        if(strpos($file_headers[0],"200 OK")==false){
            $resultado["rpt"] = false;
            $resultado["informacion"] = [];
            $resultado["estado"] = false;
        }else{
            $resultado["rpt"] = false;
            $resultado["informacion"] = json_decode(file_get_contents($url));
            $resultado["estado"] = true;  
        }
        return $resultado;
    }

}