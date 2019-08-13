<?php

require_once '../acceso/Conexion.clase.php';

class TomaPedido extends Conexion {
    private $id_pedido;
    private $id_producto;
    private $estado;

    public function getId_pedido(){
        return $this->id_pedido;
    }
    
    public function setId_pedido($id_pedido){
        $this->id_pedido = $id_pedido;
        return $this;
    }

    public function getId_producto(){
        return $this->id_producto;
    }
    
    public function setId_producto($id_producto){
        $this->id_producto = $id_producto;
        return $this;
    }

    public function getEstado(){
        return $this->estado;
    }
    
    public function setEstado($estado){
        $this->estado = $estado;
        return $this;
    }

    public function eliminar() {
        $this->beginTransaction();
        try {            
            $campos_valores = ["id_pedido"=>$this->getId_pedido(),"id_producto"=>$this->getId_producto()]; 
            $this->delete("toma_pedido", $campos_valores);
            $this->commit();
            return array("rpt"=>true,"msj"=>"Se ha eliminado correctamente");
        } catch (Exception $exc) {
            return array("rpt"=>false,"msj"=>$exc);
            $this->rollBack();
            throw $exc;
        }
    }

    public function entregar() {
        $this->beginTransaction();
        try { 
            $campos_valores = ["estado"=>1];
            $campos_valores_where = ["id_pedido"=>$this->getId_pedido(),"id_producto"=>$this->getId_producto()]; 
            $this->update("toma_pedido", $campos_valores,$campos_valores_where);
            $this->commit();
            return array("rpt"=>true,"msj"=>"Se actualizado exitosamente");
        } catch (Exception $exc) {
            return array("rpt"=>false,"msj"=>$exc);
            $this->rollBack();
            throw $exc;
        }
    }

}