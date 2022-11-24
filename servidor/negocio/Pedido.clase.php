<?php

require_once '../acceso/Conexion.clase.php';
include_once 'util/GenerarTicket.php';


class Pedido extends Conexion {
    private $id;
    private $id_mesa;
    private $id_empleado;
    private $detalle;
    private $estado;
    private $nota;
    private $observaciones;

    public function getId(){
        return $this->id;
    }
    
    public function setId($id){
        $this->id = $id;
        return $this;
    }

    public function getId_mesa(){
        return $this->id_mesa;
    }
    
    public function setId_mesa($id_mesa){
        $this->id_mesa = $id_mesa;
        return $this;
    }

    public function getId_empleado(){
        return $this->id_empleado;
    }
    
    public function setId_empleado($id_empleado){
        $this->id_empleado = $id_empleado;
        return $this;
    }

    public function getDetalle(){
        return $this->detalle;
    }
    
    public function setDetalle($detalle){
        $this->detalle = $detalle;
        return $this;
    }

    public function getEstado(){
        return $this->estado;
    }
    
    public function setEstado($estado){
        $this->estado = $estado;
        return $this;
    }

    public function getNota(){
        return $this->nota;
    }
    
    public function setNota($nota){
        $this->nota = $nota;
        return $this;
    }

    public function getObservaciones(){
        return $this->observaciones;
    }
    
    public function setObservaciones($observaciones){
        $this->observaciones = $observaciones;
        return $this;
    }

    public function agregar($estado_convencional,$cliente,$observaciones) {
        session_name("CAFETIN");
        session_start();
        $this->beginTransaction();
        try {
            if ( intval($estado_convencional) === 1 ) {
                $campos_valores = [
                    "id_mesa"=>$this->getId_mesa(),
                    "id_empleado"=>$_SESSION["cod_usuario"],
                    "nombre_cliente"=>$cliente               
                ]; 
                $this->insert("pedido", $campos_valores);

                $campos_valores = ["estado_convencional"=>2]; 
                $campos_valores_where = ["id"=>$this->getId_mesa()];
                $this->update("mesa", $campos_valores,$campos_valores_where);
            }
            $sql = "SELECT MAX(id) FROM pedido WHERE id_mesa = :0 AND estado = 1";
            $id_pedido = intval($this->consultarValor($sql,[$this->getId_mesa()]));

            $toma_pedido = json_decode($this->getDetalle());
            $do = json_decode($observaciones);

            foreach ($toma_pedido as $item) {
                
                $campos_valores = [
                    "id_pedido" =>$id_pedido,                        
                    "id_producto"=>$item->id_producto,
                    "cantidad"=>$item->cantidad,
                    "precio"=>$item->precio,
                    "item"=>$item->item
                ];
                
                $this->insert("toma_pedido", $campos_valores); 

                $sql = "SELECT MAX(id) FROM toma_pedido WHERE id_pedido = :0";
                $id_toma_pedido = intval($this->consultarValor($sql,[$id_pedido]));

                foreach ($do as $item2) {
                    if ( ( intval($item->id_producto) == intval($item2->id_producto) ) && ( intval($item->item) == intval($item2->item)  ) ){
                        $campos_valores = [
                            "nota"=>$item2->nota,
                            "observaciones"=>$item2->observaciones
                        ];
                        $campos_valores_where = [
                            "id"=>$id_toma_pedido
                        ];
                        $this->update("toma_pedido", $campos_valores,$campos_valores_where); 
                    }
                }
            }

            $rpt = intval($estado_convencional) == 1 ? 2 : intval($estado_convencional);
            $this->commit();
            return array("rpt"=>true,"estado_convencional"=>$rpt,"msj"=>"Se agregado correctamente?");
        } catch (Exception $exc) {
            return array("rpt"=>false,"msj"=>$exc);
            $this->rollBack();
            throw $exc;
        }
    }

    public function listarPedidoMeseroEspera(){
        try {
            session_name("CAFETIN");
            session_start();
            $resultado["mesero"] = $_SESSION["cod_usuario"];

            $sql = "SELECT 
                    tp.id,
                    pro.nombre as producto,
                    tp.cantidad,
                    tp.precio,
                    tp.cantidad*tp.precio as importe,
                    tp.estado,
                    IF( tp.nota IS NULL, '',tp.nota) as nota,
                    tp.item
                    FROM toma_pedido tp 
                    INNER JOIN pedido pe ON pe.id = tp.id_pedido
                    INNER JOIN producto pro ON pro.id = tp.id_producto
                    WHERE pe.id_mesa = :0 AND tp.estado = 1 AND pe.estado = 1
                    ORDER BY 1";
            $resultado["pedidos"] = $this->consultarFilas($sql,[$this->getId_mesa()]);

            $sql = "SELECT 
                    SUM(tp.cantidad*tp.precio) as total 
                    FROM toma_pedido tp 
                    INNER JOIN pedido pe ON pe.id = tp.id_pedido 
                    WHERE pe.id_mesa = :0 AND pe.estado = 1 AND tp.estado = 1";
            $resultado["total"] = $this->consultarValor($sql,[$this->getId_mesa()]);
            return array("rpt"=>true,"msj"=>$resultado);
        } catch (Exception $exc) {
            return array("rpt"=>false,"msj"=>$exc);
            throw $exc;
        }
    } 

    public function listarPedidosCajero(){
        try {
            session_name("CAFETIN");
            session_start();
            $resultado["mesero"] = $_SESSION["cod_usuario"];

            $sql = "SELECT 
                    tp.id,
                    pro.nombre as producto,
                    tp.cantidad,
                    tp.precio,
                    tp.cantidad*tp.precio as importe,
                    tp.estado,
                    IF( tp.nota IS NULL, '',tp.nota) as nota,
                    tp.item
                    FROM toma_pedido tp 
                    INNER JOIN pedido pe ON pe.id = tp.id_pedido
                    INNER JOIN producto pro ON pro.id = tp.id_producto
                    WHERE pe.id_mesa = :0 AND pe.estado = 1
                    ORDER BY 1";
            $resultado["pedidos"] = $this->consultarFilas($sql,[$this->getId_mesa()]);

            $sql = "SELECT 
                    SUM(tp.cantidad*tp.precio) as total 
                    FROM toma_pedido tp 
                    INNER JOIN pedido pe ON pe.id = tp.id_pedido 
                    WHERE pe.id_mesa = :0 AND pe.estado = 1 AND tp.estado <> 4  AND tp.estado <> 6";
            $resultado["total"] = $this->consultarValor($sql,[$this->getId_mesa()]);
            return array("rpt"=>true,"msj"=>$resultado);
        } catch (Exception $exc) {
            return array("rpt"=>false,"msj"=>$exc);
            throw $exc;
        }
    } 

