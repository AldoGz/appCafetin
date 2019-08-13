var DOM = {};
$(document).ready(function () {
    setDOM();
    setEventos();
    listar();
});
function setDOM() {
    DOM.p_codigo_tipo_empleado = $("#intCodigoTipoEmpleado"),
	DOM.p_nombre = $("#strNombre"),

	DOM.self = $("#myModal"),
	DOM.btnAgregar = $("#btnAgregar"),
	DOM.operacion = $("#operacion"),
    DOM.cboEstado = $("#cboEstado")

	DOM.form = $("#boton");
}

function limpiar(){
    DOM.p_codigo_tipo_empleado.val("");
    DOM.p_nombre.val("");
    $("#XDescripcion").find(".form-line").removeClass('focused');
}

function validar(){
    DOM.p_nombre.keypress(function(e){
        return Validar.soloLetras(e);
    });
}

function setEventos() {    
    validar();
    
	DOM.btnAgregar.click(function(e){
		DOM.self.find(".modal-title").text("Agregar nueva tipo de empleado");
		DOM.operacion.val("agregar");
        limpiar();
	});


    DOM.form.click(function(evento){
        evento.preventDefault();

        if ( DOM.p_nombre.val() === '' ) {
            alert("Debe ingresar una nombre para la tipo de empleado");
            return 0;
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
            modelo: "TipoEmpleado",
            metodo: DOM.operacion.val(),
            data_in: {
                p_id : DOM.p_codigo_tipo_empleado.val(),
                p_descripcion : DOM.p_nombre.val()
            }
        }, funcion);
    });

    DOM.cboEstado.change(function () {
        listar();
    });
}

function listar(){
    var funcion = function (resultado) {
        if (resultado.estado === 200) {
            if (resultado.datos.rpt === true) {
                var html = "";
                html += '<table id="tabla-listado-TipoEmpleados" class="table table-bordered table-striped display nowrap" cellspacing="0" width="100%">';                
                html += '<thead>';
                html += '<tr>';
                html += '<th style="text-align: center">N°</th>';
                html += '<th style="text-align: center">TipoEmpleado</th>';
                html += '<th style="text-align: center">OPCIONES</th>';
                html += '</tr>';
                html += '</thead>';
                html += '<tbody>';                
                $.each(resultado.datos.msj, function (i, item) {                 
                    html += '<tr>';
                    html += '<td align="center">' + (i+1) +'</td>';
                    html += '<td align="center">' + item.descripcion + '</td>';

                    html += '<td align="center">';
                    if ( item.estado == "1" ) {
                        html += '<button type="button" class="btn btn-xs bg-lime waves-effect" title="Editar TipoEmpleado" onclick="leerDatos('+item.id+')" data-toggle="modal" href="#myModal"><i class="material-icons">edit</i></button>';
                        html += '&nbsp;&nbsp;';
                    }

                    var tmpEstado = item.estado != "1" ?
                        {icon: "up", title: "Habilitar", estado: "habilitar", bol: 1, boton: "btn-warning"} :
                        {icon: "down", title: "Deshabilitar", estado: "deshabilitar", bol: 0, boton: "btn-danger"};

                    html += '<button type="button" class="btn btn-xs '+tmpEstado.boton+' waves-effect" title="'+tmpEstado.title+' TipoEmpleado" onclick="darBaja('+item.id+","+tmpEstado.bol+')"><i class="material-icons">thumb_'+tmpEstado.icon+'</i></button>';
                    html += '&nbsp;&nbsp;';

                    html += '</td>';
                    html += '</tr>';
                });
                html += '</tbody>';
                html += '<tfoot>';            
                html += '</tfoot>';
                html += '</table>';
                $("#listado").html(html);
                $("#tabla-listado-TipoEmpleados").dataTable({
                    "responsive": true
                });
            }else{
                Validar.alert("warning",resultado.datos.msj.errorInfo[2],2000);         
            }    
        } 
    };
    new Ajxur.Api({
        modelo: "TipoEmpleado",
        metodo: "listar",
        data_in: {
            p_estado: DOM.cboEstado.val()
        }
    }, funcion);
}

function leerDatos(codigo_TipoEmpleado){
    DOM.self.find(".modal-title").text("Editar datos de la tipo de empleado");
    DOM.operacion.val("editar");

    var funcion = function (resultado) {
        if (resultado.estado === 200) {
            if (resultado.datos.rpt === true) {
                var datos = resultado.datos.msj;
                DOM.p_codigo_tipo_empleado.val(datos.id);               
                DOM.p_nombre.val(datos.descripcion);

                $("#XDescripcion").find(".form-line").addClass('focused');              
            }else{
                Validar.alert("warning",resultado.datos.msj.errorInfo[2],2000);         
            }            
        } 
    };

    new Ajxur.Api({
        modelo: "TipoEmpleado",
        metodo: "leerDatos",
        data_in: {
            p_id : codigo_TipoEmpleado
        }
    }, funcion);
}

function darBaja(codigo_TipoEmpleado,estado){
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
        modelo: "TipoEmpleado",
        metodo: "darBaja",
        data_in: {
            p_id : codigo_TipoEmpleado,
            p_estado : estado
        }
    }, funcion);
}