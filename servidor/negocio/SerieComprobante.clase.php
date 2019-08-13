<?php

require_once '../acceso/Conexion.clase.php';

class SerieComprobante extends Conexion {
    private $id;
    private $tipo_comprobante;
    private $numero;
    private $correlatio;
    private $estado;

    public function getId(){
        return $this->id;
    }
    
    public function setId($id){
        $this->id = $id;
        return $this;
    }
    public function getTipo_comprobante(){
        return $this->tipo_comprobante;
    }
    
    public function setTipo_comprobante($tipo_comprobante){
        $this->tipo_comprobante = $tipo_comprobante;
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

    public function getEstado(){
        return $this->estado;
    }
    
    public function setEstado($estado){
        $this->estado = $estado;
        return $this;
    }

    public function agregar() {
        $this->beginTransaction();
        try {            
            $campos_valores = [
                "id_tipo_comprobante"=>$this->getTipo_comprobante(),
                "numero"=>$this->getNumero()
            ]; 
            $this->insert("serie_comprobante", $campos_valores);
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
                "id_tipo_comprobante"=>$this->getTipo_comprobante(),
                "numero"=>$this->getNumero()
            ];             
            $campos_valores_where = ["id"=>$this->getId()];
            $this->update("serie_comprobante", $campos_valores,$campos_valores_where);
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
            $sql = "SELECT 
                    sc.id, 
                    tc.nombre as tipo_comprobante,
                    CONCAT(REPEAT('0', 3-LENGTH(sc.numero)), sc.numero) as numero,
                    CONCAT(REPEAT('0', 7-LENGTH(sc.correlativo)), sc.correlativo) as correlativo,
                    sc.estado
                    FROM serie_comprobante sc
                    INNER JOIN tipo_comprobante tc ON tc.id = sc.id_tipo_comprobante
                    WHERE sc.estado = :0";
            $resultado = $this->consultarFilas($sql,[$this->getEstado()]);
            return array("rpt"=>true,"msj"=>$resultado);
        } catch (Exception $exc) {
            return array("rpt"=>false,"msj"=>$exc);
            throw $exc;
        }
    }

    public function leerDatos() {
        try {
            $sql = "SELECT * FROM serie_comprobante WHERE id =:0";
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
            $this->update("serie_comprobante", $campos_valores,$campos_valores_where);
            $this->commit();
            return array("rpt"=>true,"msj"=>$texto);
        } catch (Exception $exc) {
            return array("rpt"=>false,"msj"=>$exc);
            $this->rollBack();
            throw $exc;
        }
    }

}