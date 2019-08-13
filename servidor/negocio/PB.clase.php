<?php

require_once '../acceso/Conexion.clase.php';

class PB extends Conexion {
    private $id;
    private $ticket;
    private $nombre;
    private $fecha_inicio;
    private $fecha_fin;
    private $porcentaje;
    private $estado;

    public function getId(){
        return $this->id;
    }
    
    public function setId($id){
        $this->id = $id;
        return $this;
    }

    public function getTicket(){
        return $this->ticket;
    }
    
    public function setTicket($ticket){
        $this->ticket = $ticket;
        return $this;
    }

    public function getNombre(){
        return $this->nombre;
    }
    
    public function setNombre($nombre){
        $this->nombre = $nombre;
        return $this;
    }

    public function getFecha_inicio(){
        return $this->fecha_inicio;
    }
    
    public function setFecha_inicio($fecha_inicio){
        $this->fecha_inicio = $fecha_inicio;
        return $this;
    }

    public function getFecha_fin(){
        return $this->fecha_fin;
    }
    
    public function setFecha_fin($fecha_fin){
        $this->fecha_fin = $fecha_fin;
        return $this;
    }

    public function getPorcentaje(){
        return $this->porcentaje;
    }
    
    public function setPorcentaje($porcentaje){
        $this->porcentaje = $porcentaje;
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
                "ticket"=>$this->getTicket(),
                "nombre"=>$this->getNombre(),
                "fecha_inicio"=>$this->getFecha_inicio(),
                "fecha_fin"=>$this->getFecha_fin(),
                "porcentaje"=>$this->getPorcentaje(),
            ]; 
            $this->insert("promocion_bonus", $campos_valores);
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
                "ticket"=>$this->getTicket(),
                "nombre"=>$this->getNombre(),
                "fecha_inicio"=>$this->getFecha_inicio(),
                "fecha_fin"=>$this->getFecha_fin(),
                "porcentaje"=>$this->getPorcentaje(),
            ];  
            $campos_valores_where = ["id"=>$this->getId()];
            $this->update("promocion_bonus", $campos_valores,$campos_valores_where);
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
            $sql = "SELECT * FROM promocion_bonus WHERE id =:0";
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
            $this->update("promocion_bonus", $campos_valores,$campos_valores_where);
            $this->commit();
            return array("rpt"=>true,"msj"=>$texto);
        } catch (Exception $exc) {
            return array("rpt"=>false,"msj"=>$exc);
            $this->rollBack();
            throw $exc;
        }
    }

    public function listar() {
        try {
            $sql = "SELECT
                    id,
                    ticket,
                    nombre,
                    DATE_FORMAT(fecha_inicio, '%d/%m/%Y') as fecha_inicio,
                    DATE_FORMAT(fecha_fin, '%d/%m/%Y') as fecha_fin,
                    porcentaje,
                    estado
                    FROM promocion_bonus WHERE estado = :0";
            $resultado = $this->consultarFilas($sql,[$this->getEstado()]);
            return array("rpt"=>true,"msj"=>$resultado);
        } catch (Exception $exc) {
            return array("rpt"=>false,"msj"=>$exc);
            throw $exc;
        }
    }

    public function buscarTicket() {
        try {
            $sql = "SELECT * FROM promocion_bonus WHERE ticket = :0 AND fecha_fin >= (SELECT CURRENT_DATE) AND fecha_inicio<= (SELECT CURRENT_DATE)";
            $resultado = $this->consultarFila($sql,[$this->getTicket()]);
            return array("rpt"=>true,"msj"=>$resultado);
        } catch (Exception $exc) {
            return array("rpt"=>false,"msj"=>$exc);
            throw $exc;
        }
    }

   
}