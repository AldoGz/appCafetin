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
                    FROM facturacion WHERE documento = :0 AND estado_puntos = 1";          
            $resultado["puntos"] = $this->consultarFila($sql,[$this->getDocumento()]);
            return array("rpt"=>true,"msj"=>$resultado);
        } catch (Exception $exc) {
            return array("rpt"=>false,"msj"=>$exc);
            throw $exc;
        }
    }

    public function consultarRUC($RUC){
        $ruta = "http://vapingshopperu.com/vista/template/sc/index.php?documento=".$RUC;
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, $ruta);
        curl_setopt(
            $ch, CURLOPT_HTTPHEADER, array(
            'Content-Type: application/json',
            )
        );
        curl_setopt($ch, CURLOPT_POST, 1);
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);    
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        $respuesta  = curl_exec($ch);
        $json = json_decode($respuesta);
        curl_close($ch);        
        if ( empty($json->result) ){
            $resultado["informacion"] = [];
            $resultado["rpt"] = false;
            $resultado["estado"] = true;
        }else{
            $resultado["informacion"] = $json->result;
            $resultado["rpt"] = true;
            $resultado["estado"] = true;
        }
        return $resultado;
    }

    public function consultarDNI($DNI){
        $url = "http://clientes.reniec.gob.pe/padronElectoral2012/consulta.htm?hTipo=2&hDni=".$DNI;

        $file_headers = @get_headers($url);
        if(strpos($file_headers[0],"200 OK")==false){
            $resultado["rpt"] = false;
            $resultado["informacion"] = [];
            $resultado["estado"] = false;
        }else{
            $buffer = explode('<td>', file_get_contents($url));
            $arreglo = [];

            foreach($buffer as $valor){
                $temp = explode('</td>', $valor);
                array_push($arreglo, $temp);
            }

            if ( empty($arreglo[2])) {
                $resultado["rpt"] = false;
                $resultado["informacion"] = [];
                $resultado["estado"] = true;
            }else{
                $resultado["rpt"] = true;
                $nombres = explode(", ", trim($arreglo[2][1]));
                $apellidos = explode(" ", $nombres[0]);
                $informacion = [
                    "dni" => explode(">",trim($arreglo[2][3]))[1],
                    "razon_social" => explode(">",$nombres[0])[1]." ".$nombres[1],
                    "nombres" => $nombres[1],
                    "paterno" => explode(">",$apellidos[2])[1],
                    "materno" => $apellidos[3],
                    "domicilio_fiscal" => explode(">",trim($arreglo[2][11]))[1]."/".explode(">",trim($arreglo[2][9]))[1]."/".explode(">",trim($arreglo[2][7]))[1],
                    "distrito" => explode(">",trim($arreglo[2][7]))[1],
                    "provincia" => explode(">",trim($arreglo[2][9]))[1],
                    "departamento" => explode(">",trim($arreglo[2][11]))[1]
                ];
                $resultado["informacion"] = $informacion;
                $resultado["estado"] = true;
            }       
        }
        return $resultado;
    }

}