    public function listarPedidoMeseroEntrega(){
        try {
            $sql = "SELECT 
                    tp.id,
                    pro.nombre as producto,
                    tp.cantidad,
                    tp.precio,
                    tp.cantidad*tp.precio as importe,
                    tp.estado,
                    IF( tp.nota IS NULL, '',tp.nota) as nota, 
                    tp.item
                    FROM toma_pedido tp 
                    INNER JOIN pedido pe ON pe.id = tp.id_pedido
                    INNER JOIN producto pro ON pro.id = tp.id_producto
                    WHERE pe.id_mesa = :0 AND tp.estado in(1,2) AND pe.estado = 1
                    ORDER BY 1";
            $resultado["pedidos"] = $this->consultarFilas($sql,[$this->getId_mesa()]);

            $sql = "SELECT 
                    IF(SUM(tp.cantidad*tp.precio) IS NULL, '0.00',SUM(tp.cantidad*tp.precio)) as total
                    FROM toma_pedido tp 
                    INNER JOIN pedido pe ON pe.id = tp.id_pedido 
                    WHERE pe.id_mesa = :0 AND pe.estado = 1 AND tp.estado = 2";
            $resultado["total"] = $this->consultarValor($sql,[$this->getId_mesa()]);
            return array("rpt"=>true,"msj"=>$resultado);
        } catch (Exception $exc) {
            return array("rpt"=>false,"msj"=>$exc);
            throw $exc;
        }
    }

    public function leerDatos(){
        try {
            $sql = "SELECT * FROM toma_pedido WHERE id=:0";
            $resultado = $this->consultarFila($sql,[$this->getId()]);
            return array("rpt"=>true,"msj"=>$resultado);
        } catch (Exception $exc) {
            return array("rpt"=>false,"msj"=>$exc);
            throw $exc;
        }
    } 

    public function editar($cantidad,$observaciones) {
        $this->beginTransaction();
        try {
            $campos_valores = [
                "cantidad"=>$cantidad,
                "observaciones"=>$observaciones
            ]; 
            $campos_valores_where = ["id"=>$this->getId()];
            $this->update("toma_pedido", $campos_valores,$campos_valores_where);
            $this->commit();
            return array("rpt"=>true,"msj"=>"Se actualizado correctamente?");
        } catch (Exception $exc) {
            return array("rpt"=>false,"msj"=>$exc);
            $this->rollBack();
            throw $exc;
        }
    }

    public function entregaPedido() {
        $this->beginTransaction();
        try {
            $sql = "SELECT tp.id FROM toma_pedido tp
                    INNER JOIN pedido pe ON pe.id = tp.id_pedido
                    WHERE pe.id_mesa = :0 AND pe.estado = 1 AND tp.estado = 2";
            $toma_pedido = $this->consultarFilas($sql,[$this->getId_mesa()]);

            for ($i=0; $i < count($toma_pedido) ; $i++) {
                $item = $toma_pedido[$i];
                $campos_valores = [
                    "estado"=>3
                ]; 
                $campos_valores_where = ["id"=>$item["id"]];
                $this->update("toma_pedido", $campos_valores,$campos_valores_where);    
            }
            $this->commit();
            return array("rpt"=>true,"msj"=>"Se entregado correctamente?");
        } catch (Exception $exc) {
            return array("rpt"=>false,"msj"=>$exc);
            $this->rollBack();
            throw $exc;
        }
    }

    public function entregaPedidoUnitario() {
        $this->beginTransaction();
        try {
            $campos_valores = [
                "estado"=>3
            ]; 
            $campos_valores_where = ["id"=>$this->getId()];
            $this->update("toma_pedido", $campos_valores,$campos_valores_where);
            $this->commit();
            return array("rpt"=>true,"msj"=>"Se entregado correctamente?");
        } catch (Exception $exc) {
            return array("rpt"=>false,"msj"=>$exc);
            $this->rollBack();
            throw $exc;
        }
    }

