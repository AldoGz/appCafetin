var DOM = {};
$(document).ready(function () {
    setDOM();
    setEventos();
    listar();
    cargarTipoComprobante();
});
function setDOM() {

    DOM.p_codigo_serie_comprobante = $("#codigo_serie_comprobante");
    DOM.p_tipo_comprobante  = $("#cboTipoComprobante");
    DOM.p_numero_correlativo = $("#numeroCorrelativo");

	DOM.self = $("#myModal"),
	DOM.btnAgregar = $("#btnAgregar"),
	DOM.operacion = $("#operacion"),
    DOM.cboEstado = $("#cboEstado")

	DOM.form = $("#boton");
}

function limpiar(){
    DOM.p_codigo_serie_comprobante.val("");
    DOM.p_numero_correlativo.val("");    
    DOM.p_tipo_comprobante.val("").selectpicker('refresh');
    $("#XDescripcion").find(".form-line").removeClass('focused');
}



function setEventos() {
    DOM.p_numero_correlativo.keypress(function(e){
        return Validar.soloNumeros(e);
    });

	DOM.btnAgregar.click(function(e){
		DOM.self.find(".modal-title").text("Agregar nueva categoria");
		DOM.operacion.val("agregar");
        limpiar();
	});

    DOM.form.click(function(evento){
        evento.preventDefault();

        if ( DOM.p_tipo_comprobante.val() === '' ) {
            alert("Debe ingresar una nombre para la categoria");
            return 0;
        }

        if ( DOM.p_numero_correlativo.val() === '' ) {
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
            modelo: "SerieComprobante",
            metodo: DOM.operacion.val(),
            data_in: {
                p_id : DOM.p_codigo_serie_comprobante.val(),
                p_tipo_comprobante : DOM.p_tipo_comprobante.val(),
                p_numero : DOM.p_numero_correlativo.val()
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
                html += '<th style="text-align: center">Tipo comprobante</th>';
                html += '<th style="text-align: center">Serie</th>';
                html += '<th style="text-align: center">Correlativo</th>';
                html += '<th style="text-align: center">OPCIONES</th>';
                html += '</tr>';
                html += '</thead>';
                html += '<tbody>';                
                $.each(resultado.datos.msj, function (i, item) {                 
                    html += '<tr>';
                    html += '<td align="center">' + (i+1) +'</td>';
                    html += '<td align="center">' + item.tipo_comprobante + '</td>';
                    html += '<td align="center">' + item.numero + '</td>';
                    html += '<td align="center">' + item.correlativo + '</td>';

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
        modelo: "SerieComprobante",
        metodo: "listar",
        data_in: {
            p_estado: DOM.cboEstado.val()
        }
    }, funcion);
}

function leerDatos(id){
    DOM.self.find(".modal-title").text("Editar datos de serie comprobante");
    DOM.operacion.val("editar");


    var funcion = function (resultado) {
        if (resultado.estado === 200) {
            if (resultado.datos.rpt === true) {
                var datos = resultado.datos.msj;
                DOM.p_codigo_serie_comprobante.val(datos.id);               
                DOM.p_numero_correlativo.val(datos.numero);
                DOM.p_tipo_comprobante.val(datos.id_tipo_comprobante).selectpicker('refresh');
                $("#XDescripcion").find(".form-line").addClass('focused');              
            }else{
                Validar.alert("warning",resultado.datos.msj.errorInfo[2],2000);         
            }            
        } 
    };

    new Ajxur.Api({
        modelo: "SerieComprobante",
        metodo: "leerDatos",
        data_in: {
            p_id : id
        }
    }, funcion);
}

function darBaja(id,estado){
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
        modelo: "SerieComprobante",
        metodo: "darBaja",
        data_in: {
            p_id : id,
            p_estado : estado
        }
    }, funcion);
}

function cargarTipoComprobante(){
    var funcion = function (resultado) {        
        if (resultado.estado === 200) {
            if (resultado.datos.rpt === true) {
                var html = '<option value="" selected>Seleccionar tipo de servicio</option>';               
                $.each(resultado.datos.msj, function (i, item) { 
                    html += '<option value="' + item.id + '">('+item.abreviatura+') '+item.nombre + '</option>';
                });
                DOM.p_tipo_comprobante.html(html).selectpicker('refresh'); 
            }else{
                Validar.alert("warning",resultado.datos.msj.errorInfo[2],2000);         
            }            
        }
    };

    new Ajxur.Api({
        modelo: "Comprobante",
        metodo: "llenarCB"
    }, funcion);
}   