<?php

require_once '../acceso/Conexion.clase.php';

class Empleado extends Conexion {
    private $id;
    private $dni;
    private $nombres;
    private $apellido_paterno;
    private $apellido_materno;
    private $sexo;
    private $direccion;
    private $tele_uno;
    private $tele_dos;
    private $estado;
    private $id_tipo_empleado;

    public function getId(){
        return $this->id;
    }
    
    public function setId($id){
        $this->id = $id;
        return $this;
    }

    public function getDni(){
        return $this->dni;
    }
    
    public function setDni($dni){
        $this->dni = $dni;
        return $this;
    }

    public function getNombres(){
        return $this->nombres;
    }
    
    public function setNombres($nombres){
        $this->nombres = $nombres;
        return $this;
    }

    public function getApellido_paterno(){
        return $this->apellido_paterno;
    }
    
    public function setApellido_paterno($apellido_paterno){
        $this->apellido_paterno = $apellido_paterno;
        return $this;
    }

    public function getApellido_materno(){
        return $this->apellido_materno;
    }
    
    public function setApellido_materno($apellido_materno){
        $this->apellido_materno = $apellido_materno;
        return $this;
    }

    public function getSexo(){
        return $this->sexo;
    }
    
    public function setSexo($sexo){
        $this->sexo = $sexo;
        return $this;
    }

    public function getDireccion(){
        return $this->direccion;
    }
    
    public function setDireccion($direccion){
        $this->direccion = $direccion;
        return $this;
    }

    public function getTele_uno(){
        return $this->tele_uno;
    }
    
    public function setTele_uno($tele_uno){
        $this->tele_uno = $tele_uno;
        return $this;
    }

    public function getTele_dos(){
        return $this->tele_dos;
    }
    
    public function setTele_dos($tele_dos){
        $this->tele_dos = $tele_dos;
        return $this;
    }

    public function getEstado(){
        return $this->estado;
    }
    
    public function setEstado($estado){
        $this->estado = $estado;
        return $this;
    }

    public function getId_tipo_empleado(){
        return $this->id_tipo_empleado;
    }
    
    public function setId_tipo_empleado($id_tipo_empleado){
        $this->id_tipo_empleado = $id_tipo_empleado;
        return $this;
    }