    public function listarMesasEnEspera($tipo){
        try {
           

            $sql = "SELECT 
                        tp.id,
                        me.id as id_mesa,
                        me.numero as mesa,
                        CONCAT(em.nombres,' ',em.apellido_paterno) as empleado,
                        tp.fecha_registro
                    FROM toma_pedido tp
                    INNER JOIN producto pro ON pro.id = tp.id_producto
                    INNER JOIN categoria cat ON cat.id = pro.id_categoria
                    INNER JOIN pedido pe ON pe.id = tp.id_pedido
                    INNER JOIN empleado em ON em.id = pe.id_empleado
                    INNER JOIN mesa me ON me.id = pe.id_mesa
                    WHERE cat.id_tipo_servicio = :0  AND pe.estado = 1 AND tp.estado = 1 AND tp.item = 0
                    GROUP BY me.id,tp.id
                    ORDER BY 1";
            $resultado["tabla"] = $this->consultarFilas($sql,[$tipo]);
            /* $resultado["detalle"] = [];
            $resultado["tabla2"] = [];
            $resultado["detalle2"] = [];
            $resultado["resumen"] = [];
            $resultado["timbre"] = null; */

            $sql = "SELECT 
                        tp.id,
                        pe.id_mesa,
                        pro.nombre as producto,
                        SUM(tp.cantidad) as cantidad,
                        tp.precio,
                        IF(tp.nota = '' AND tp.observaciones = '',
                           'NINGUNO',
                           IF(tp.nota = '' AND tp.observaciones<>'',
                                tp.observaciones,
                                IF(tp.nota<>'' AND tp.observaciones = '',
                                    tp.nota,
                                    CONCAT(tp.nota,' - ',tp.observaciones)
                                  )
                             )
                        ) as nota,
                        tp.estado
                    FROM toma_pedido tp
                    INNER JOIN producto pro ON pro.id = tp.id_producto
                    INNER JOIN categoria cat ON cat.id = pro.id_categoria
                    INNER JOIN pedido pe ON pe.id = tp.id_pedido
                    INNER JOIN empleado em ON em.id = pe.id_empleado
                    INNER JOIN mesa me ON me.id = pe.id_mesa
                    WHERE cat.id_tipo_servicio = :0 AND pe.estado = 1 AND tp.estado = 1 AND tp.item = 0
                    GROUP BY me.id,tp.id,pro.nombre,tp.nota,tp.observaciones";
            $resultado["detalle"] = $this->consultarFilas($sql,[$tipo]);

            $array = [];

            $sql = "SELECT 
                        pe.id,
                        me.id as id_mesa,
                        me.numero as mesa,
                        CONCAT(em.nombres,' ',em.apellido_paterno) as empleado,
                        pe.fecha_registro
                    FROM pedido pe 
                    INNER JOIN empleado em ON pe.id_empleado = em.id
                    INNER JOIN mesa me ON pe.id_mesa = me.id 
                    INNER JOIN toma_pedido tp ON pe.id = tp.id_pedido
                    INNER JOIN producto pro ON tp.id_producto = pro.id 
                    INNER JOIN categoria cat ON pro.id_categoria = cat.id
                    WHERE pe.estado = 1 AND tp.estado = 1 AND cat.id_tipo_servicio = :0
                    GROUP BY pe.id
                    ORDER BY 1";
            $pedidos = $this->consultarFilas($sql,[$tipo]);

            foreach ($pedidos as $pedido) {
                $sql = "SELECT 
                        pe.id as id_pedido,
                        tp.id,
                        pe.id_mesa,
                        pro.nombre as producto,
                        tp.cantidad,
                        tp.precio,
                        IF(tp.nota IS NULL AND tp.observaciones IS NULL,
                        'NINGUNO',
                        IF(tp.nota IS NULL AND tp.observaciones IS NOT NULL,
                                tp.observaciones,
                                IF(tp.nota IS NOT NULL AND tp.observaciones IS NULL,
                                    tp.nota,
                                    CONCAT(tp.nota,' - ',tp.observaciones)
                                )
                            )
                        ) as nota,
                        tp.estado,                        
                        tp.item 
                    FROM pedido pe 
                    INNER JOIN toma_pedido tp ON pe.id = tp.id_pedido 
                    INNER JOIN producto pro ON tp.id_producto = pro.id
                    INNER JOIN categoria cat ON cat.id = pro.id_categoria
                    WHERE pe.estado = 1 AND tp.estado = 1 AND cat.id_tipo_servicio = :0 AND pe.id = :1";
                $detalles = $this->consultarFilas($sql,[$tipo,$pedido["id"]]);

                if( count($detalles) > 0 ){
                    $pedido["children"] = $detalles;
                }
                array_push($array,$pedido);
            }

            $resultado["test"] = $array;



            $sql = "SELECT 
                        tp.id,
                        me.id as id_mesa,
                        me.numero as mesa,
                        CONCAT(em.nombres,' ',em.apellido_paterno) as empleado,
                        tp.fecha_registro
                    FROM toma_pedido tp
                    INNER JOIN producto pro ON pro.id = tp.id_producto
                    INNER JOIN categoria cat ON cat.id = pro.id_categoria
                    INNER JOIN pedido pe ON pe.id = tp.id_pedido
                    INNER JOIN empleado em ON em.id = pe.id_empleado
                    INNER JOIN mesa me ON me.id = pe.id_mesa
                    WHERE cat.id_tipo_servicio = :0  AND pe.estado = 1 AND tp.estado = 1 AND tp.item > 0
                    GROUP BY me.id,tp.id
                    ORDER BY 1";
            $resultado["tabla2"] = $this->consultarFilas($sql,[$tipo]);          

            $sql = "SELECT 
                        tp.id,
                        pe.id_mesa,
                        pro.nombre as producto,
                        tp.cantidad,
                        tp.precio,
                        IF(tp.nota = '' AND tp.observaciones = '',
                           'NINGUNO',
                           IF(tp.nota = '' AND tp.observaciones<>'',
                                tp.observaciones,
                                IF(tp.nota<>'' AND tp.observaciones = '',
                                    tp.nota,
                                    CONCAT(tp.nota,' - ',tp.observaciones)
                                  )
                             )
                        ) as nota,
                        tp.estado,                        
                        tp.item
                    FROM toma_pedido tp
                    INNER JOIN producto pro ON pro.id = tp.id_producto
                    INNER JOIN categoria cat ON cat.id = pro.id_categoria
                    INNER JOIN pedido pe ON pe.id = tp.id_pedido
                    INNER JOIN empleado em ON em.id = pe.id_empleado
                    INNER JOIN mesa me ON me.id = pe.id_mesa
                    WHERE cat.id_tipo_servicio = :0 AND pe.estado = 1 AND tp.estado = 1 AND tp.item > 0";
            $resultado["detalle2"] = $this->consultarFilas($sql,[$tipo]);  

            $sql = "SELECT 
                        tp.id,
                        pe.id_mesa,
                        pro.nombre as producto,
                        SUM(tp.cantidad) as cantidad,
                        tp.precio,
                        IF(tp.nota = '' AND tp.observaciones = '',
                           'NINGUNO',
                           IF(tp.nota = '' AND tp.observaciones<>'',
                                tp.observaciones,
                                IF(tp.nota<>'' AND tp.observaciones = '',
                                    tp.nota,
                                    CONCAT(tp.nota,' - ',tp.observaciones)
                                  )
                             )
                        ) as nota,
                        tp.estado,                        
                        tp.item
                    FROM toma_pedido tp
                    INNER JOIN producto pro ON pro.id = tp.id_producto
                    INNER JOIN categoria cat ON cat.id = pro.id_categoria
                    INNER JOIN pedido pe ON pe.id = tp.id_pedido
                    INNER JOIN empleado em ON em.id = pe.id_empleado
                    INNER JOIN mesa me ON me.id = pe.id_mesa
                    WHERE cat.id_tipo_servicio = :0 AND pe.estado = 1 AND tp.estado = 1
                    GROUP BY tp.id,pro.nombre,tp.nota,tp.observaciones";
            $resultado["resumen"] = $this->consultarFilas($sql,[$tipo]); 

            $sql = "SELECT COUNT(*) FROM toma_pedido tp
                    INNER JOIN producto pro ON pro.id = tp.id_producto
                    INNER JOIN categoria cat ON cat.id = pro.id_categoria
                    INNER JOIN pedido pe ON pe.id = tp.id_pedido
                    WHERE cat.id_tipo_servicio = :0 AND pe.estado = 1 AND tp.estado = 1 AND tp.timbre = 1";
            $resultado["timbre"] = $this->consultarValor($sql,[$tipo]);
            return array("rpt"=>true,"msj"=>$resultado);
        } catch (Exception $exc) {
            return array("rpt"=>false,"msj"=>$exc);
            throw $exc;
        }
    }

    public function desactivarTimbre($tipo) {
        $this->beginTransaction();
        try {
            $sql = "SELECT tp.* FROM toma_pedido tp 
                    INNER JOIN pedido pe ON pe.id = tp.id_pedido 
                    INNER JOIN producto pro ON pro.id = tp.id_producto 
                    INNER JOIN categoria cat ON cat.id = pro.id_categoria 
                    WHERE cat.id_tipo_servicio = :0 AND pe.estado = 1";
            $toma_pedido = $this->consultarFilas($sql,[$tipo]);
            for ($i=0; $i < count($toma_pedido) ; $i++) { 
                $item = $toma_pedido[$i];
                $campos_valores = ["timbre"=>0]; 
                $campos_valores_where = ["id"=>$item["id"]];
                $this->update("toma_pedido", $campos_valores,$campos_valores_where);
            }
            
            $this->commit();
            return array("rpt"=>true,"msj"=>"Se agregado correctamente?");
        } catch (Exception $exc) {
            return array("rpt"=>false,"msj"=>$exc);
            $this->rollBack();
            throw $exc;
        }
    }

