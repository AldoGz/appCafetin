var DOM = {};
$(document).ready(function () {
    setDOM();
    setEventos();
    listar();
    cargarProducto();
});
function setDOM() {
    DOM.p_id = $("#intCodigoCategoria"),
    DOM.p_id_producto = $("#cboProducto"),
    DOM.p_cantidad_puntos = $("#strCantidadPuntos"),
    DOM.p_cantidad_producto = $("#strCantidadProducto"),

	DOM.self = $("#myModal"),
	DOM.btnAgregar = $("#btnAgregar"),
	DOM.operacion = $("#operacion"),
    DOM.cboEstado = $("#cboEstado")

	DOM.form = $("#boton");
}

function limpiar(){
    DOM.p_id.val("");
    DOM.p_id_producto.val("").selectpicker('refresh');
    DOM.p_cantidad_puntos.val("");
    DOM.p_cantidad_producto.val("");
    $("#XQPU").find(".form-line").removeClass('focused');
    $("#XQPP").find(".form-line").removeClass('focused');
}
function validar(){
    DOM.p_cantidad_puntos.keypress(function(e){
        return Validar.soloNumeros(e);
    });

    DOM.p_cantidad_producto.keypress(function(e){
        return Validar.soloNumeros(e);
    });
}

function setEventos() {
    validar();

	DOM.btnAgregar.click(function(e){
		DOM.self.find(".modal-title").text("Agregar nueva promocion por puntos");
		DOM.operacion.val("agregar");
        limpiar();
	});

    DOM.form.click(function(evento){
        evento.preventDefault();

        

        if ( DOM.p_id_producto.val() === '' ) {
            alert("Debe seleccionar un producto");
            return 0;
        }

        if ( DOM.p_cantidad_puntos.val() === '' ) {
            alert("Debe ingresar la cantidad de puntos");
            return 0;
        }

        if ( DOM.p_cantidad_producto.val() === '' ) {
            alert("Debe ingresar la cantidad de productos");
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
            modelo: "PP",
            metodo: DOM.operacion.val(),
            data_in: {
                p_id : DOM.p_id.val(),
                p_cantidad_puntos : DOM.p_cantidad_puntos.val(),
                p_cantidad_producto : DOM.p_cantidad_producto.val(),
                p_id_producto : DOM.p_id_producto.val()
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
                html += '<th style="text-align: center">Producto</th>';
                html += '<th style="text-align: center">Cantidad de puntos</th>';                
                html += '<th style="text-align: center">OPCIONES</th>';
                html += '</tr>';
                html += '</thead>';
                html += '<tbody>';                
                $.each(resultado.datos.msj, function (i, item) {                 
                    html += '<tr>';
                    html += '<td align="center">' + (i+1) +'</td>';
                    html += '<td align="center">' + '('+item.cantidad_producto+') '+item.producto + '</td>';
                    html += '<td align="center">' + item.cantidad_puntos + '</td>';

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
        modelo: "PP",
        metodo: "listado",
        data_in: {
            p_estado: DOM.cboEstado.val()
        }
    }, funcion);
}

function leerDatos(id){
    DOM.self.find(".modal-title").text("Editar datos de la promoción por puntos");
    DOM.operacion.val("editar");

    var funcion = function (resultado) {
        if (resultado.estado === 200) {
            if (resultado.datos.rpt === true) {
                var datos = resultado.datos.msj;
                DOM.p_id.val(datos.id);               
                DOM.p_cantidad_puntos.val(datos.cantidad_puntos);
                DOM.p_cantidad_producto.val(datos.cantidad_producto);
                DOM.p_id_producto.val(datos.id_producto).selectpicker('refresh');
                $("#XQPU").find(".form-line").addClass('focused'); 
                $("#XQPP").find(".form-line").addClass('focused');           
            }else{
                Validar.alert("warning",resultado.datos.msj.errorInfo[2],2000);         
            }            
        } 
    };

    new Ajxur.Api({
        modelo: "PP",
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
        modelo: "PP",
        metodo: "darBaja",
        data_in: {
            p_id : id,
            p_estado : estado
        }
    }, funcion);
}

function cargarProducto(){
    var funcion = function (resultado) {        
        if (resultado.estado === 200) {
            if (resultado.datos.rpt === true) {
                var html = '<option value="" selected>Seleccionar tipo de servicio</option>';               
                $.each(resultado.datos.msj, function (i, item) { 
                    html += '<option value="' + item.id + '">'+ item.nombre + '</option>';
                });
                DOM.p_id_producto.html(html).selectpicker('refresh'); 
            }else{
                Validar.alert("warning",resultado.datos.msj.errorInfo[2],2000);         
            }            
        }
    };

    new Ajxur.Api({
        modelo: "Producto",
        metodo: "llenarCBT"
    }, funcion);
}   