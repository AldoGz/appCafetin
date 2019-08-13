var DOM = {};
$(document).ready(function () {
    setDOM();
    setEventos();
    listar();   
});
function setDOM() {
    DOM.p_id = $("#intCodigoCategoria"),
    DOM.p_ticket = $("#strTicket"),
    DOM.p_descripcion = $("#strDescripcion"),
    DOM.p_fi = $("#strFechaInicio"),
    DOM.p_ff = $("#strFechaFin"),
    DOM.p_porcentaje = $("#strPorcentaje"),

	DOM.self = $("#myModal"),
	DOM.btnAgregar = $("#btnAgregar"),
	DOM.operacion = $("#operacion"),
    DOM.cboEstado = $("#cboEstado")

	DOM.form = $("#boton");
}

function limpiar(){
    DOM.p_id.val("");
    DOM.p_ticket.val("");
    DOM.p_descripcion.val("");
    DOM.p_fi.val("");    
    DOM.p_ff.val("");    
    DOM.p_porcentaje.val("");
    $("#XTicket").find(".form-line").removeClass('focused');
    $("#XDescripcion").find(".form-line").removeClass('focused');
    $("#XPorcentaje").find(".form-line").removeClass('focused');
}
function validar(){
    DOM.p_porcentaje.keypress(function(e){
        return Validar.numeroDecimal(e,DOM.p_porcentaje.val(),2);
    });
}

function setEventos() {
    validar();

	DOM.btnAgregar.click(function(e){
		DOM.self.find(".modal-title").text("Agregar nueva promoción bonus");
		DOM.operacion.val("agregar");
        limpiar();
	});

    DOM.form.click(function(evento){
        evento.preventDefault();

        if ( DOM.p_ticket.val() === '' ) {
            Validar.alert("warning","Debe ingresar un ticket para la promoción",2000);
            return 0;
        }

        if ( DOM.p_descripcion.val() === '' ) {
            Validar.alert("warning","Debe ingresar una descripción para la promoción",2000);
            return 0;
        }

        if ( DOM.p_fi.val() === '' ) {
            Validar.alert("warning","Debe ingresar la fecha de inicio para la promoción",2000);
            return 0;
        }

        if ( DOM.p_ff.val() === '' ) {
            Validar.alert("warning","Debe ingresar la fecha de fin para la promoción",2000);
            return 0;
        }

        if ( DOM.p_porcentaje.val() === '' ) {
            Validar.alert("warning","Debe ingresar el porcentaje de descuento para la promoción",2000);
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
            modelo: "PB",
            metodo: DOM.operacion.val(),
            data_in: {
                p_id : DOM.p_id.val(),
                p_ticket : DOM.p_ticket.val(),
                p_nombre : DOM.p_descripcion.val(),
                p_fecha_inicio : DOM.p_fi.val(),
                p_fecha_fin : DOM.p_ff.val(),
                p_porcentaje : DOM.p_porcentaje.val()

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
                html += '<th style="text-align: center">TICKET</th>';
                html += '<th style="text-align: center">Valides</th>';
                html += '<th style="text-align: center">Porcentaje</th>';
                html += '<th style="text-align: center">OPCIONES</th>';
                html += '</tr>';
                html += '</thead>';
                html += '<tbody>';                
                $.each(resultado.datos.msj, function (i, item) {                 
                    html += '<tr>';
                    html += '<td align="center">' + (i+1) +'</td>';
                    html += '<td align="center">' + item.ticket +'</td>';
                    html += '<td align="center">' + item.fecha_inicio + ' hasta ' + item.fecha_fin + '</td>';
                    html += '<td align="center">' + item.porcentaje + '</td>';

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
        modelo: "PB",
        metodo: "listar",
        data_in: {
            p_estado: DOM.cboEstado.val()
        }
    }, funcion);
}

function leerDatos(id){
    DOM.self.find(".modal-title").text("Editar datos de promoción bonus");
    DOM.operacion.val("editar");

    var funcion = function (resultado) {
        if (resultado.estado === 200) {
            if (resultado.datos.rpt === true) {
                var datos = resultado.datos.msj;
                DOM.p_id.val(datos.id);      
                DOM.p_ticket.val(datos.ticket);
                DOM.p_descripcion.val(datos.nombre);
                DOM.p_fi.val(datos.fecha_inicio);
                DOM.p_ff.val(datos.fecha_fin);
                DOM.p_porcentaje.val(datos.porcentaje);
                $("#XTicket").find(".form-line").addClass('focused');           
                $("#XDescripcion").find(".form-line").addClass('focused');           
                $("#XPorcentaje").find(".form-line").addClass('focused');           
            }else{
                Validar.alert("warning",resultado.datos.msj.errorInfo[2],2000);         
            }            
        } 
    };

    new Ajxur.Api({
        modelo: "PB",
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
        modelo: "PB",
        metodo: "darBaja",
        data_in: {
            p_id : id,
            p_estado : estado
        }
    }, funcion);
}

