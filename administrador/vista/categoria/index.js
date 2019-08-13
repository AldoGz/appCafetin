var DOM = {};
$(document).ready(function () {
    setDOM();
    setEventos();
    listar();
    cargarTipoServicio();
});
function setDOM() {
    DOM.p_codigo_categoria = $("#intCodigoCategoria"),
	DOM.p_nombre = $("#strNombre"),
    DOM.p_id_tipo_servicio = $("#cboTipoServicio");

	DOM.self = $("#myModal"),
	DOM.btnAgregar = $("#btnAgregar"),
	DOM.operacion = $("#operacion"),
    DOM.cboEstado = $("#cboEstado")

	DOM.form = $("#boton");
}

function limpiar(){
    DOM.p_codigo_categoria.val("");
    DOM.p_nombre.val("");    
    DOM.p_id_tipo_servicio.val("").selectpicker('refresh');
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
		DOM.self.find(".modal-title").text("Agregar nueva categoria");
		DOM.operacion.val("agregar");
        limpiar();
	});

    DOM.form.click(function(evento){
        evento.preventDefault();

        if ( DOM.p_nombre.val() === '' ) {
            alert("Debe ingresar una nombre para la categoria");
            return 0;
        }

        if ( DOM.p_id_tipo_servicio.val() === '' ) {
            alert("Debe seleccionar tipo de servicio para la categoria");
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
            modelo: "Categoria",
            metodo: DOM.operacion.val(),
            data_in: {
                p_id : DOM.p_codigo_categoria.val(),
                p_descripcion : DOM.p_nombre.val(),
                p_id_tipo_servicio : DOM.p_id_tipo_servicio.val()
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
                html += '<table id="tabla-listado-categorias" class="table table-bordered table-striped display nowrap" cellspacing="0" width="100%">';                
                html += '<thead>';
                html += '<tr>';
                html += '<th style="text-align: center">N°</th>';
                html += '<th style="text-align: center">Categoria</th>';
                html += '<th style="text-align: center">OPCIONES</th>';
                html += '</tr>';
                html += '</thead>';
                html += '<tbody>';                
                $.each(resultado.datos.msj, function (i, item) {                 
                    html += '<tr>';
                    html += '<td align="center">' + (i+1) +'</td>';
                    html += '<td align="center">' + item.nombre + '</td>';

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
        modelo: "Categoria",
        metodo: "listar",
        data_in: {
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
                DOM.p_codigo_categoria.val(datos.id);               
                DOM.p_nombre.val(datos.nombre);
                DOM.p_id_tipo_servicio.val(datos.id_tipo_servicio).selectpicker('refresh');
                $("#XDescripcion").find(".form-line").addClass('focused');              
            }else{
                Validar.alert("warning",resultado.datos.msj.errorInfo[2],2000);         
            }            
        } 
    };

    new Ajxur.Api({
        modelo: "Categoria",
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
        modelo: "Categoria",
        metodo: "darBaja",
        data_in: {
            p_id : codigo_categoria,
            p_estado : estado
        }
    }, funcion);
}

function cargarTipoServicio(){
    var funcion = function (resultado) {        
        if (resultado.estado === 200) {
            if (resultado.datos.rpt === true) {
                var html = '<option value="" selected>Seleccionar tipo de servicio</option>';               
                $.each(resultado.datos.msj, function (i, item) { 
                    html += '<option value="' + item.id + '">'+ item.nombre + '</option>';
                });
                DOM.p_id_tipo_servicio.html(html).selectpicker('refresh'); 
            }else{
                Validar.alert("warning",resultado.datos.msj.errorInfo[2],2000);         
            }            
        }
    };

    new Ajxur.Api({
        modelo: "TipoServicio",
        metodo: "llenarCB"
    }, funcion);
}   