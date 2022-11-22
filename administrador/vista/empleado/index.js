var DOM = {};
$(document).ready(function () {
    setDOM();
    setEventos();    
    cargarTipoEmpleadoCB();
    cargarTipoEmpleado();
    cargarUbicacion();
    $('input[name="intSexo"][value="1"]').prop('checked', true);
    setTimeout(function(){ 
        listar(); 
    }, 100);
});
function setDOM() {
    DOM.p_codigo_empleado = $("#intCodigoEmpleado"),
	DOM.p_documento = $("#strDocumento"),
    DOM.p_nombres = $("#strNombres"),
    DOM.p_paterno = $("#strPaterno"),
    DOM.p_materno = $("#strMaterno"),
    DOM.p_direccion = $("#strDireccion"),
    DOM.p_telefono_uno = $("#strTelefono1"),
    DOM.p_telefono_dos = $("#strTelefono2"),    
    DOM.p_codigo_tipo_empleado = $("#intCodigoTipoEmpleado"),
    DOM.p_ubicacion = $("#intUbicacion"),

	DOM.self = $("#myModal"),
	DOM.btnAgregar = $("#btnAgregar"),
	DOM.operacion = $("#operacion"),
    DOM.cboEstado = $("#cboEstado"),
    DOM.cboTipoEmpleado = $("#cboTipoEmpleado"),

	DOM.form = $("#boton");
}

function limpiar(){
    DOM.p_codigo_empleado.val("");
    DOM.p_documento.val("");
    DOM.p_nombres.val("");
    DOM.p_paterno.val("");
    DOM.p_materno.val("");
    DOM.p_direccion.val("");
    DOM.p_telefono_uno.val("");
    DOM.p_telefono_dos.val("");
    $("#XDocumento").find(".form-line").removeClass('focused');
    $("#XNombresCompletos").find(".form-line").removeClass('focused');
    $("#XPaterno").find(".form-line").removeClass('focused');
    $("#XMaterno").find(".form-line").removeClass('focused');
    $("#XDireccion").find(".form-line").removeClass('focused');
    $("#XTelefono1").find(".form-line").removeClass('focused');
    $("#XTelefono2").find(".form-line").removeClass('focused');
    $('input[name="intSexo"][value="1"]').prop('checked', true);
    DOM.p_codigo_tipo_empleado.val("").selectpicker('refresh');
    DOM.p_ubicacion.val("").selectpicker('refresh');
}

function validar(){
    DOM.p_documento.keypress(function(e){
        return Validar.soloNumeros(e);
    });

    DOM.p_nombres.keypress(function(e){
        return Validar.soloLetras(e);
    });

    DOM.p_paterno.keypress(function(e){
        return Validar.soloLetras(e);
    });

    DOM.p_materno.keypress(function(e){
        return Validar.soloLetras(e);
    });

    DOM.p_telefono_uno.keypress(function(e){
        return Validar.soloNumeros(e);
    });

    DOM.p_telefono_dos.keypress(function(e){
        return Validar.soloNumeros(e);
    });

}

function setEventos() {
    validar();

	DOM.btnAgregar.click(function(e){
		DOM.self.find(".modal-title").text("Agregar nueva empleado");
		DOM.operacion.val("agregar");
        limpiar();
	});


    DOM.form.click(function(evento){
        evento.preventDefault();

        if ( DOM.p_documento.val() === '' ) {
            alert("Debe ingresar un numero de DNI");
            return 0;
        }

        if ( DOM.p_nombres.val() === '' ) {
            alert("Debe ingresar los nombres completos del empleado");
            return 0;
        }

        if ( DOM.p_paterno.val() === '' ) {
            alert("Debe ingresar el apellido paterno de empleado");
            return 0;
        }

        if ( DOM.p_materno.val() === '' ) {
            alert("Debe ingresar el apellido materno del empleado");
            return 0;
        }

        if ( DOM.p_codigo_tipo_empleado.val() === '' ) {
            alert("Debe ingresar un perfil para el empleado");
            return 0;
        }

        if ( DOM.p_ubicacion.val() === '' ) {
            alert("Debe ingresar una ubicación para el empleado");
            return 0;
        }

        var valor;

        for (var i = 0; i < $('input[name="intSexo"]').length; i++) {
               if ( $('input[name="intSexo"]')[i].checked ) {
                    valor = $('input[name="intSexo"]')[i].value;
               }
        }

        var funcion = function (resultado) {
            if (resultado.estado === 200) {
                if (resultado.datos.rpt === true) {
                    limpiar();
                    listar();
                    DOM.self.modal("hide");
                    Validar.alert("warning",resultado.datos.msj,2000);         
                }else{
                    Validar.alert("warning",resultado.datos.msj.errorInfo[2],2000);         
                }
            }    
        };         


        new Ajxur.Api({
            modelo: "Empleado",
            metodo: DOM.operacion.val(),
            data_in: {
                p_id : DOM.p_codigo_empleado.val(),
                p_dni : DOM.p_documento.val(),
                p_nombres : DOM.p_nombres.val(),
                p_apellido_paterno : DOM.p_paterno.val(),
                p_apellido_materno : DOM.p_materno.val(),
                p_direccion : DOM.p_direccion.val(),
                p_tele_uno : DOM.p_telefono_uno.val(),
                p_tele_dos : DOM.p_telefono_dos.val(),
                p_sexo : valor,
                p_id_tipo_empleado : DOM.p_codigo_tipo_empleado.val(),
                p_ubicacion : DOM.p_ubicacion.val()
            }
        }, funcion);
    });

    DOM.cboEstado.change(function () {
        listar();
    });

    DOM.cboTipoEmpleado.change(function(){
        listar();
    })
}