    public function anularTotalPedido() {
        $this->beginTransaction();
        try {
            $sql = "SELECT id FROM pedido where id_mesa = :0 AND estado = 1";
            $id_pedido = $this->consultarValor($sql,[$this->getId_mesa()]);

            $sql = "SELECT id FROM toma_pedido WHERE id_pedido = :0 AND estado = 1";
            $toma_pedido = $this->consultarFilas($sql,[$id_pedido]);



            for ($i=0; $i < count($toma_pedido); $i++) { 
                $item = $toma_pedido[$i];
                
                $campos_valores = ["estado"=>4];
                $campos_valores_where = [
                    "id"=>$item["id"]
                ];
                $this->update("toma_pedido", $campos_valores,$campos_valores_where);                
                
            }

            $campos_valores = ["estado"=>2];
            $campos_valores_where = ["id"=>$id_pedido];
            $this->update("pedido", $campos_valores,$campos_valores_where);   
            
            $campos_valores = ["estado_convencional"=>1];
            $campos_valores_where = ["id"=>$this->getId_mesa()];
            $this->update("mesa", $campos_valores,$campos_valores_where);  

            $this->commit();
            return array("rpt"=>true,"msj"=>"Se desactivado correctamente?");
        } catch (Exception $exc) {
            return array("rpt"=>false,"msj"=>$exc);
            $this->rollBack();
            throw $exc;
        }
    }

    public function listarEntregables(){
        try {
            $sql = "SELECT 
                        tp.id_pedido,
                        tp.id as id_toma_pedido,
                        pro.nombre as producto,
                        SUM(tp.cantidad) as cantidad,
                        tp.precio,
                        SUM(tp.cantidad)*tp.precio as importe,
                        IF(tp.nota IS NULL,'',tp.nota) as nota
                    FROM toma_pedido tp
                    INNER JOIN producto pro ON pro.id = tp.id_producto
                    INNER JOIN pedido pe ON pe.id = tp.id_pedido
                    WHERE tp.estado = 2 AND pe.estado = 1 AND pe.id_mesa = :0
                    GROUP BY tp.nota, pro.nombre
                    ORDER BY 2";
            $resultado = $this->consultarFilas($sql,[$this->getId_mesa()]);
            return array("rpt"=>true,"msj"=>$resultado);
        } catch (Exception $exc) {
            return array("rpt"=>false,"msj"=>$exc);
            throw $exc;
        }
    } 

    public function entregarPedido() {
        //FALTA EL INICIAR PARA ARREGLA ESTA VAINA
        $this->beginTransaction();
        try {
            $sql = "SELECT tp.id as id FROM toma_pedido tp
                    INNER JOIN pedido pe ON pe.id = tp.id_pedido
                    WHERE pe.id_mesa = :0 AND pe.estado = 1 AND tp.estado = 2";
            $resultado = $this->consultarFilas($sql,[$this->getId_mesa()]);

            for ($i=0; $i < count($resultado) ; $i++) { 
                $item = $resultado[$i]; 

                $campos_valores = ["estado"=>3]; 
                $campos_valores_where = ["id"=>$item["id"]];
                $this->update("toma_pedido", $campos_valores,$campos_valores_where);
            }
            $this->commit();
            return array("rpt"=>true,"msj"=>"Se agregado correctamente?");
        } catch (Exception $exc) {
            return array("rpt"=>false,"msj"=>$exc);
            $this->rollBack();
            throw $exc;
        }
    }

    public function listarPedidoFacturacion() {
        try {
            $sql = "SELECT
                        tp.id,
                        tp.id_pedido,
                        pro.nombre as producto,
                        tp.cantidad,
                        tp.precio,
                        tp.cantidad*tp.precio as importe,
                        tp.descuento as descuento,
                        IF(tp.nota IS NULL,'',tp.nota) as nota,
                        tp.estado
                    FROM pedido pe
                    INNER JOIN toma_pedido tp ON tp.id_pedido = pe.id
                    INNER JOIN producto pro ON pro.id = tp.id_producto
                    WHERE pe.id_mesa = :0 AND pe.estado = 1 AND tp.estado = 3";
            $resultado["listado"] = $this->consultarFilas($sql,[$this->getId_mesa()]);

            $sql = "SELECT * FROM pedido WHERE id_mesa = :0 AND estado = 1";
            $resultado["pedido"] = $this->consultarFila($sql,[$this->getId_mesa()]);

            return array("rpt"=>true,"msj"=>$resultado);
        } catch (Exception $exc) {
            return array("rpt"=>false,"msj"=>$exc);
            throw $exc;
        }
    }




