<?php

require_once '../acceso/Conexion.clase.php';

class Comprobante extends Conexion {
    private $id;
    private $id_pedido;
    private $id_tipo_comprobante;
    private $numero;
    private $correlativo;


    public function getId(){
        return $this->id;
    }
    
    public function setId($id){
        $this->id = $id;
        return $this;
    }

    public function getId_pedido(){
        return $this->id_pedido;
    }
    
    public function setId_pedido($id_pedido){
        $this->id_pedido = $id_pedido;
        return $this;
    }

    public function getId_tipo_comprobante(){
        return $this->id_tipo_comprobante;
    }
    
    public function setId_tipo_comprobante($id_tipo_comprobante){
        $this->id_tipo_comprobante = $id_tipo_comprobante;
        return $this;
    }

    public function getNumero(){
        return $this->numero;
    }
    
    public function setNumero($numero){
        $this->numero = $numero;
        return $this;
    }

    public function getCorrelativo(){
        return $this->correlativo;
    }
    
    public function setCorrelativo($correlativo){
        $this->correlativo = $correlativo;
        return $this;
    }

    public function listarTC() {
        try {
            $sql = "SELECT * FROM tipo_comprobante";
            $resultado = $this->consultarFilas($sql);
            return array("rpt"=>true,"msj"=>$resultado);
        } catch (Exception $exc) {
            return array("rpt"=>false,"msj"=>$exc);
            throw $exc;
        }
    }

    public function listarSC() {
        try {
            $sql = "SELECT 
                        id_tipo_comprobante,
                        CONCAT(REPEAT('0', 3-LENGTH(numero)), numero) as numero,
                        CONCAT(REPEAT('0', 7-LENGTH(correlativo)), correlativo) as correlativo
                    FROM serie_comprobante  WHERE id_tipo_comprobante = :0";
            $resultado = $this->consultarFilas($sql,[$this->getId_tipo_comprobante()]);
            return array("rpt"=>true,"msj"=>$resultado);
        } catch (Exception $exc) {
            return array("rpt"=>false,"msj"=>$exc);
            throw $exc;
        }
    }

    public function viewCorrelativo() {
        try {
            $sql = "SELECT 
                        id_tipo_comprobante,
                        CONCAT(REPEAT('0', 3-LENGTH(numero)), numero) as numero,
                        CONCAT(REPEAT('0', 7-LENGTH(correlativo)), correlativo) as correlativo
                    FROM serie_comprobante
                    WHERE id_tipo_comprobante = :0 AND numero = :1";
            $resultado = $this->consultarFila($sql,[$this->getId_tipo_comprobante(), $this->getNumero()]);
            return array("rpt"=>true,"msj"=>$resultado);
        } catch (Exception $exc) {
            return array("rpt"=>false,"msj"=>$exc);
            throw $exc;
        }
    }

    public function llenarCB() {
        try {
            $sql = "SELECT * FROM tipo_comprobante";
            $resultado = $this->consultarFilas($sql);
            return array("rpt"=>true,"msj"=>$resultado);
        } catch (Exception $exc) {
            return array("rpt"=>false,"msj"=>$exc);
            throw $exc;
        }
    }



    /*

    public function agregar() {
        $this->beginTransaction();
        try {            
            $campos_valores = [
                "descripcion"=>strtoupper($this->getDescripcion()),
                "id_tipo_servicio"=>$this->getId_tipo_servicio()
            ]; 
            $this->insert("categoria", $campos_valores);
            $this->commit();
            return array("rpt"=>true,"msj"=>"Se agregado exitosamente");
        } catch (Exception $exc) {
            return array("rpt"=>false,"msj"=>$exc);
            $this->rollBack();
            throw $exc;
        }
    }

    public function editar() {
        $this->beginTransaction();
        try { 
            $campos_valores = [
                "descripcion"=>strtoupper($this->getDescripcion()),
                "id_tipo_servicio"=>$this->getId_tipo_servicio()
            ];
            $campos_valores_where = ["id"=>$this->getId()];
            $this->update("categoria", $campos_valores,$campos_valores_where);
            $this->commit();
            return array("rpt"=>true,"msj"=>"Se actualizado exitosamente");
        } catch (Exception $exc) {
            return array("rpt"=>false,"msj"=>$exc);
            $this->rollBack();
            throw $exc;
        }
    }

    public function listar() {
        try {
            $sql = "SELECT * FROM categoria WHERE estado = :0";
            $resultado = $this->consultarFilas($sql,[$this->getEstado()]);
            return array("rpt"=>true,"msj"=>$resultado);
        } catch (Exception $exc) {
            return array("rpt"=>false,"msj"=>$exc);
            throw $exc;
        }
    }

    public function leerDatos() {
        try {
            $sql = "SELECT * FROM categoria WHERE id =:0";
            $resultado = $this->consultarFila($sql,[$this->getId()]);
            return array("rpt"=>true,"msj"=>$resultado);
        } catch (Exception $exc) {
            return array("rpt"=>false,"msj"=>$exc);
            throw $exc;
        }
    }

    public function darBaja() {
        $this->beginTransaction();
        try {
            $texto = $this->getEstado() != '1' ? 'Se inactivado existosamente' : 'Se activado existosamente';            
            $campos_valores = ["estado"=>$this->getEstado()];
            $campos_valores_where = ["id"=>$this->getId()];
            $this->update("categoria", $campos_valores,$campos_valores_where);
            $this->commit();
            return array("rpt"=>true,"msj"=>$texto);
        } catch (Exception $exc) {
            return array("rpt"=>false,"msj"=>$exc);
            $this->rollBack();
            throw $exc;
        }
    }

    public function llenarCB() {
        try {
            $sql = "SELECT * FROM tipo_servicio WHERE estado = 1";
            $resultado = $this->consultarFilas($sql);
            return array("rpt"=>true,"msj"=>$resultado);
        } catch (Exception $exc) {
            return array("rpt"=>false,"msj"=>$exc);
            throw $exc;
        }
    }


*/
}