function listar(){
    var funcion = function (resultado) {
        if (resultado.estado === 200) {
            if (resultado.datos.rpt === true) {
                var html = "";
                html += '<table id="tabla-listado-categorias" class="table table-bordered table-striped display nowrap" cellspacing="0" width="100%">';                
                html += '<thead>';
                html += '<tr>';
                html += '<th style="text-align: center">DNI</th>';
                html += '<th style="text-align: center">Nombres y Apellidos</th>';
                html += '<th style="text-align: center">Dirección</th>';
                html += '<th style="text-align: center">Telefonos</th>';
                html += '<th style="text-align: center">OPCIONES</th>';
                html += '</tr>';
                html += '</thead>';
                html += '<tbody>';                
                $.each(resultado.datos.msj, function (i, item) {                 
                    html += '<tr>';                    
                    html += '<td align="center">' + item.dni + '</td>';
                    html += '<td align="center">' + item.nombres_apellidos + '</td>';
                    html += '<td align="center">' + item.direccion + '</td>';
                    html += '<td align="center">' + item.telefonos + '</td>';

                    html += '<td align="center">';
                    if ( item.estado == "1" ) {
                        html += '<button type="button" class="btn btn-xs bg-lime waves-effect" title="Editar categoria" onclick="leerDatos('+item.id+')" data-toggle="modal" href="#myModal"><i class="material-icons">edit</i></button>';
                        html += '&nbsp;&nbsp;';
                    }

                    var tmpEstado = item.estado != "1" ?
                        {icon: "up", title: "Habilitar", estado: "habilitar", bol: 1, boton: "btn-warning"} :
                        {icon: "down", title: "Deshabilitar", estado: "deshabilitar", bol: 0, boton: "btn-danger"};

                    html += '<button type="button" class="btn btn-xs '+tmpEstado.boton+' waves-effect" title="'+tmpEstado.title+' categoria" onclick="darBaja('+item.id+","+tmpEstado.bol+')"><i class="material-icons">thumb_'+tmpEstado.icon+'</i></button>';
                    html += '&nbsp;&nbsp;';

                    html += '</td>';
                    html += '</tr>';
                });
                html += '</tbody>';
                html += '<tfoot>';            
                html += '</tfoot>';
                html += '</table>';
                $("#listado").html(html);
                $("#tabla-listado-categorias").dataTable({
                    "responsive": true
                });
            }else{
                Validar.alert("warning",resultado.datos.msj.errorInfo[2],2000);         
            }    
        } 
    };
    new Ajxur.Api({
        modelo: "Empleado",
        metodo: "listar",
        data_in: {
            p_id_tipo_empleado : DOM.cboTipoEmpleado.val(),
            p_estado: DOM.cboEstado.val()
        }
    }, funcion);
}

