var DOM = {};
$(document).ready(function () {
    setDOM();
    setEventos();
    
    cargarCategoria();
    cargarCategoriaCB();
    setTimeout(function(){ 
        listar(); 
    }, 100);
});
function setDOM() {
    DOM.p_codigo_producto = $("#intCodigoProducto"),
	DOM.p_nombre = $("#strNombre"),
    DOM.p_precio = $("#douPrecio"),
    DOM.p_codigo_categoria = $("#intCodigoCategoria"),
    DOM.p_descripcion = $("#strDescripcion"),

	DOM.self = $("#myModal"),
	DOM.btnAgregar = $("#btnAgregar"),
	DOM.operacion = $("#operacion"),
    DOM.cboEstado = $("#cboEstado"),
    DOM.cboCategoria = $("#cboCategoria"),

	DOM.form = $("#boton");
}

function limpiar(){
    DOM.p_codigo_producto.val("");
    DOM.p_nombre.val("");
    DOM.p_precio.val("");
    DOM.p_descripcion.val("");
    DOM.p_codigo_categoria.val("").selectpicker('refresh');
    $('#adjuntarImagen').attr('src','../../images/productos/defecto.jpg');
    $("#XNombre").find(".form-line").removeClass('focused');
    $("#XPrecio").find(".form-line").removeClass('focused');
    $("#XDescripcion").find(".form-line").removeClass('focused');
    
}

function validar(){
    DOM.p_nombre.keypress(function(e){
        return Validar.soloLetras(e);
    });

    DOM.p_precio.keypress(function(e){
        return Validar.numeroDecimal(e,DOM.p_precio.val(),2);
    })
}

function archivo(){
    if ( $("#archivoFoto")[0].files.length === 0 ) {
        $("#archivoFoto").val("");
        $('#adjuntarImagen').attr('src','../../images/productos/defecto.jpg');
    }else{
        cargarImagenFile($("#archivoFoto")[0]);
    }
}

function cargarImagenFile(input) {
    if (input.files && input.files[0]) {
        var reader = new FileReader();
        reader.onload = function(e) {
            $('#adjuntarImagen').attr('src', e.target.result);
        }
        reader.readAsDataURL(input.files[0]);
    }
}

function limpiarImagen(){
    $("#archivoFoto").val("");
    $('#adjuntarImagen').attr('src','../../images/productos/defecto.jpg');    
}


function setEventos() {   
    validar() ;

	DOM.btnAgregar.click(function(e){
		DOM.self.find(".modal-title").text("Agregar nueva producto");
		DOM.operacion.val("agregar");
        limpiar();
	});

    $("#archivoFoto").change(function(){
        archivo();
    });



    DOM.form.click(function(evento){
        evento.preventDefault();

        if ( DOM.p_nombre.val() === '' ) {            
            Validar.alert("warning","Debe ingresar una nombre para el producto",2000);
            return 0;
        }

        if ( DOM.p_precio.val() === '' ) {
            Validar.alert("warning","Debe ingresar un precio para el producto",2000);
            return 0;
        }

        if ( parseFloat(DOM.p_precio.val()) === 0 ) {
            Validar.alert("warning","Debe ingresar un precio mayor que cero para el producto",2000);
            return 0;
        };

        if ( DOM.p_codigo_categoria.val() === '' ) {
            Validar.alert("warning","Debe ingresar un categoría para el producto",2000);
            return 0;
        }

        if ( DOM.p_descripcion.val() === "" ) {
            Validar.alert("warning","Debe ingresar una descripción para el producto",2000);
            return 0;
        };

        var datos_frm = new FormData();
        datos_frm.append("p_foto", $("#archivoFoto").prop('files')[0]);        
        datos_frm.append("p_array_datos", $("#frm-grabar").serialize());

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
        $.ajax({
            url: "../../../servidor/ws/controlador.producto.php",
            dataType: 'json',
            cache: false,
            contentType: false,
            processData: false,
            data: datos_frm,
            type: 'post',
            success: funcion
        });
    
    });

    DOM.cboEstado.change(function () {
        listar();
    });

    DOM.cboCategoria.change(function () {
        listar();
    });
}

