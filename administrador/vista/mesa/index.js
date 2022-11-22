var DOM = {};
$(document).ready(function () {
    setDOM();
    setEventos();
    cargarUbicacion();
    listar();
});
function setDOM() {
    DOM.p_codigo_mesa = $("#intCodigoMesa"),
	DOM.p_numero_mesa = $("#strNumero"),
    DOM.p_ubicacion = $("#intUbicacion"),

	DOM.self = $("#myModal"),
	DOM.btnAgregar = $("#btnAgregar"),
	DOM.operacion = $("#operacion"),
    DOM.cboEstado = $("#cboEstado"),

	DOM.form = $("#boton");
}

function limpiar(){
    DOM.p_codigo_mesa.val("");
    DOM.p_numero_mesa.val("");
    $("#XNumero").find(".form-line").removeClass('focused');
}

function setEventos() { 
	DOM.btnAgregar.click(function(e){
		DOM.self.find(".modal-title").text("Agregar nueva mesa");
		DOM.operacion.val("agregar");
        limpiar();
	});


    DOM.form.click(function(evento){
        evento.preventDefault();

        if ( DOM.p_numero_mesa.val() === '' ) {
            alert("Debe ingresar una nombre para la numero de mesa");
            return 0;
        }

        var funcion = function (resultado) {
            if (resultado.estado === 200) {
                if (resultado.datos.rpt === true) {
                    if ( resultado.datos.estado === true ) {
                        limpiar();
                        listar();
                        DOM.self.modal("hide");
                        Validar.alert("warning",resultado.datos.msj,2000);
                    }else{                        
                        Validar.alert("warning",resultado.datos.msj,2000);
                    }
                   
                }else{
                    Validar.alert("warning",resultado.datos.msj.errorInfo[2],2000);         
                }
            }    
        };         
        new Ajxur.Api({
            modelo: "Mesa",
            metodo: DOM.operacion.val(),
            data_in: {
                p_id : DOM.p_codigo_mesa.val(),
                p_numero : DOM.p_numero_mesa.val()
            }
        }, funcion);
    });

    DOM.cboEstado.change(function () {  
    console.log("SADSDASDASDASDA")      ;
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
                html += '<th style="text-align: center">Mesa</th>';
                html += '<th style="text-align: center">OPCIONES</th>';
                html += '</tr>';
                html += '</thead>';
                html += '<tbody>';                
                $.each(resultado.datos.msj, function (i, item) {                 
                    html += '<tr>';
                    html += '<td align="center">' + (i+1) +'</td>';
                    html += '<td align="center">' + item.numero + '</td>';

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
        modelo: "Mesa",
        metodo: "listar",
        data_in: {
            p_estado: DOM.cboEstado.val()
        }
    }, funcion);
}

function leerDatos(codigo_categoria){
    DOM.self.find(".modal-title").text("Editar datos de la mesa");
    DOM.operacion.val("editar");

    var funcion = function (resultado) {
        if (resultado.estado === 200) {
            if (resultado.datos.rpt === true) {
                var datos = resultado.datos.msj;
                DOM.p_codigo_mesa.val(datos.id);               
                DOM.p_numero_mesa.val(datos.numero);
                DOM.p_ubicacion.val(datos.ubicacion).selectpicker('refresh');

                $("#XNumero").find(".form-line").addClass('focused');              
            }else{
                Validar.alert("warning",resultado.datos.msj.errorInfo[2],2000);
            }            
        } 
    };

    new Ajxur.Api({
        modelo: "Mesa",
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
        modelo: "Mesa",
        metodo: "darBaja",
        data_in: {
            p_id : codigo_categoria,
            p_estado : estado
        }
    }, funcion);
}

function cargarUbicacion(){
    var funcion = function (resultado) {        
        if (resultado.estado === 200) {
            if (resultado.datos.rpt === true) {
                var html = "";
                html = '<option value="" disabled selected>Seleccionar Ubicación</option>';
                $.each(resultado.datos.msj, function (i, item) { 
                    if (i!=0){
                    html += '<option value="' + item.id + '">'+ item.descripcion + '</option>';
                    }
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