    public function agregar() {
        $this->beginTransaction();
        try {            
            $campos_valores = [
                "dni"=>$this->getDni(),
                "nombres"=>strtoupper($this->getNombres()),
                "apellido_paterno"=>strtoupper($this->getApellido_paterno()),
                "apellido_materno"=>strtoupper($this->getApellido_materno()),
                "sexo"=>$this->getSexo(),
                "direccion"=>strtoupper($this->getDireccion()),
                "tele_uno"=>empty($this->getTele_uno()) ? null : $this->getTele_uno(),
                "tele_dos"=>empty($this->getTele_dos()) ? null : $this->getTele_dos(),
                "id_tipo_empleado"=>$this->getId_tipo_empleado()
            ]; 
            $this->insert("empleado", $campos_valores);

            $sql = "SELECT MAX(id) FROM empleado";
            $id_empleado = $this->consultarValor($sql);

            $campos_valores = [
                "id_empleado"=>$id_empleado
            ]; 
            $this->insert("usuario", $campos_valores);
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
                "dni"=>$this->getDni(),
                "nombres"=>strtoupper($this->getNombres()),
                "apellido_paterno"=>strtoupper($this->getApellido_paterno()),
                "apellido_materno"=>strtoupper($this->getApellido_materno()),
                "sexo"=>$this->getSexo(),
                "direccion"=>strtoupper($this->getDireccion()),
                "tele_uno"=>empty($this->getTele_uno()) ? null : $this->getTele_uno(),
                "tele_dos"=>empty($this->getTele_dos()) ? null : $this->getTele_dos(),
                "id_tipo_empleado"=>$this->getId_tipo_empleado()
            ]; 
            $campos_valores_where = ["id"=>$this->getId()];
            $this->update("empleado", $campos_valores,$campos_valores_where);
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
            if ( $this->getId_tipo_empleado() == "*" ) {
                $sql = "SELECT
                            id,
                            dni,
                            concat(nombres,' ',apellido_paterno,' ',apellido_materno) as nombres_apellidos,
                            direccion,
                            IF(tele_uno IS NOT NULL AND tele_dos IS NOT NULL,
                                CONCAT(tele_uno,'-',tele_dos),
                                IF(tele_uno IS NULL AND tele_dos IS NULL,
                                    'SIN NÚMERO TELEFONICO',
                                    IF(tele_uno IS NULL AND tele_dos IS NOT NULL,
                                       tele_dos,
                                       tele_uno
                                    )
                                )                           
                            ) as telefonos,
                            estado,
                            id_tipo_empleado
                        FROM empleado
                        WHERE estado = :0";
                $resultado = $this->consultarFilas($sql,[$this->getEstado()]); 
            }else{
                $sql = "SELECT
                            id,
                            dni,
                            concat(nombres,' ',apellido_paterno,' ',apellido_materno) as nombres_apellidos,
                            direccion,
                            IF(tele_uno IS NOT NULL AND tele_dos IS NOT NULL,
                                CONCAT(tele_uno,'-',tele_dos),
                                IF(tele_uno IS NULL AND tele_dos IS NULL,
                                    'SIN NÚMERO TELEFONICO',
                                    IF(tele_uno IS NULL AND tele_dos IS NOT NULL,
                                       tele_dos,
                                       tele_uno
                                    )
                                )                           
                            ) as telefonos,
                            estado,
                            id_tipo_empleado
                        FROM empleado
                        WHERE estado = :0 AND id_tipo_empleado = :1";
                $resultado = $this->consultarFilas($sql,[$this->getEstado(),$this->getId_tipo_empleado()]);
            }            
            return array("rpt"=>true,"msj"=>$resultado);
        } catch (Exception $exc) {
            return array("rpt"=>false,"msj"=>$exc);
            throw $exc;
        }
    }

    public function leerDatos() {
        try {
            $sql = "SELECT * FROM empleado WHERE id =:0";
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
            $this->update("empleado", $campos_valores,$campos_valores_where);
            $this->commit();
            return array("rpt"=>true,"msj"=>$texto);
        } catch (Exception $exc) {
            return array("rpt"=>false,"msj"=>$exc);
            $this->rollBack();
            throw $exc;
        }
    }

    public function listarUsuario() {
        try {
            $sql = "SELECT 
                        em.id,
                        em.dni,
                        concat(em.nombres,' ',em.apellido_paterno,' ',em.apellido_materno) as nombres_apellidos, 
                        te.descripcion as cargo,
                        us.estado as estado_usuario,
                        IF(us.clave IS NULL, 'SIN CLAVE','**********') as clave
                    FROM empleado em
                    INNER JOIN usuario us ON us.id_empleado = em.id
                    INNER JOIN tipo_empleado te ON te.id = em.id_tipo_empleado
                    WHERE em.estado = 1";
            $resultado = $this->consultarFilas($sql);
            return array("rpt"=>true,"msj"=>$resultado);
        } catch (Exception $exc) {
            return array("rpt"=>false,"msj"=>$exc);
            throw $exc;
        }
    }

    public function generaClave($clave) {
        $this->beginTransaction();
        try {                     
            $campos_valores = ["clave"=>md5($clave)];
            $campos_valores_where = ["id_empleado"=>$this->getId()];
            $this->update("usuario", $campos_valores,$campos_valores_where);
            $this->commit();
            return array("rpt"=>true,"msj"=>"Se generado clave del empleado");
        } catch (Exception $exc) {
            return array("rpt"=>false,"msj"=>$exc);
            $this->rollBack();
            throw $exc;
        }
    }

    public function cambiarUsuario() {
        $this->beginTransaction();
        try {
            $texto = $this->getEstado() != '1' ? 'Se inactivado existosamente' : 'Se activado existosamente';            
            $campos_valores = ["estado"=>$this->getEstado()];
            $campos_valores_where = ["id_empleado"=>$this->getId()];
            $this->update("usuario", $campos_valores,$campos_valores_where);
            $this->commit();
            return array("rpt"=>true,"msj"=>$texto);
        } catch (Exception $exc) {
            return array("rpt"=>false,"msj"=>$exc);
            $this->rollBack();
            throw $exc;
        }
    }



}