    public function listarMesasPreparada(){
        try {
            $sql = "SELECT
                        pe.id as id_pedido,
                        me.numero,
                        CONCAT('Mesa ',me.numero) as mesa,                        
                        CONCAT(em.nombres,' ',em.apellido_paterno,' ',em.apellido_materno) as empleado
                    FROM toma_pedido tp 
                    INNER JOIN producto pro ON pro.id = tp.id_producto
                    INNER JOIN categoria cat ON cat.id = pro.id_categoria
                    INNER JOIN pedido pe ON pe.id = tp.id_pedido
                    INNER JOIN mesa me ON me.id = pe.id_mesa
                    INNER JOIN empleado em ON em.id = pe.id_empleado
                    WHERE tp.estado = 2 AND pe.estado = 1 AND cat.id_tipo_servicio = 1
                    GROUP BY pe.id
                    ORDER BY tp.id";
            $resultado["bar"] = $this->consultarFilas($sql);


            $sql = "SELECT
                        pe.id as id_pedido,
                        me.numero,
                        CONCAT('Mesa ',me.numero) as mesa,                        
                        CONCAT(em.nombres,' ',em.apellido_paterno,' ',em.apellido_materno) as empleado
                    FROM toma_pedido tp 
                    INNER JOIN producto pro ON pro.id = tp.id_producto
                    INNER JOIN categoria cat ON cat.id = pro.id_categoria
                    INNER JOIN pedido pe ON pe.id = tp.id_pedido
                    INNER JOIN mesa me ON me.id = pe.id_mesa
                    INNER JOIN empleado em ON em.id = pe.id_empleado
                    WHERE tp.estado = 2 AND pe.estado = 1 AND cat.id_tipo_servicio = 2
                    GROUP BY pe.id
                    ORDER BY tp.id";
            $resultado["cocina"] = $this->consultarFilas($sql);

            $sql = "SELECT 
                        tp.id_pedido,
                        me.numero,
                        tp.id_producto,
                        pro.nombre as producto,
                        SUM(tp.cantidad) as cantidad,
                        tp.precio,
                        SUM(tp.cantidad)*tp.precio as importe,
                        tp.nota
                    FROM toma_pedido tp
                    INNER JOIN producto pro ON pro.id = tp.id_producto
                    INNER JOIN categoria cat ON cat.id = pro.id_categoria
                    INNER JOIN pedido pe ON pe.id = tp.id_pedido
                    INNER JOIN mesa me ON me.id = pe.id_mesa
                    WHERE cat.id_tipo_servicio = 1 AND tp.estado = 2 AND pe.estado = 1
                    GROUP BY pe.id,tp.id_producto,tp.nota
                    ORDER BY tp.id_pedido";
            $resultado["db"] = $this->consultarFilas($sql);

            $sql = "SELECT 
                        tp.id_pedido,
                        me.numero,
                        tp.id_producto,
                        pro.nombre as producto,
                        SUM(tp.cantidad) as cantidad,
                        tp.precio,
                        SUM(tp.cantidad)*tp.precio as importe,
                        tp.nota
                    FROM toma_pedido tp
                    INNER JOIN producto pro ON pro.id = tp.id_producto
                    INNER JOIN categoria cat ON cat.id = pro.id_categoria
                    INNER JOIN pedido pe ON pe.id = tp.id_pedido
                    INNER JOIN mesa me ON me.id = pe.id_mesa
                    WHERE cat.id_tipo_servicio = 2 AND tp.estado = 2 AND pe.estado = 1
                    GROUP BY pe.id,tp.id_producto,tp.nota
                    ORDER BY tp.id_pedido";
            $resultado["dc"] = $this->consultarFilas($sql);
            return array("rpt"=>true,"msj"=>$resultado);
        } catch (Exception $exc) {
            return array("rpt"=>false,"msj"=>$exc);
            throw $exc;
        }
    }

    



    public function listarCarrito(){
        try {
            $sql = "SELECT 
                        tp.id_pedido,
                        tp.id as id_toma_pedido,
                        pro.nombre as producto,
                        SUM(tp.cantidad) as cantidad,
                        tp.precio,
                        SUM(tp.cantidad)*tp.precio as importe,
                        tp.estado,
                        tp.nota
                    FROM toma_pedido tp
                    INNER JOIN producto pro ON pro.id = tp.id_producto
                    INNER JOIN pedido pe ON pe.id = tp.id_pedido
                    WHERE tp.estado = 2 AND pe.estado = 1 AND pe.id_mesa = :0
                    GROUP BY tp.nota, pro.nombre
                    ORDER BY 2";
            $resultado = $this->consultarFilas($sql,[$this->getId_mesa()]);
            return array("rpt"=>true,"msj"=>$resultado);
        } catch (Exception $exc) {
            return array("rpt"=>false,"msj"=>$exc);
            throw $exc;
        }
    }

    public function cambiarEstadoPreparado($kpi){
        $this->beginTransaction();
        try {
            $campos_valores = [
                "estado"=>2,
                "kpi"=>$kpi
            ]; 
            $campos_valores_where = [
                "id"=>$this->getId()
            ];
            $this->update("toma_pedido", $campos_valores,$campos_valores_where);            
            $this->commit();
            return array("rpt"=>true,"msj"=>"Se ha cambiado correctamente el estado del toma pedido");
        } catch (Exception $exc) {
            return array("rpt"=>false,"msj"=>$exc);
            $this->rollBack();
            throw $exc;
        }
    }

    public function cambiarEstadoEntregado($detalle){
        $this->beginTransaction();
        try {
            $sql = "SELECT * FROM toma_pedido WHERE estado = 2";
            $toma_pedido = $this->consultarFilas($sql);

            for ($i=0; $i < count($toma_pedido) ; $i++) {
                $item = $toma_pedido[$i];

                $arreglo = json_decode($detalle);

                for ($i=0; $i <count($arreglo) ; $i++) { 
                    $value = $arreglo[$i];

                    $campos_valores = [
                        "estado"=>3
                    ]; 
                    $campos_valores_where = [
                        "id_pedido"=>$value->p_id_pedido, 
                        "nota"=>$value->p_nota,
                        "id"=>$item["id"]
                    ];
                    $this->update("toma_pedido", $campos_valores,$campos_valores_where);
                }
            }
            $campos_valores = [
                "disponibilidad"=>0
            ]; 
            $campos_valores_where = [
                "id"=>$this->getId_mesa()
            ];
            $this->update("mesa", $campos_valores,$campos_valores_where);
            $this->commit();
            return array("rpt"=>true,"msj"=>"Se ha cambiado correctamente el estado del toma pedido");
        } catch (Exception $exc) {
            return array("rpt"=>false,"msj"=>$exc);
            $this->rollBack();
            throw $exc;
        }
    }

    public function cambiarEstadoTomaPedido() {
        $this->beginTransaction();
        try {
            $sql = "SELECT 
                    COUNT(*)
                    FROM toma_pedido
                    WHERE id_pedido = :0 AND estado > 2
                    GROUP BY nota";
            $anteriores = intval($this->consultarValor($sql,[$this->getId()]));

            $sql = "SELECT 
                    COUNT(*)
                    FROM toma_pedido
                    WHERE id_pedido = :0 AND estado IN (1,2)
                    GROUP BY nota";
            $contar = intval($this->consultarValor($sql,[$this->getId()]));

            $sql = "SELECT * FROM mesa WHERE id = (SELECT id_mesa FROM pedido WHERE id = :0)";
            $mesa = $this->consultarFila($sql,[$this->getId()]);

            $id_mesa = $mesa["id"];
            $estado_convencional = intval($mesa["estado_convencional"]);

            if ( $anteriores === 0 ) {
                if ( $contar == 1 && $estado_convencional == 2 ) {
                    if ( $this->getEstado() === '4' ) {                    
                        $campos_valores = ["estado"=>$this->getEstado()]; 
                        $campos_valores_where = ["id"=>$this->getId()];
                        $this->update("pedido", $campos_valores,$campos_valores_where);

                        $campos_valores = ["estado_convencional"=>1]; 
                        $campos_valores_where = ["id"=>$id_mesa];
                        $this->update("mesa", $campos_valores,$campos_valores_where);                  
                    }
                }    
            }

            $campos_valores = [
                "estado"=>$this->getEstado(),
                "id_empleado"=>1 // FALTA EMPLEADO
            ]; 
            $campos_valores_where = [
                "id_pedido"=>$this->getId(),
                "nota"=>$this->getNota()
            ];
            $this->update("toma_pedido", $campos_valores,$campos_valores_where);

            $campos_valores = ["disponibilidad"=>0]; 
            $campos_valores_where = ["id"=>$id_mesa];
            $this->update("mesa", $campos_valores,$campos_valores_where);
            $this->commit();
            return array("rpt"=>true,"msj"=>"Se ha cambiado correctamente el estado del toma pedido");
        } catch (Exception $exc) {
            return array("rpt"=>false,"msj"=>$exc);
            $this->rollBack();
            throw $exc;
        }
    }

