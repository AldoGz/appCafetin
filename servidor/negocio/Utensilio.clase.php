<?php

require_once '../acceso/Conexion.clase.php';

class Utensilio extends Conexion {
    private $id;
    private $id_producto;
    private $nombre;
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

    public function getNombre(){
        return $this->nombre;
    }
    
    public function setNombre($nombre){
        $this->nombre = $nombre;
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
                "nombre"=>strtoupper($this->getNombre())
            ]; 
            $this->insert("utensilio", $campos_valores);
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
                "nombre"=>strtoupper($this->getNombre())
            ];
            $campos_valores_where = ["id"=>$this->getId()];
            $this->update("utensilio", $campos_valores,$campos_valores_where);
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
            $sql = "SELECT * FROM utensilio WHERE estado = :0";
            $resultado = $this->consultarFilas($sql,[$this->getEstado()]);
            return array("rpt"=>true,"msj"=>$resultado);
        } catch (Exception $exc) {
            return array("rpt"=>false,"msj"=>$exc);
            throw $exc;
        }
    }

    public function leerDatos() {
        try {
            $sql = "SELECT * FROM utensilio WHERE id =:0";
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
            $this->update("utensilio", $campos_valores,$campos_valores_where);
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
            $sql = "SELECT * FROM utensilio WHERE estado = 1 AND id_producto = :0";
            $resultado = $this->consultarFilas($sql,[$this->getId_producto()]);
            return array("rpt"=>true,"msj"=>$resultado);
        } catch (Exception $exc) {
            return array("rpt"=>false,"msj"=>$exc);
            throw $exc;
        }
    }


    /*TOMA PEDIDO*/
    public function listarUtensilioProducto() {
        try {
            $sql = "SELECT 
                        u.id, 
                        u.nombre, 
                        u.estado
                    FROM utensilio u 
                    INNER JOIN utensilio_producto up ON up.id_utensilio = u.id
                    WHERE up.id_producto = :0 AND u.estado = 1";
            $resultado = $this->consultarFilas($sql,[$this->getId_producto()]);
            return array("rpt"=>true,"msj"=>$resultado);
        } catch (Exception $exc) {
            return array("rpt"=>false,"msj"=>$exc);
            throw $exc;
        }
    }


    public function multiselectUtensilio($id_producto) {
        try {
            $sql = "SELECT * FROM utensilio WHERE estado = 1";
            $resultado["u"] = $this->consultarFilas($sql);

            $sql = "SELECT u.* FROM utensilio_producto ut 
                    INNER JOIN utensilio u ON u.id = ut.id_utensilio 
                    WHERE ut.id_producto = :0";
            $resultado["up"] = $this->consultarFilas($sql,[$id_producto]);
            return array("rpt"=>true,"msj"=>$resultado);
        } catch (Exception $exc) {
            return array("rpt"=>false,"msj"=>$exc);
            throw $exc;
        }
    }

    public function agregarUtensilioProducto($id_producto,$id_utensilio) {
        $this->beginTransaction();
        try { 
            $campos_valores = [
                "id_producto"=>$id_producto,
                "id_utensilio"=>$id_utensilio
            ];
            $this->insert("utensilio_producto", $campos_valores);
            $this->commit();
            return array("rpt"=>true,"msj"=>"Se agregado exitosamente");
        } catch (Exception $exc) {
            return array("rpt"=>false,"msj"=>$exc);
            $this->rollBack();
            throw $exc;
        }
    }

    public function quitarUtensilioProducto($id_producto,$id_utensilio) {
        $this->beginTransaction();
        try {             
            $campos_valores_where = [
                "id_producto"=>$id_producto,
                "id_utensilio"=>$id_utensilio
            ];
            $this->delete("utensilio_producto", $campos_valores_where);
            $this->commit();
            return array("rpt"=>true,"msj"=>"Se quitado exitosamente");
        } catch (Exception $exc) {
            return array("rpt"=>false,"msj"=>$exc);
            $this->rollBack();
            throw $exc;
        }
    }

}