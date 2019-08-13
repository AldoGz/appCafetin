<?php

require_once '../acceso/Conexion.clase.php';

class Categoria extends Conexion {
    private $id;
    private $descripcion;
    private $estado;
    private $id_tipo_servicio;
    private $foto;


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

    public function getFoto(){
        return $this->foto;
    }
    
    public function setFoto($foto){
        $this->foto = $foto;
        return $this;
    }

    public function agregar() {
        $this->beginTransaction();
        try {            
            $campos_valores = [
                "nombre"=>strtoupper($this->getDescripcion()),
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
                "nombre"=>strtoupper($this->getDescripcion()),
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

    public function llenarCBM() {
        try {
            $sql = "SELECT * FROM categoria WHERE estado = 1";
            $resultado = $this->consultarFilas($sql);
            return array("rpt"=>true,"msj"=>$resultado);
        } catch (Exception $exc) {
            return array("rpt"=>false,"msj"=>$exc);
            throw $exc;
        }
    } 

    public function llenarCB() {
        try {
            $sql = "SELECT cat.* FROM categoria cat  
                    INNER JOIN producto pro ON pro.id_categoria = cat.id
                    WHERE cat.estado = 1 AND cat.id_tipo_servicio = :0
                    GROUP BY cat.id";
            $resultado = $this->consultarFilas($sql,[$this->getId_tipo_servicio()]);
            return array("rpt"=>true,"msj"=>$resultado);
        } catch (Exception $exc) {
            return array("rpt"=>false,"msj"=>$exc);
            throw $exc;
        }
    }

    public function correlativo(){
        try {
            $sql = "SELECT 
                        CONCAT('imgCat',CASE WHEN COUNT(*)=0 THEN 1 ELSE COUNT(*)+1 END,'.jpg') as foto
                    FROM categoria WHERE foto<>'defecto.jpg'";
            return $this->consultarValor($sql);            
        } catch (Exception $exc) {
            throw $exc;
        }
    }

}