    public function anularTotal(){
        //FALTA EL EMPLEADO
        $this->beginTransaction();
        try {
            $campos_valores = [
                "estado"=>4,
                "id_empleado"=>1 //ESTO DEBE CAMBIAR
            ]; 
            $campos_valores_where = [
                "id_pedido"=>$this->getId()
            ];
            $this->update("toma_pedido", $campos_valores,$campos_valores_where);

            $campos_valores = [
                "estado"=>3
            ]; 
            $campos_valores_where = [
                "id"=>$this->getId()
            ];
            $this->update("pedido", $campos_valores,$campos_valores_where);

            $sql = "SELECT id_mesa FROM pedido WHERE id = :0";
            $id_mesa = $estado = $this->consultarValor($sql,[$this->getId()]);

            $campos_valores = [
                "estado_convencional"=>1,
                "disponibilidad"=>0
            ];             
            $campos_valores_where = [
                "id"=>$id_mesa
            ];
            $this->update("mesa", $campos_valores,$campos_valores_where);
            $this->commit();
            return array("rpt"=>true,"msj"=>"Se ha anulado el pedido");
        } catch (Exception $exc) {
            return array("rpt"=>false,"msj"=>$exc);
            $this->rollBack();
            throw $exc;
        }
    }

    public function finalizarTotal(){
        //FALTA EL EMPLEADO
        $this->beginTransaction();
        try {
            $sql = "SELECT id FROM toma_pedido WHERE id_pedido = :0 AND estado = 2";
            $toma_pedido = $estado = $this->consultarFilas($sql,[$this->getId()]);

            for ($i=0; $i < count($toma_pedido) ; $i++) { 
                $item = $toma_pedido[$i];

                $campos_valores = [
                    "estado"=>3,
                    "id_empleado"=>1 //ESTO DEBE CAMBIAR
                ]; 
                $campos_valores_where = [
                    "id"=>$item["id"]
                ];
                $this->update("toma_pedido", $campos_valores,$campos_valores_where);
            }

            $sql = "SELECT id_mesa FROM pedido WHERE id = :0";
            $id_mesa = $estado = $this->consultarValor($sql,[$this->getId()]);

            $campos_valores = [
                "disponibilidad"=>0
            ];             
            $campos_valores_where = [
                "id"=>$id_mesa
            ];
            $this->update("mesa", $campos_valores,$campos_valores_where);
            $this->commit();
            return array("rpt"=>true,"msj"=>"Se ha finalizado el pedido");
        } catch (Exception $exc) {
            return array("rpt"=>false,"msj"=>$exc);
            $this->rollBack();
            throw $exc;
        }
    }

    public function listarAceptados(){
        try {
            $sql = "SELECT
                        tp.id_pedido,
                        pro.nombre as producto,
                        tp.cantidad,
                        tp.precio,
                        SUM(tp.cantidad)*tp.precio as importe,
                        tp.nota
                    FROM toma_pedido tp
                    INNER JOIN pedido pe ON pe.id = tp.id_pedido
                    INNER JOIN producto pro ON pro.id = tp.id_producto
                    WHERE pe.id_mesa = :0 AND tp.estado = 3 AND pe.estado = 1
                    GROUP BY pro.nombre,tp.nota
                    ORDER BY tp.id";
            $resultado = $this->consultarFilas($sql,[$this->getId_mesa()]);
            return array("rpt"=>true,"msj"=>$resultado);
        } catch (Exception $exc) {
            return array("rpt"=>false,"msj"=>$exc);
            throw $exc;
        }
    }

