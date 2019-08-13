<?php

require_once '../acceso/Conexion.clase.php';

class TipoServicio extends Conexion {
    private $id;

    public function getId(){
        return $this->id;
    }
    
    public function setId($id){
        $this->id = $id;
        return $this;
    }

/*   private $id;
    private $descripcion;
    private $estado;
    private $id_tipo_servicio;


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

    public function getEstado(){
        return $this->estado;
    }
    
    public function setEstado($estado){
        $this->estado = $estado;
        return $this;
    }

    public function getId_tipo_servicio(){
        return $this->id_tipo_servicio;
    }
    
    public function setId_tipo_servicio($id_tipo_servicio){
        $this->id_tipo_servicio = $id_tipo_servicio;
        return $this;
    }

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
*/
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



}