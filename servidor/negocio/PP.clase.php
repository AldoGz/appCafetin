<?php

require_once '../acceso/Conexion.clase.php';

class PP extends Conexion {
    private $id;
    private $id_producto;
    private $cantidad_puntos;
    private $cantidad_producto;
    private $estado;

    public function getId(){
        return $this->id;
    }
    
    public function setId($id){
        $this->id = $id;
        return $this;
    }

    public function getId_producto(){
        return $this->id_producto;
    }
    
    public function setId_producto($id_producto){
        $this->id_producto = $id_producto;
        return $this;
    }

    public function getCantidad_puntos(){
        return $this->cantidad_puntos;
    }
    
    public function setCantidad_puntos($cantidad_puntos){
        $this->cantidad_puntos = $cantidad_puntos;
        return $this;
    }

    public function getCantidad_producto(){
        return $this->cantidad_producto;
    }
    
    public function setCantidad_producto($cantidad_producto){
        $this->cantidad_producto = $cantidad_producto;
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
                "id_producto"=>$this->getId_producto(),
                "cantidad_puntos"=>$this->getCantidad_puntos(),
                "cantidad_producto"=>$this->getCantidad_producto(),
            ]; 
            $this->insert("promocion_puntos", $campos_valores);
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
                "id_producto"=>$this->getId_producto(),
                "cantidad_puntos"=>$this->getCantidad_puntos(),
                "cantidad_producto"=>$this->getCantidad_producto(),
            ]; 
            $campos_valores_where = ["id"=>$this->getId()];
            $this->update("promocion_puntos", $campos_valores,$campos_valores_where);
            $this->commit();
            return array("rpt"=>true,"msj"=>"Se actualizado exitosamente");
        } catch (Exception $exc) {
            return array("rpt"=>false,"msj"=>$exc);
            $this->rollBack();
            throw $exc;
        }
    }



    public function leerDatos() {
        try {
            $sql = "SELECT 
                        pp.*,
                        pro.nombre,
                        pro.precio 
                    FROM promocion_puntos pp
                    INNER JOIN producto pro ON pro.id = pp.id_producto
                    WHERE pp.id = :0";
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
            $this->update("promocion_puntos", $campos_valores,$campos_valores_where);
            $this->commit();
            return array("rpt"=>true,"msj"=>$texto);
        } catch (Exception $exc) {
            return array("rpt"=>false,"msj"=>$exc);
            $this->rollBack();
            throw $exc;
        }
    }

    public function listado() {
        try {
            $sql = "SELECT 
                    pp.id,
                    pro.nombre as producto,
                    pp.cantidad_puntos,
                    pp.cantidad_producto,
                    pp.estado 
                    FROM promocion_puntos pp
                    INNER JOIN producto pro ON pro.id = pp.id_producto
                    WHERE pp.estado = :0";
            $resultado = $this->consultarFilas($sql,[$this->getEstado()]);
            return array("rpt"=>true,"msj"=>$resultado);
        } catch (Exception $exc) {
            return array("rpt"=>false,"msj"=>$exc);
            throw $exc;
        }
    }

    public function listar() {
        try {
            $sql = "SELECT 
                    pp.id,
                    pro.nombre as producto,
                    pp.cantidad_puntos,
                    pp.cantidad_producto 
                    FROM promocion_puntos pp
                    INNER JOIN producto pro ON pro.id = pp.id_producto
                    WHERE pro.estado = 1";
            $resultado = $this->consultarFilas($sql);
            return array("rpt"=>true,"msj"=>$resultado);
        } catch (Exception $exc) {
            return array("rpt"=>false,"msj"=>$exc);
            throw $exc;
        }
    } 

    public function consultarPP($documento) {
        try {
            $sql = "SELECT 
                    documento, 
                    razon_social, 
                    SUM(puntos) as puntos 
                    FROM facturacion 
                    WHERE documento = :0 AND estado_puntos = 1
                    GROUP BY documento";
            $resultado = $this->consultarFila($sql,[$documento]);
            return array("rpt"=>true,"msj"=>$resultado);
        } catch (Exception $exc) {
            return array("rpt"=>false,"msj"=>$exc);
            throw $exc;
        }
    }

   
}