function leerDatos(codigo_categoria){
    DOM.self.find(".modal-title").text("Editar datos de la categoria");
    DOM.operacion.val("editar");

    var funcion = function (resultado) {
        if (resultado.estado === 200) {
            if (resultado.datos.rpt === true) {
                var datos = resultado.datos.msj;
                DOM.p_codigo_empleado.val(datos.id);               
                DOM.p_documento.val(datos.dni);
                DOM.p_nombres.val(datos.nombres);
                DOM.p_paterno.val(datos.apellido_paterno);
                DOM.p_materno.val(datos.apellido_materno);
                DOM.p_direccion.val(datos.direccion);
                DOM.p_telefono_uno.val(datos.tele_uno);
                DOM.p_telefono_dos.val(datos.tele_dos);
                DOM.p_telefono_dos.val(datos.tele_dos);
                $('input[name="intSexo"][value="' + datos.sexo + '"]').prop('checked', true);
                DOM.p_codigo_tipo_empleado.val(datos.id_tipo_empleado).selectpicker('refresh');
                DOM.p_ubicacion.val(datos.ubicacion).selectpicker('refresh');
                                
                $("#XDocumento").find(".form-line").addClass('focused');              
                $("#XNombresCompletos").find(".form-line").addClass('focused');
                $("#XPaterno").find(".form-line").addClass('focused');
                $("#XMaterno").find(".form-line").addClass('focused');
                $("#XDireccion").find(".form-line").addClass('focused');

                datos.tele_uno === null ? $("#XTelefono1").find(".form-line").removeClass('focused') : $("#XTelefono1").find(".form-line").addClass('focused');    
                datos.tele_dos === null ? $("#XTelefono2").find(".form-line").removeClass('focused') : $("#XTelefono2").find(".form-line").addClass('focused');    

            }else{
                Validar.alert("warning",resultado.datos.msj.errorInfo[2],2000); 
            }            
        } 
    };

    new Ajxur.Api({
        modelo: "Empleado",
        metodo: "leerDatos",
        data_in: {
            p_id : codigo_categoria
        }
    }, funcion);
}

function darBaja(codigo_categoria,estado){
    var funcion = function (resultado) {
        if (resultado.estado === 200) {
            if (resultado.datos.rpt === true) {
                Validar.alert("warning",resultado.datos.msj,2000); 
                listar();
            }else{
                Validar.alert("warning",resultado.datos.msj.errorInfo[2],2000); 
            }            
        } 
    };

    new Ajxur.Api({
        modelo: "Empleado",
        metodo: "darBaja",
        data_in: {
            p_id : codigo_categoria,
            p_estado : estado
        }
    }, funcion);
}



function cargarTipoEmpleado(){
    var funcion = function (resultado) {        
        if (resultado.estado === 200) {
            if (resultado.datos.rpt === true) {
                var html = "";
                html = '<option value="" disabled selected>Seleccionar tipo de empleado</option>';
                               
                $.each(resultado.datos.msj, function (i, item) { 
                    html += '<option value="' + item.id + '">'+ item.descripcion + '</option>';
                });
                DOM.p_codigo_tipo_empleado.html(html).selectpicker('refresh');
            }else{
                Validar.alert("warning",resultado.datos.msj.errorInfo[2],2000); 
            }            
        }
    };

    new Ajxur.Api({
        modelo: "TipoEmpleado",
        metodo: "llenarCB"
    }, funcion);
}

function cargarTipoEmpleadoCB(){
    var funcion = function (resultado) {        
        if (resultado.estado === 200) {
            if (resultado.datos.rpt === true) {
                var html = "";               
                html += '<option value="*">TODOS</option>';
                $.each(resultado.datos.msj, function (i, item) { 
                    html += '<option value="' + item.id + '">'+ item.descripcion + '</option>';
                });
                DOM.cboTipoEmpleado.html(html).selectpicker('refresh'); 
            }else{
                Validar.alert("warning",resultado.datos.msj.errorInfo[2],2000); 
            }            
        }
    };

    new Ajxur.Api({
        modelo: "TipoEmpleado",
        metodo: "llenarCB"
    }, funcion);
}

function cargarUbicacion(){
    var funcion = function (resultado) {        
        if (resultado.estado === 200) {
            if (resultado.datos.rpt === true) {
                var html = "";
                html = '<option value="" disabled selected>Seleccionar Ubicación</option>';
                               
                $.each(resultado.datos.msj, function (i, item) { 
                    html += '<option value="' + item.id + '">'+ item.descripcion + '</option>';
                });
                DOM.p_ubicacion.html(html).selectpicker('refresh');
            }else{
                Validar.alert("warning",resultado.datos.msj.errorInfo[2],2000); 
            }            
        }
    };

    new Ajxur.Api({
        modelo: "Ubicaciones",
        metodo: "llenarCB"
    }, funcion);
}