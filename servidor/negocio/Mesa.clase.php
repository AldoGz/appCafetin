<?php

require_once '../acceso/Conexion.clase.php';

class Mesa extends Conexion {
    private $id;
    private $numero;
    private $estado;
    private $estado_convercional;
    private $disponibilidad;

    public function getId(){
        return $this->id;
    }
    
    public function setId($id){
        $this->id = $id;
        return $this;
    }

    public function getNumero(){
        return $this->numero;
    }
    
    public function setNumero($numero){
        $this->numero = $numero;
        return $this;
    }

    public function getEstado(){
        return $this->estado;
    }
    
    public function setEstado($estado){
        $this->estado = $estado;
        return $this;
    }

    public function getEstado_convercional(){
        return $this->estado_convercional;
    }
    
    public function setEstado_convercional($estado_convercional){
        $this->estado_convercional = $estado_convercional;
        return $this;
    }

    public function getDisponibilidad(){
        return $this->disponibilidad;
    }
    
    public function setDisponibilidad($disponibilidad){
        $this->disponibilidad = $disponibilidad;
        return $this;
    }

    public function agregar() {
        $this->beginTransaction();
        try {   
            $sql = "SELECT COUNT(*) as numero FROM mesa WHERE numero = :0";
            $contar = intval($this->consultarValor($sql,[$this->getNumero()]));

            if ( $contar > 0 ) {
                return array("rpt"=>true,"estado"=>false,"msj"=>"Ya existe número de mesa");
            }

            $campos_valores = ["numero"=>$this->getNumero()]; 
            $this->insert("mesa", $campos_valores);
            $this->commit();
            return array("rpt"=>true,"estado"=>true,"msj"=>"Se agregado exitosamente");
           
        } catch (Exception $exc) {
            return array("rpt"=>false,"msj"=>$exc);
            $this->rollBack();
            throw $exc;
        }
    }

    public function editar() {
        $this->beginTransaction();
        try { 
            $sql = "SELECT COUNT(*) as numero FROM mesa WHERE numero = :0";
            $contar = intval($this->consultarValor($sql,[$this->getNumero()]));


            if ( $contar > 0 ) {
                return array("rpt"=>true,"estado"=>false,"msj"=>"Ya existe número de mesa");
            }
                $campos_valores = ["numero"=>$this->getNumero()]; 
                $campos_valores_where = ["id"=>$this->getId()];
                $this->update("mesa", $campos_valores,$campos_valores_where);
                $this->commit();
                return array("rpt"=>true,"estado"=>true,"msj"=>"Se actualizado exitosamente");
        



        } catch (Exception $exc) {
            return array("rpt"=>false,"msj"=>$exc);
            $this->rollBack();
            throw $exc;
        }
    }

    public function listar() {
        try {
            $sql = "SELECT * FROM mesa WHERE estado = :0";
            $resultado = $this->consultarFilas($sql,[$this->getEstado()]);
            return array("rpt"=>true,"msj"=>$resultado);
        } catch (Exception $exc) {
            return array("rpt"=>false,"msj"=>$exc);
            throw $exc;
        }
    }

    public function leerDatos() {
        try {
            $sql = "SELECT * FROM mesa WHERE id =:0";
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
            $this->update("mesa", $campos_valores,$campos_valores_where);
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
            $sql = "SELECT 
                        me.*,
                        (SELECT COUNT(*) FROM pedido pe INNER JOIN toma_pedido tp ON tp.id_pedido = pe.id WHERE pe.id_mesa = me.id AND pe.estado = 1 AND tp.estado = 1) as espera,
                        (SELECT COUNT(*) FROM pedido pe INNER JOIN toma_pedido tp ON tp.id_pedido = pe.id WHERE pe.id_mesa = me.id AND pe.estado = 1 AND tp.estado = 2) as preparado,
                        (SELECT COUNT(*) FROM pedido pe INNER JOIN toma_pedido tp ON tp.id_pedido = pe.id WHERE pe.id_mesa = me.id AND pe.estado = 1 AND tp.estado = 3) as recogido
                        
                    FROM mesa me
                    WHERE me.estado = 1";
            $resultado = $this->consultarFilas($sql);
            return array("rpt"=>true,"msj"=>$resultado);
        } catch (Exception $exc) {
            return array("rpt"=>false,"msj"=>$exc);
            throw $exc;
        }
    }

    public function llenarCBP() {
        try {
            $sql = "SELECT 
                        me.*,
                        (
                            SELECT 
                                COUNT(*) 
                            FROM toma_pedido tp
                            INNER JOIN pedido pe ON pe.id = tp.id_pedido
                            WHERE tp.estado = 2 AND pe.estado = 1 AND pe.id_mesa = me.id
                        ) as realizado
                    FROM mesa me
                    WHERE me.estado = 1";
            $resultado = $this->consultarFilas($sql);
            return array("rpt"=>true,"msj"=>$resultado);
        } catch (Exception $exc) {
            return array("rpt"=>false,"msj"=>$exc);
            throw $exc;
        }
    }   

    public function cambiarEstado(){
        $this->beginTransaction();
        try { 
            $campos_valores = ["estado_convercional"=>$this->getEstado_convercional()]; 
            $campos_valores_where = ["numero"=>$this->getNumero()];
            $this->update("mesa", $campos_valores,$campos_valores_where);
            $this->commit();
            return array("rpt"=>true,"msj"=>"Se actualizado exitosamente");
        } catch (Exception $exc) {
            return array("rpt"=>false,"msj"=>$exc);
            $this->rollBack();
            throw $exc;
        }
    }

    public function cambiarDisponibilidad(){
        $this->beginTransaction();
        try { 
            $campos_valores = ["disponibilidad"=>$this->getDisponibilidad()]; 
            $campos_valores_where = ["id"=>$this->getId()];
            $this->update("mesa", $campos_valores,$campos_valores_where);
            $this->commit();
            return array("rpt"=>true,"msj"=>"Se actualizado exitosamente");
        } catch (Exception $exc) {
            return array("rpt"=>false,"msj"=>$exc);
            $this->rollBack();
            throw $exc;
        }
    }





    
}