    public function realizarPago(
            $tipo,
            $numero,
            $correlativo,
            $documento,
            $cliente,
            $direccion,
            $usuario,
            $monto,
            $monto_descuento,
            $monto_amortizacion,
            $ticket,
            $medio_pago,
            $producto,
            $cantidad_producto,
            $cantidad_puntos,
            $json,
            //EXTRA
            $tomo
        ){
        $this->beginTransaction();
        try {
            //BUSCAR EL PEDIDO
            $sql = "SELECT id FROM pedido WHERE id_mesa = :0 AND estado = 1";
            $id_pedido = intval($this->consultarValor($sql,[$this->getId_mesa()]));

            //CONTAR FILAS LISTAS PARA PAGO
            $sql = "SELECT COUNT(*) FROM toma_pedido WHERE id_pedido = :0 AND estado = 3";
            $resultado = intval($this->consultarValor($sql,[$id_pedido]));

            $toma_pedido = json_decode($json); /// ARREGLO DE TOMA_PEDIDO
            $json_tomo = json_decode($tomo); // ARREGLO DE DESCUENTOS

            $faltaFacturar=false;

            //ACTUALIZA DESCUENTO
            foreach ($toma_pedido as $key => $value) {
                $sql = "SELECT cantidad FROM toma_pedido WHERE id = :0";
                $resultado = intval($this->consultarValor($sql,[$value]));

                if  ($resultado!=$json_tomo[$key]->cantidad){
                //     $campos_valores = [
                //         "descuento"=>$json_tomo[$key]->descuento
                //     ];             
                //     $campos_valores_where = ["id"=>$value];
                //     $this->update("toma_pedido", $campos_valores,$campos_valores_where); 
                // }
                // else{
                    $sql = "SELECT * FROM toma_pedido WHERE id = :0 ORDER BY 1";
                    $antiguo = $this->consultarFila($sql,[$value]);
                    
                    $campos_valores = [
                        "id_pedido" =>$antiguo["id_pedido"],                        
                        "id_producto"=>$antiguo["id_producto"],
                        "cantidad"=>$antiguo["cantidad"]-$json_tomo[$key]->cantidad,
                        "precio"=>$antiguo["precio"],
                        "estado"=>3,
                        "nota"=>$antiguo["nota"],
                        "kpi"=>$antiguo["kpi"],
                        "observaciones"=>$antiguo["observaciones"],
                        "item"=>$antiguo["item"],
                        "timbre"=>$antiguo["timbre"],
                        "fecha_registro"=>$antiguo["fecha_registro"]
                    ];
                    $this->insert("toma_pedido", $campos_valores);

                    $campos_valores = [
                        "cantidad"=>$json_tomo[$key]->cantidad,
                    ];             
                    $campos_valores_where = ["id"=>$value];
                    $this->update("toma_pedido", $campos_valores,$campos_valores_where);   
                    
                    $faltaFacturar=true;
                }
                
                $campos_valores = [
                    "descuento"=>$json_tomo[$key]->descuento
                ];             
                $campos_valores_where = ["id"=>$value];
                $this->update("toma_pedido", $campos_valores,$campos_valores_where); 

            }            
            
            //CONTAR FILAS EN PEDIDO / COCINA / PENDIENTE DE ENTREGA
            $sql = "SELECT COUNT(*) FROM toma_pedido WHERE id_pedido = :0 AND estado < 3";
            $pendientes = intval($this->consultarValor($sql,[$id_pedido]));

            //SI total de toma_pedido  IGUAL a total para facturar  Y pendientes = 0
            if ( (count($toma_pedido) == $resultado ) &&  ($pendientes==0) && $faltaFacturar) {
                //ACTUALIZA ESTADO DE PEDIDO
                $campos_valores = [
                    "estado"=>2
                ];             
                $campos_valores_where = ["id"=>$id_pedido];
                $this->update("pedido", $campos_valores,$campos_valores_where);   

                /* $sql = "SELECT * FROM toma_pedido WHERE id_pedido = :0 AND estado < 3";
                $sin_facturacion = $this->consultarFilas($sql,[$id_pedido]);

                for ($i=0; $i < count($sin_facturacion) ; $i++) { 
                    $item = $sin_facturacion[$i];

                    $campos_valores = [
                        "estado"=>5
                    ];             
                    $campos_valores_where = [
                        "id"=>$item["id"]
                    ];
                    $this->update("toma_pedido", $campos_valores,$campos_valores_where);
                } */

                //ACTUALIZA MESA
                $campos_valores = [
                    "estado_convencional"=>1
                ];             
                $campos_valores_where = [
                    "id"=>$this->getId_mesa()
                ];
                $this->update("mesa", $campos_valores,$campos_valores_where);
            }

            $num_correlativo = intval($correlativo);
            $new_correlativo = $num_correlativo+1;

            //FACTURACION
            $campos_valores = [
                "id_pedido"=>$id_pedido,
                "id_tipo_comprobante"=>$tipo,
                "numero"=>$numero,
                "correlativo"=>$num_correlativo,
                "documento"=>$documento,
                "razon_social"=>$cliente,
                "direccion"=>$direccion,
                "usuario"=>$usuario,
                "monto"=>$monto,
                "monto_descuento"=>$monto_descuento,
                "monto_amortizacion"=>$monto_amortizacion,
                "puntos"=>intval($monto_amortizacion),
                "id_medio_pago"=>($medio_pago),
                "ticket"=>$ticket,
                "producto"=>$producto,
                "cantidad_producto"=>$cantidad_producto
            ]; 
            $this->insert("facturacion", $campos_valores);

            $sql = "SELECT MAX(id) FROM facturacion";
            $id_facturacion = $this->consultarValor($sql);

            for ($i=0; $i < count($toma_pedido) ; $i++) { 
                $item = $toma_pedido[$i];

                $campos_valores = [
                    "estado"=>6,
                    "id_facturacion"=>$id_facturacion
                ];             
                $campos_valores_where = [
                    "id"=>$item
                ];
                $this->update("toma_pedido", $campos_valores,$campos_valores_where);
            }   

            //CORRELATIVO
            $campos_valores = [
                "correlativo"=>$new_correlativo
            ];             
            $campos_valores_where = [
                "id_tipo_comprobante"=>$tipo,
                "numero"=>$numero
            ];
            $this->update("serie_comprobante", $campos_valores,$campos_valores_where);

            //CAMBIAR PUNTOS
            $sql = "SELECT id,puntos,estado_puntos FROM facturacion WHERE documento = :0 ORDER BY 1";
            $puntos = $this->consultarFilas($sql,[$documento]);
            
            $contar = intval($cantidad_puntos);

            for ($i=0; $i < count($puntos) ; $i++) { 
                $item = $puntos[$i];

                if ( intval($item["puntos"]) < $contar ) {
                    $campos_valores = [
                        "estado_puntos"=>0
                    ];             
                    $campos_valores_where = [
                        "id"=>$item["id"]
                    ];
                    $this->update("facturacion", $campos_valores,$campos_valores_where);
                    $contar = $contar - intval($item["puntos"]);
                }else {
                    if ( $contar != 0) {
                        $campos_valores = [
                            "puntos"=>intval($item["puntos"])-$contar
                        ];             
                        $campos_valores_where = [
                            "id"=>$item["id"]
                        ];
                        $this->update("facturacion", $campos_valores,$campos_valores_where);
                        $contar = 0;
                    }
                }
            }
            
            /* $data["tipo"] = ($tipo == "03" ? "BOLETA" : "FACTURA")." ELECTRÓNICA";
            $data["comprobante"] = ($tipo == "03" ? "B" : "F").$numero."-".$correlativo;
            $data["toma_pedido"] = $toma_pedido;
            $data["cliente"] = [
                [
                    "descripcion"=>"RUC/DNI",
                    "texto"=>$documento
                ],
                [
                    "descripcion"=>"CLIENTE",
                    "texto"=>$cliente
                ],
                [
                    "descripcion"=>"DIRECCIÓN",
                    "texto"=>$direccion == "" ? "-" : $direccion
                ],
                [
                    "descripcion"=>"F. EMISIÓN",
                    "texto"=>date("d/m/Y")
                ]   
            ];

            $ticket = new GenerarTicket();
            $ticket->crearPDF($data); */

            
            $this->commit();
            return array("rpt"=>true,"msj"=>"Se ha finalizado el pedido");

            
            /*LOG MOVIMIENTO*/
            /*$campos_valores = [
                "id_mesa"=>$this->getId_mesa(),
                "id_pedido"=>$id_pedido,
                "id_facturacion"=>$id_facturacion,
                "id_tipo_comprobante"=>$tipo,
                "numero"=>$numero,
                "correlativo"=>$num_correlativo,
                "new_correlativo"=>$new_correlativo
            ]; 
            $this->insert("log", $campos_valores);*/
        } catch (Exception $exc) {
            return array("rpt"=>false,"msj"=>$exc);
            $this->rollBack();
            throw $exc;
        }
    }

