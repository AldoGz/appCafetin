<?php

require_once '../acceso/Conexion.clase.php';

class Producto extends Conexion {
    private $id;
    private $nombre;
    private $precio;
    private $id_categoria;
    private $estado;
    private $foto;
    private $descripcion;

    public function getId(){
        return $this->id;
    }
    
    public function setId($id){
        $this->id = $id;
        return $this;
    }

    public function getNombre(){
        return $this->nombre;
    }
    
    public function setNombre($nombre){
        $this->nombre = $nombre;
        return $this;
    }

    public function getPrecio(){
        return $this->precio;
    }
    
    public function setPrecio($precio){
        $this->precio = $precio;
        return $this;
    }

    public function getId_categoria(){
        return $this->id_categoria;
    }
    
    public function setId_categoria($id_categoria){
        $this->id_categoria = $id_categoria;
        return $this;
    }

    public function getEstado(){
        return $this->estado;
    }
    
    public function setEstado($estado){
        $this->estado = $estado;
        return $this;
    }

    public function getFoto(){
        return $this->foto;
    }
    
    public function setFoto($foto){
        $this->foto = $foto;
        return $this;
    }

    public function getDescripcion(){
        return $this->descripcion;
    }
    
    public function setDescripcion($descripcion){
        $this->descripcion = $descripcion;
        return $this;
    }

    public function agregar() {
        $this->beginTransaction();
        try {            
            $campos_valores = [
                "nombre"=>strtoupper($this->getNombre()),
                "precio"=>$this->getPrecio(),
                "id_categoria"=>$this->getId_categoria(),
                "foto"=>$this->getFoto(),
                "descripcion"=>$this->getDescripcion()
            ]; 
            $this->insert("producto", $campos_valores);
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
                "nombre"=>strtoupper($this->getNombre()), 
                "precio"=>$this->getPrecio(),
                "id_categoria"=>$this->getId_categoria(),
                "foto"=>$this->getFoto(),
                "descripcion"=>$this->getDescripcion()
            ]; 
            $campos_valores_where = ["id"=>$this->getId()];
            $this->update("producto", $campos_valores,$campos_valores_where);
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
            if ( $this->getId_categoria() == "*" ) {
                $sql = "SELECT * FROM producto WHERE estado = :0";
                $resultado = $this->consultarFilas($sql,[$this->getEstado()]);
            }else{
                $sql = "SELECT * FROM producto WHERE estado = :0 AND id_categoria = :1";
                $resultado = $this->consultarFilas($sql,[$this->getEstado(),$this->getId_categoria()]);
            }            
            return array("rpt"=>true,"msj"=>$resultado);
        } catch (Exception $exc) {
            return array("rpt"=>false,"msj"=>$exc);
            throw $exc;
        }
    }

    public function leerDatos() {
        try {
            $sql = "SELECT * FROM producto WHERE id =:0";
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
            $this->update("producto", $campos_valores,$campos_valores_where);
            $this->commit();
            return array("rpt"=>true,"msj"=>$texto);
        } catch (Exception $exc) {
            return array("rpt"=>false,"msj"=>$exc);
            $this->rollBack();
            throw $exc;
        }
    }


    public function correlativo(){
        try {
            $sql = "SELECT 
                        CONCAT('imgPro',CASE WHEN COUNT(*)=0 THEN 1 ELSE COUNT(*)+1 END,'.jpg') as foto
                    FROM producto WHERE foto<>'defecto.jpg'";
            return $this->consultarValor($sql);            
        } catch (Exception $exc) {
            throw $exc;
        }
    }

    public function llenarCBT() {
        try {
            $sql = "SELECT * FROM producto WHERE estado = 1";
            $resultado = $this->consultarFilas($sql);
            return array("rpt"=>true,"msj"=>$resultado);
        } catch (Exception $exc) {
            return array("rpt"=>false,"msj"=>$exc);
            throw $exc;
        }
    }


    public function llenarCB() {
        try {
            $sql = "SELECT * FROM producto WHERE estado = 1 AND id_categoria = :0";
            $resultado = $this->consultarFilas($sql,[$this->getId_categoria()]);
            return array("rpt"=>true,"msj"=>$resultado);
        } catch (Exception $exc) {
            return array("rpt"=>false,"msj"=>$exc);
            throw $exc;
        }
    }

    public function leerDatosProducto() {
        try {
            $sql = "SELECT * FROM producto WHERE estado = 1 AND id = :0";
            $resultado["producto"] = $this->consultarFila($sql,[$this->getId()]);

            $sql = "SELECT ut.* FROM utensilio_producto up 
                    INNER JOIN utensilio ut ON ut.id = up.id_utensilio
                    WHERE up.id_producto = :0 AND ut.estado = 1";
            $resultado["utensilios"] = $this->consultarFilas($sql,[$this->getId()]);




            return array("rpt"=>true,"msj"=>$resultado);
        } catch (Exception $exc) {
            return array("rpt"=>false,"msj"=>$exc);
            throw $exc;
        }
    }

    public function listarProductos($tipo) {
        try {
            $sql = "SELECT cat.* FROM producto pro 
                    INNER JOIN categoria cat ON cat.id = pro.id_categoria
                    WHERE cat.estado = 1 AND pro.estado = 1 AND cat.id_tipo_servicio = :0
                    GROUP BY cat.id";
            $resultado["categorias"] = $this->consultarFilas($sql,[$tipo]);

            $sql = "SELECT pro.* FROM producto pro 
                    INNER JOIN categoria cat ON cat.id = pro.id_categoria
                    WHERE cat.estado = 1 AND pro.estado = 1 AND cat.id_tipo_servicio = :0";
            $resultado["productos"] = $this->consultarFilas($sql,[$tipo]);

            return array("rpt"=>true,"msj"=>$resultado);
        } catch (Exception $exc) {
            return array("rpt"=>false,"msj"=>$exc);
            throw $exc;
        }
    }

    public function listarProductoCategoria($id_categoria){
        try {
            $sql = "SELECT * FROM producto WHERE id_categoria = :0 AND estado = 1";
            $resultado = $this->consultarFilas($sql,[$id_categoria]);
            return array("rpt"=>true,"msj"=>$resultado);
        } catch (Exception $exc) {
            return array("rpt"=>false,"msj"=>$exc);
            throw $exc;
        }
    }


    public function listarProductosObservaciones() {
        try {
            $sql = "SELECT * FROM producto WHERE id = :0";
            $resultado["producto"] = $this->consultarFila($sql,[$this->getId()]);

            $sql = "SELECT u.* FROM utensilio_producto up 
                    INNER JOIN utensilio u ON u.id = up.id_utensilio
                    WHERE up.id_producto = :0
                    ORDER BY 1";
            $resultado["utensilios"] = $this->consultarFilas($sql,[$this->getId()]);

            return array("rpt"=>true,"msj"=>$resultado);
        } catch (Exception $exc) {
            return array("rpt"=>false,"msj"=>$exc);
            throw $exc;
        }
    }





}