<?php

require_once '../acceso/Conexion.clase.php';

class Turnos extends Conexion {
    private $id;
    private $descripcion;
    private $inicio;
    private $fin;
    private $estado;


    public function getId(){
        return $this->id;
    }
    
    public function setId($id){
        $this->id = $id;
        return $this;
    }

    public function getDescripcion(){
        return $this->descripcion;
    }
    
    public function setDescripcion($descripcion){
        $this->descripcion = $descripcion;
        return $this;
    }

    public function getInicio(){
        return $this->inicio;
    }
    
    public function setInicio($inicio){
        $this->inicio = $inicio;
        return $this;
    }

    public function getFinal(){
        return $this->final;
    }
    
    public function setFinal($final){
        $this->final = $final;
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
            $campos_valores = ["descripcion"=>strtoupper($this->getDescripcion())]; 
            $this->insert("turnos", $campos_valores);
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
            $campos_valores = ["descripcion"=>strtoupper($this->getDescripcion())];
            $campos_valores_where = ["id"=>$this->getId()];
            $this->update("turnos", $campos_valores,$campos_valores_where);
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
            $sql = "SELECT * FROM turnos WHERE estado = :0";
            $resultado = $this->consultarFilas($sql,[$this->getEstado()]);
            return array("rpt"=>true,"msj"=>$resultado);
        } catch (Exception $exc) {
            return array("rpt"=>false,"msj"=>$exc);
            throw $exc;
        }
    }

    public function leerDatos() {
        try {
            $sql = "SELECT * FROM turnos WHERE id =:0";
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
            $this->update("turnos", $campos_valores,$campos_valores_where);
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
            $sql = "SELECT * FROM turnos WHERE estado = 1";
            $resultado = $this->consultarFilas($sql);
            return array("rpt"=>true,"msj"=>$resultado);
        } catch (Exception $exc) {
            return array("rpt"=>false,"msj"=>$exc);
            throw $exc;
        }
    }
}