    public function reportePago($tipo,$fecha_inicio,$fecha_fin){       
        try {
            $sql = "";            
            if ( $tipo == "1" ) {
                $sql .= "SELECT 
                            fa.id,
                            CONCAT(tc.abreviatura,'-',CONCAT(REPEAT('0', 3-LENGTH(fa.numero)), fa.numero),'-',CONCAT(REPEAT('0', 7-LENGTH(fa.correlativo)), fa.correlativo)) as comprobante,
                            pe.fecha_registro as fecha_registro_pedido,
                            fa.fecha_registro as fecha_registro_facturacion,
                            fa.monto as subtotal,
                            fa.monto_descuento as descuentos,
                            fa.ticket as ticket,
                            fa.monto_amortizacion as total,
                            me.descripcion as medioPago
                        FROM facturacion fa
                        INNER JOIN tipo_comprobante tc ON tc.id = fa.id_tipo_comprobante
                        INNER JOIN pedido pe ON pe.id = fa.id_pedido
                        INNER JOIN medios_pago me on me.id=fa.Id_medio_pago
                        WHERE DATE_FORMAT(fa.fecha_registro, '%Y-%m-%d %H:%i:%S') >= :0 AND DATE_FORMAT(fa.fecha_registro, '%Y-%m-%d %H:%i:%S') <= :1
                        ORDER BY 4 DESC";    
            }else{
                $sql .= "SELECT 
                            tp.id_producto as id_producto,
                            pr.nombre as nombre, 
                            tp.cantidad as cantidad, 
                            tp.precio as precio,
                            tp.cantidad*tp.precio as monto 
                        FROM facturacion fac 
                        INNER JOIN toma_pedido tp on tp.id_facturacion=fac.id
                        INNER JOIN producto pr on tp.id_producto=pr.id 
                        WHERE DATE_FORMAT(fac.fecha_registro, '%Y-%m-%d %H:%i:%S') >= :0 AND DATE_FORMAT(fac.fecha_registro, '%Y-%m-%d %H:%i:%S') <= :1 AND tp.estado in ('','6')";
                        
            }
            $resultado = $this->consultarFilas($sql,[$fecha_inicio,$fecha_fin]); 
            return array("rpt"=>true,"msj"=>$resultado);
        } catch (Exception $exc) {
            return array("rpt"=>false,"msj"=>$exc);
            throw $exc;
        }
    }

    public function verDetallePedidoPagado(){
        try {
            $sql = "SELECT 
                        pro.nombre as producto,
                        tp.cantidad,
                        tp.precio,
                        tp.cantidad*tp.precio as importe,
                        tp.descuento as descuento,
                        tp.cantidad*tp.precio-tp.descuento as total,
                        IF(tp.nota IS NULL,'',tp.nota) as nota
                    FROM toma_pedido tp
                    INNER JOIN producto pro ON pro.id = tp.id_producto
                    WHERE tp.id_facturacion = :0";
            $resultado["rpt"] = $this->consultarFilas($sql,[$this->getId()]);


            $sql = "SELECT 
                    IF(documento='' AND razon_social='',usuario, CONCAT('(',documento,') ',razon_social)) as etiqueta 
                    FROM facturacion WHERE id = :0";
            $resultado["etiqueta"] = $this->consultarValor($sql,[$this->getId()]);

            $sql = "SELECT 
                    fecha_registro as fecha 
                    FROM facturacion WHERE id = :0";
            $resultado["fecha"] = $this->consultarValor($sql,[$this->getId()]);

            $sql = "SELECT 
                    me.numero as mesa
                    FROM facturacion fa 
                    INNER join pedido pe on fa.id_pedido=pe.id 
                    INNER JOIN mesa me on pe.id_mesa=me.id where fa.id= :0";
            $resultado["mesa"] = $this->consultarValor($sql,[$this->getId()]);
            return array("rpt"=>true,"msj"=>$resultado);
        } catch (Exception $exc) {
            return array("rpt"=>false,"msj"=>$exc);
            throw $exc;
        }
    }

    public function listarPedidoCarrito(){
        try {
            $sql = "SELECT 
                        tp.id,
                        pro.nombre as producto,
                        tp.cantidad,
                        tp.precio,
                        tp.cantidad*tp.precio as importe,
                        tp.estado,
                        IF(tp.nota IS NULL,'',tp.nota) as nota,
                        IF(tp.observaciones IS NULL,'',tp.observaciones) as observaciones
                    FROM toma_pedido tp
                    INNER JOIN pedido pe ON pe.id = tp.id_pedido
                    INNER JOIN producto pro ON pro.id = tp.id_producto
                    WHERE pe.id_mesa = :0 AND pe.estado = 1";
            $resultado = $this->consultarFilas($sql,[$this->getId_mesa()]);
            return array("rpt"=>true,"msj"=>$resultado);
        } catch (Exception $exc) {
            return array("rpt"=>false,"msj"=>$exc);
            throw $exc;
        }   
    }



    public function darBaja($id,$estado,$mesa) {
        $this->beginTransaction();
        try {
            $campos_valores = [                
                "estado"=>$estado
            ];
            $campos_valores_where = ["id"=>$id];
            $this->update("toma_pedido", $campos_valores,$campos_valores_where);

            $sql = "SELECT id_pedido FROM toma_pedido WHERE id = :0";
            $id_pedido = $this->consultarValor($sql,[$id]); 

            $sql = "SELECT COUNT(id_pedido) FROM toma_pedido WHERE id_pedido = :0 AND estado <> 4 AND estado <> 6";
            $cantidad = $this->consultarValor($sql,[$id_pedido]);

            if( intval($cantidad) < 1 ){
                $campos_valores = [                
                    "estado"=>3
                ];
                $campos_valores_where = ["id"=>$id_pedido];
                $this->update("pedido", $campos_valores,$campos_valores_where);

                $campos_valores = [                
                    "estado_convencional"=>1
                ];
                $campos_valores_where = ["id"=>$mesa];
                $this->update("mesa", $campos_valores,$campos_valores_where);
            }           
            $this->commit();
            return array("rpt"=>true,"msj"=>"Se anulado correctamente");
        } catch (Exception $exc) {
            return array("rpt"=>false,"msj"=>$exc);
            $this->rollBack();
            throw $exc;
        }
    }

    public function iniciarMesaPedidoEstado($nombre_cliente) {
        $this->beginTransaction();
        try {
            $sql = "SELECT id FROM pedido WHERE id_mesa = :0 AND estado = 1";
            $id_pedido = $this->consultarValor($sql,[$this->getId_mesa()]);

            $campos_valores = [                
                "nombre_cliente"=>$nombre_cliente
            ];
            $campos_valores_where = ["id"=>$id_pedido];
            $this->update("pedido", $campos_valores,$campos_valores_where);

            $campos_valores = [                
                "estado_convencional"=>3
            ];
            $campos_valores_where = ["id"=>$this->getId_mesa()];
            $this->update("mesa", $campos_valores,$campos_valores_where);
            $this->commit();
            return array("rpt"=>true,"msj"=>"Se ha iniciado correctamente");
        } catch (Exception $exc) {
            return array("rpt"=>false,"msj"=>$exc);
            $this->rollBack();
            throw $exc;
        }
    }





    
}