function listar(){
    var funcion = function (resultado) {
        if (resultado.estado === 200) {
            if (resultado.datos.rpt === true) {
                var html = "";
                html += '<table id="tabla-listado-productos" class="table table-bordered table-striped display nowrap" cellspacing="0" width="100%">';                
                html += '<thead>';
                html += '<tr>';
                html += '<th style="text-align: center">N°</th>';
                html += '<th style="text-align: center">Producto</th>';
                html += '<th style="text-align: center">Precio</th>';
                html += '<th style="text-align: center">OPCIONES</th>';
                html += '</tr>';
                html += '</thead>';
                html += '<tbody>';                
                $.each(resultado.datos.msj, function (i, item) {                 
                    html += '<tr>';
                    html += '<td align="center">' + (i+1) +'</td>';
                    html += '<td align="center">' + item.nombre + '</td>';
                    html += '<td align="center">' + item.precio + '</td>';
                    html += '<td align="center">';
                    if ( item.estado == "1" ) {
                        html += '<button type="button" class="btn btn-xs bg-lime waves-effect" title="Editar producto" onclick="leerDatos('+item.id+')" data-toggle="modal" href="#myModal"><i class="material-icons">edit</i></button>';
                        html += '&nbsp;&nbsp;';
                    }
                    var tmpEstado = item.estado != "1" ?
                        {icon: "up", title: "Habilitar", estado: "habilitar", bol: 1, boton: "btn-warning"} :
                        {icon: "down", title: "Deshabilitar", estado: "deshabilitar", bol: 0, boton: "btn-danger"};
                    html += '<button type="button" class="btn btn-xs '+tmpEstado.boton+' waves-effect" title="'+tmpEstado.title+' producto" onclick="darBaja('+item.id+","+tmpEstado.bol+')"><i class="material-icons">thumb_'+tmpEstado.icon+'</i></button>';
                    html += '&nbsp;&nbsp;';
                    html += '</td>';
                    html += '</tr>';
                });
                html += '</tbody>';
                html += '<tfoot>';            
                html += '</tfoot>';
                html += '</table>';
                $("#listado").html(html);
                $("#tabla-listado-productos").dataTable({
                    "responsive": true
                });
            }else{
                Validar.alert("warning",resultado.datos.msj.errorInfo[2],2000);
            }    
        } 
    };
    new Ajxur.Api({
        modelo: "Producto",
        metodo: "listar",
        data_in: {
            p_estado: DOM.cboEstado.val(),
            p_id_categoria : DOM.cboCategoria.val()
        }
    }, funcion);
}

function leerDatos(codigo_producto){
    DOM.self.find(".modal-title").text("Editar datos de la producto");
    DOM.operacion.val("editar");

    var funcion = function (resultado) {
        if (resultado.estado === 200) {
            if (resultado.datos.rpt === true) {
                var datos = resultado.datos.msj;
                DOM.p_codigo_producto.val(datos.id);               
                DOM.p_nombre.val(datos.nombre);
                DOM.p_precio.val(datos.precio);
                DOM.p_descripcion.val(datos.descripcion);
                DOM.p_codigo_categoria.val(datos.id_categoria).selectpicker('refresh');
                if ( datos.foto === 'defecto.jpg') {
                    $('#adjuntarImagen').attr('src','../../images/productos/defecto.jpg');
                }else{
                    $('#adjuntarImagen').attr('src','../../images/productos/'+datos.foto);
                }

                $("#XNombre").find(".form-line").addClass('focused');                 
                $("#XPrecio").find(".form-line").addClass('focused');  
                $("#XDescripcion").find(".form-line").addClass('focused');            
            }else{
                Validar.alert("warning",resultado.datos.msj.errorInfo[2],2000);
            }            
        } 
    };

    new Ajxur.Api({
        modelo: "Producto",
        metodo: "leerDatos",
        data_in: {
            p_id : codigo_producto
        }
    }, funcion);
}

function darBaja(codigo_producto,estado){
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
        modelo: "Producto",
        metodo: "darBaja",
        data_in: {
            p_id : codigo_producto,
            p_estado : estado
        }
    }, funcion);
}

function cargarCategoria(){
    var funcion = function (resultado) {        
        if (resultado.estado === 200) {
            if (resultado.datos.rpt === true) {
                var html = "";
                html = '<option value="" disabled selected>Seleccionar categoria</option>';
                               
                $.each(resultado.datos.msj, function (i, item) { 
                    html += '<option value="' + item.id + '">'+ item.nombre + '</option>';
                });
                DOM.p_codigo_categoria.html(html).selectpicker('refresh');
            }else{
                Validar.alert("warning",resultado.datos.msj.errorInfo[2],2000);
            }            
        }
    };

    new Ajxur.Api({
        modelo: "Categoria",
        metodo: "llenarCBM"
    }, funcion);
}

function cargarCategoriaCB(){
    var funcion = function (resultado) {        
        if (resultado.estado === 200) {
            if (resultado.datos.rpt === true) {
                var html = '<option value="*">TODAS</option>';               
                $.each(resultado.datos.msj, function (i, item) { 
                    html += '<option value="' + item.id + '">'+ item.nombre + '</option>';
                });
                DOM.cboCategoria.html(html).selectpicker('refresh'); 
            }else{
                Validar.alert("warning",resultado.datos.msj.errorInfo[2],2000);
            }            
        }
    };

    new Ajxur.Api({
        modelo: "Categoria",
        metodo: "llenarCBM"
    }, funcion);
}   