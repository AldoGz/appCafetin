var DOM = {};

$(document).ready(function () {
    
    setDOM();
    cargarAll();
    listarCocina();
    listarBar();
    setEventos();
    cargarMesas();
    bloque(1);
    refrescarMesa();
    cantidadEditar();
    listarPromociones();
    cargarComboMesas();
});


function setDOM(){
    DOM.blkSinAcciones = $("#blkSinAcciones"),
    DOM.blkPedido = $("#blkPedido"),
    DOM.blkObservaciones = $("#blkObservaciones"),
    DOM.blkEspera = $("#blkEnEspera");
    DOM.blkEntregar = $("#blkEntregar");
    DOM.blkPuntos = $("#blkPuntos");
    DOM.blkOtrasAcciones = $("#blkOtrasAcciones");
    DOM.blkNombreCliente = $("#blkNombreCliente"),
    DOM.codigo_mesa = $("#codigo_mesa");
    DOM.mesa = $("#mesa");
    DOM.estado_convencional = $("#estado_convencional");
    DOM.nombre_cliente = $("#nombre_cliente");
    DOM.listado_mesas = $("#listado-mesas");
    /*NUEVO*/
    DOM.listado_cocina = $("#listado_cocina");
    DOM.listado_bar = $("#listado_bar");
    DOM.modal_producto = $("#modal-producto");
    DOM.modal_producto_descripcion = $("#modal-producto-descripcion");
    DOM.modal_producto_foto = $("#modal-producto-foto");
    DOM.total_pedido_mesa = $("#total_pedido_mesa"); 
    DOM.titulo_pedido = $("#titulo-pedido");
    DOM.titulo_producto = $("#titulo_producto");
    DOM.foto_producto = $("#foto_producto");
    DOM.codigo_producto = $("#codigo_producto");
    DOM.nodo = $("#nodo");
    DOM.observaciones = $("#observaciones");
    DOM.utensilios = $("#utensilios");
    DOM.operacion = $("#operacion");
    DOM.parametro = $("#parametro");
    DOM.modal_confirmacion = $("#modal_confirmacion");
    DOM.array = [];
    DOM.listado_pedido_espera = $("#listado_pedido_espera");
    DOM.listado_pedido_mozo =$("#listado_pedido_mozo");
    DOM.listado_pedido_entrega = $("#listado_pedido_entrega");
    DOM.importe_espera = $("#importe_espera");
    DOM.importe_espera_mozo = $("#importe_espera_mozo");
    DOM.importe_entrega = $("#importe_entrega");
    DOM.modal_editar_pedido = $("#modal-editar-pedido");
    DOM.codigo_pedido = $("#codigo_pedido");
    DOM.cantidad_pedido = $("#cantidad_pedido");
    DOM.precio_pedido = $("#precio_pedido");
    DOM.importe_pedido = $("#importe_pedido");
    DOM.observaciones_pedido = $("#observaciones_pedido");
    DOM.btnEditarPedido = $("#btnEditarPedido");
    DOM.texto_documento = $("#texto_documento");
    DOM.listado_promociones = $("#listado_promociones");
    DOM.listado_consulta = $("#listado_consulta");

    DOM.modal_sub_producto = $("#modal-sub-producto");
    DOM.modal_observaciones_sub_producto = $("#modal-observaciones-sub-producto");

    DOM.codigo_producto_sub = $("#codigo_producto_sub")
    DOM.nodo_sub = $("#nodo_sub");
    DOM.foto_producto_sub = $("#foto_producto_sub");
    DOM.utensilios_sub = $("#utensilios_sub");
    DOM.observaciones_sub  = $("#observaciones_sub");
    DOM.posicion_sub = $("#posicion_sub");
    DOM.tb_producto_categoria = $("#tb_producto_categoria");

    DOM.sesion = ""; 
    DOM.ubicacion="";

    DOM.btnPedirMesero = $("#btn-pedir-mesero");

    DOM.cboMesasLiberar = $("#mesas_liberar");
    DOM.cboMesasConsultar = $("#mesas_consultar");
    DOM.cboMesasDestino = $("#mesas_destino");
    

}

function bloque(tipo){
    switch(tipo){
        case 1:
            DOM.blkSinAcciones.show();
            DOM.blkPedido.hide();
            DOM.blkObservaciones.hide();
            DOM.blkEspera.hide();
            DOM.blkEntregar.hide();
            DOM.blkPuntos.hide();
            DOM.blkOtrasAcciones.hide();
            break;
        case 2:
            DOM.blkSinAcciones.hide();
            DOM.blkPedido.show();
            DOM.blkObservaciones.hide();
            DOM.blkEspera.hide();
            DOM.blkEntregar.hide();
            DOM.blkPuntos.hide();
            DOM.blkOtrasAcciones.hide();
            break;
        case 3:
            DOM.blkSinAcciones.hide();
            DOM.blkPedido.hide();
            DOM.blkObservaciones.show();
            DOM.blkEspera.hide();
            DOM.blkEntregar.hide();
            DOM.blkPuntos.hide();
            DOM.blkOtrasAcciones.hide();
            break;
        case 4:
            DOM.blkSinAcciones.hide();
            DOM.blkPedido.hide();
            DOM.blkObservaciones.hide();
            DOM.blkEspera.show();
            DOM.blkEntregar.hide();
            DOM.blkPuntos.hide();
            DOM.blkOtrasAcciones.hide();
            break;
        case 5:
            DOM.blkSinAcciones.hide();
            DOM.blkPedido.hide();
            DOM.blkObservaciones.hide();
            DOM.blkEspera.hide();
            DOM.blkEntregar.show();
            DOM.blkPuntos.hide();
            DOM.blkOtrasAcciones.hide();
            break;
        case 6: //  PUNTOS
            DOM.blkSinAcciones.hide();
            DOM.blkPedido.hide();
            DOM.blkObservaciones.hide();
            DOM.blkEspera.hide();
            DOM.blkEntregar.hide();
            DOM.blkPuntos.show();
            DOM.blkOtrasAcciones.hide();
            break;
        case 7: //  ACCIONES
            DOM.blkSinAcciones.hide();
            DOM.blkPedido.hide();
            DOM.blkObservaciones.hide();
            DOM.blkEspera.hide();
            DOM.blkEntregar.hide();
            DOM.blkPuntos.hide();
            DOM.blkOtrasAcciones.show();
            break;
    }
}

function listarBar(){
    var funcion = function (resultado) {        
        if (resultado.estado === 200) {
            if ( resultado.datos.rpt === true ){
                
                var html = "";
                $.each(resultado.datos.msj.categorias, function(i,item){
                    html += '<div class="col-md-12" style="margin:10 0 10 0;">';
                        html += '<div class="card">';
                            html += '<div class="card-header" style="background:#6c757d;color:white;"><h5>'+item.nombre+'</h5></div>';
                            html += '<div class="card-body listado_producto_bar">';
                                    $.each(resultado.datos.msj.productos, function(key,value){
                                        if ( item.id === value.id_categoria) {                                            
                                            html += '<div class="row" style="margin: 15 0 15 0;">';
                                                
                                                html += '<div class="col-md-7"  style="cursor: pointer;" onclick="abrirProductoDescripcion('+value.id+')">';                        
                                                html += '<h5 class="text-right">'+value.nombre+'</h5>';
                                                html += '</div>';
                                                html += '<div class="col-md-2">';
                                                    html += '<input class="form-control form-control-sm producto_precio" type="hidden" value="'+value.precio+'">'; 
                                                    html += '<select class="form-control form-control-sm producto_cantidad" style="text-align-last:center;" onchange="is(this,'+value.id+',0)">';
                                                        html += cboCantidad(); 
                                                    html += '</select>';  
                                                    html += '<input class="form-control form-control-sm id_producto" type="hidden" value="'+value.id+'">'; 
                                                html += '</div>';
                                                html += '<div class="col-md-1">';
                                                    html += '<button type="button" class="btn btn-primary btn-block" onclick="abrirObservaciones(this,'+value.id+',0)"><i class="fas fa-search"></i></button>'  
                                                html += '</div>';
                                                html += '<div class="col-md-2">';
                                                    html += '<input type="text" class="form-control form-control-sm producto_total" value="S/. 0.00" style="text-align-last:center;" disabled>';                                 
                                                html += '</div>';
                                            html += '</div>';
                                        }
                                    });
                            html += '</div>';
                        html += '</div>';
                    html += '</div>';
                });
                DOM.listado_bar.html(html);
            } else{
                Validar.alert("warning",resultado.datos.msj.errorInfo[2],2000);                                
            }           
        }
    }

    new Ajxur.Api({
        modelo: "Producto",
        metodo: "listarProductos",
        data_out : [ 1 ]        
    }, funcion);
}

function buscar_consulta(){
    var funcion = function (resultado) {        
        if (resultado.estado === 200) {
            if ( resultado.datos.rpt === true ){
                var html = "";
                if ( resultado.datos.msj == false || resultado.datos.msj.documento == "" ) {
                    html += '<tr><td class="text-center" colspan="3">SIN RESULTADOS</td></tr>';
                }else{                    
                    html += '<tr>';
                        html += '<td class="text-center">'+resultado.datos.msj.documento+'</td>';
                        html += '<td class="text-center">'+resultado.datos.msj.razon_social+'</td>';
                        html += '<td class="text-center">'+resultado.datos.msj.puntos+'</td>';
                    html += '</tr>';
                }
                DOM.listado_consulta.html(html);
            } else{
                Validar.alert("warning",resultado.datos.msj.errorInfo[2],2000);                                
            }           
        }
    }

    new Ajxur.Api({
        modelo: "PP",
        metodo: "consultarPP",
        data_out : [DOM.texto_documento.val()]
    }, funcion);
}

function limpiar_consulta(){
    DOM.texto_documento.val("");
    DOM.listado_consulta.html('<tr><td class="text-center" colspan="3">SIN RESULTADOS</td></tr>');
}

function listarPromociones(){
    var funcion = function (resultado) {        
        if (resultado.estado === 200) {
            if ( resultado.datos.rpt === true ){
                var html = "";
                $.each(resultado.datos.msj, function(i,item){
                    html += '<tr>';
                        html += '<td class="text-center">'+(i+1)+'</td>';
                        html += '<td class="text-center">'+item.producto+'</td>';
                        html += '<td class="text-center">'+item.cantidad_puntos+'</td>';
                    html += '</tr>';
                });
                DOM.listado_promociones.html(html);
            } else{
                Validar.alert("warning",resultado.datos.msj.errorInfo[2],2000);                                
            }           
        }
    }

    new Ajxur.Api({
        modelo: "PP",
        metodo: "listar"       
    }, funcion);  
}

function listarCocina(){
    var funcion = function (resultado) {        
        if (resultado.estado === 200) {
            if ( resultado.datos.rpt === true ){
                var html = "";
                var modal = "";
                $.each(resultado.datos.msj.categorias, function(i,item){
                    html += '<div class="col-md-12" style="margin:10 0 10 0;">';
                        html += '<div class="card">';
                            if ( parseInt(item.id) > 2 ) {   
                                html += '<div class="card-header" style="background:#6c757d;color:white;"><h5>'+item.nombre+'</h5></div>';
                            }else{
                                html += '<div class="card-header" style="background:#6c757d;color:white;">';
                                    html += '<div class="row">';
                                        html += '<div class="col-md-11">'
                                            html += '<h5>'+item.nombre+'</h5>';        
                                        html += '</div>';
                                        html += '<div class="col-md-1">';
                                            html += '<button style="background: #6c757d;border: 0px solid; color:white;" type="button" class="btn btn-light btn-block" data-toggle="modal" data-target="#modal-sub-'+item.nombre.toLowerCase()+'"><i class="fas fa-plus"></i></button>';
                                        html += '</div>';
                                    html += '</div>';
                                html += '</div>';

                                modal += '<div class="modal fade"  role="dialog" data-backdrop="static" data-keyboard="false" id="modal-sub-'+item.nombre.toLowerCase()+'">';
                                    modal += '<div class="modal-dialog modal-lg modal-dialog-centered">';
                                        modal += '<div class="modal-content">';
                                            modal += '<div class="modal-header">';
                                                modal += '<div class="col-md-8">';
                                                    modal += '<h5 class="modal-title">'+item.nombre+'</h5>';
                                                modal += '</div>';
                                                modal += '<div class="col-md-3">';
                                                    modal += '<input class="form-control form-control-sm total-sub-total" disabled value="S/. 0.00" style="text-align-last:center;">';
                                                modal += '</div>';
                                                 modal += '<div class="col-md-1">';
                                                    modal += '<button type="button" class="btn btn-danger btn-block" data-dismiss="modal" aria-label="Close"><i class="fas fa-times"></i></button>';
                                                modal += '</div>';
                                            modal += '</div>';
                                            modal += '<div class="modal-body"  style="height: 500px;overflow-x:hidden;overflow-y:scroll;white-space:nowrap">';
                                                modal += '<div id="precio-platos-productos-'+item.nombre.toLowerCase()+'"></div>';
                                                modal += '<div class="col-md-12">';                                                    
                                                    modal += '<table class="table table-bordered" id="listado-platos-producto-'+item.nombre.toLowerCase()+'"></table>';
                                                modal += '</div>';
                                            modal += '</div>'
                                        modal += '</div>';
                                    modal += '</div>';
                                modal += '</div>'; 
                                tabla(item.id,10,item.nombre.toLowerCase());
                            } 
            
                            html += '<div class="card-body listado_producto_cocina">';
                                    $.each(resultado.datos.msj.productos, function(key,value){
                                        if ( item.id === value.id_categoria) {
                                            if ( parseInt(item.id) > 2 ) {              
                                                html += '<div class="row" style="margin: 15 0 15 0;">';
                                                    
                                                    html += '<div class="col-md-7"  style="cursor: pointer;" onclick="abrirProductoDescripcion('+value.id+')">';                        
                                                        html += '<h5 class="text-right" >'+value.nombre+'</h5>';
                                                    html += '</div>';
                                                    html += '<div class="col-md-2">';
                                                        html += '<input class="form-control form-control-sm producto_precio" type="hidden" value="'+value.precio+'">'; 
                                                        html += '<select class="form-control form-control-sm producto_cantidad" style="text-align-last:center;" onchange="is(this,'+value.id+',0)">';
                                                            html += cboCantidad(); 
                                                        html += '</select>'; 
                                                        html += '<input class="form-control form-control-sm id_producto" type="hidden" value="'+value.id+'">'; 
                                                    html += '</div>';
                                                    html += '<div class="col-md-1">';
                                                        html += '<button type="button" class="btn btn-primary btn-block" onclick="abrirObservaciones(this,'+value.id+',0)"><i class="fas fa-search"></i></button>'  
                                                    html += '</div>';
                                                    html += '<div class="col-md-2">';
                                                        html += '<input type="text" class="form-control form-control-sm producto_total" value="S/. 0.00" style="text-align-last:center;" disabled>';                                 
                                                    html += '</div>';
                                                html += '</div>';
                                            }else{
                                                html += '<div class="row" style="margin: 15 0 15 0;">';
                                                    
                                                    html += '<div class="col-md-7"  style="cursor: pointer;" onclick="abrirProductoDescripcion('+value.id+')">';                        
                                                        html += '<h5 class="text-right" >'+value.nombre+'</h5>';
                                                    html += '</div>';
                                                    html += '<div class="col-md-1"></div>';
                                                    html += '<div class="col-md-2">';
                                                        html += '<input class="form-control form-control-sm producto_precio_sub_total" type="hidden" value="'+value.precio+'">'; 
                                                        html += '<input data-id="'+key+'" type="text" class="form-control form-control-sm cantidad_producto_sub_total" value="0" style="text-align-last:center;" disabled>';                                  
                                                    html += '</div>';
                                                    html += '<div class="col-md-2">';
                                                        html += '<input type="text" class="form-control form-control-sm precio_producto_sub_total" value="S/. 0.00" style="text-align-last:center;" disabled>';                                 
                                                    html += '</div>';
                                                html += '</div>';
                                            }
                                        }
                                    });
                            html += '</div>';
                        html += '</div>';
                    html += '</div>';
                });
                DOM.listado_cocina.html(html);
                DOM.modal_sub_producto.html(modal);
            } else{
                Validar.alert("warning",resultado.datos.msj.errorInfo[2],2000);                                
            }           
        }
    }

    new Ajxur.Api({
        modelo: "Producto",
        metodo: "listarProductos",
        data_out : [ 2 ]        
    }, funcion);  
}

function tabla(id,numero,ref){
    var funcion = function (resultado) {        
        if (resultado.estado === 200) {
            if (resultado.datos.rpt === true) {  
                var html = '';
                html += '<thead>';
                    html += '<tr>';
                        html += '<th></th>';
                        $.each(resultado.datos.msj, function(i,item){
                            html += '<th class="text-center">'+item.nombre+'</th>';
                        });
                        html += '<th></th>';
                    html += '</tr>';                    
                html += '</thead>';
                html += '<tbody>';
                    for (var i = 1; i <= numero ; i++ ) {
                        html += '<tr>';                            
                            html += '<th class="text-center">Plato '+i+'</th>';
                            $.each(resultado.datos.msj, function(j,item){
                                html += '<td class="text-center">';
                                    html += '<div class="form-group row">';
                                        html += '<div class="col-md-8">';                                            
                                            html += '<input type="hidden" value="'+item.precio+'" disabled>';
                                            html += '<select data-id="'+j+'" class="form-control form-control-sm producto_cantidad_grupo" style="text-align-last:center;">';
                                                html += cboCantidad(); 
                                            html += '</select>';
                                            html += '<input type="hidden" value="'+item.id+'" disabled>';
                                        html += '</div>'; 
                                        html += '<div class="col-md-4">';
                                            html += '<button type="button" class="btn btn-primary btn-block" onclick="abrirObservacionesSubProducto(this,'+item.id+',1,'+i+')"><i class="fas fa-search"></i></button>';
                                        html += '</div>'; 
                                    html += '</div>';
                                html += '</td>';
                            }); 
                            html += '<th class="text-center precio_total_grupo">S/. 0.00</th>';
                        html += '</tr>';
                    }
                html += '</tbody>';
                $("#listado-platos-producto-"+ref).html(html);                
            }else{
                Validar.alert("warning",resultado.datos.msj.errorInfo[2],2000);
            }            
        }
    }
    new Ajxur.Api({
        modelo: "Producto",
        metodo: "listarProductoCategoria",
        data_out : [id]
    }, funcion);

}

function abrirProductoDescripcion(id){    
    DOM.modal_producto.modal("show");
    var funcion = function (resultado) {        
        if (resultado.estado === 200) {
            if (resultado.datos.rpt === true) {  
                DOM.modal_producto.find(".modal-title").text(resultado.datos.msj.nombre);
                DOM.modal_producto_descripcion.text(resultado.datos.msj.descripcion);
                DOM.modal_producto_foto.attr('src','../../administrador/images/productos/'+resultado.datos.msj.foto);
                DOM.modal_producto_foto.attr('width','300');
                DOM.modal_producto_foto.attr('height','250');
            }else{
                Validar.alert("warning",resultado.datos.msj.errorInfo[2],2000);
            }            
        }
    }
    new Ajxur.Api({
        modelo: "Producto",
        metodo: "leerDatos",
        data_in : {
            p_id : id
        }
    }, funcion);
}

function cboCantidad(){
    var html = '';
    for (var i = 0; i <= 100 ; i++) {
        html += '<option value="'+i+'">'+i+'</option>';
    }
    return html;
}

function tomaPedido(tipo, self){
    $.each(self.find(".producto_cantidad"),function(i,item){
        self.find(".producto_total")[i].value = "S/. "+parseFloat(parseFloat(self.find(".producto_precio")[i].value)*$(this)[0].selectedIndex).toFixed(2);        
    });
    if ( tipo ) {
        $.each(self.find(".grupo_producto"), function(i,item){
            var selfs = $(this);
            var _cantidad_ = 0;
            $.each(selfs.find(".producto_cantidad_grupo"), function(key, value){
                _cantidad_ += $(this)[0].selectedIndex;
            });            
            self.find(".producto_total_grupo")[i].value = "S/. "+parseFloat(parseFloat(self.find(".producto_precio_grupo")[i].value)*_cantidad_).toFixed(2);            
            
        });
    } 

}

function importe_toma_pedido(self1,self2){
    var suma = 0;    
    $.each(self1.find(".producto_total"), function(i,item){
        suma += parseFloat($(this)[0].value.split(" ")[1]);
    });
    $.each(self2.find(".producto_total"), function(i,item){
        suma += parseFloat($(this)[0].value.split(" ")[1]);
    });
    $.each(self1.find(".precio_producto_sub_total"), function(i,item){
        suma += parseFloat($(this)[0].value.split(" ")[1]);
    });
    DOM.total_pedido_mesa.val("S/. "+parseFloat(suma).toFixed(2));
}

function limpiarX(self){
    $.each(self.find(".producto_total"), function(i,item){
        $(this)[0].value = 'S/. 0.00';
    });
    $.each(self.find(".producto_cantidad"), function(i,item){
        $(this)[0].value = '0';
    }); 
}

function limpiarY(self){
    $.each(self.find(".precio_producto_sub_total"), function(i,item){        
        $(this)[0].value = 'S/. 0.00';          
    });

    $.each(self.find(".cantidad_producto_sub_total"), function(i,item){
        $(this)[0].value = '0'; 
    });
}

function limpiarZ(){
    $.each(DOM.modal_sub_producto.find(".modal.fade"), function(i,item){
        var self = $(this);
        $.each(self.find(".total-sub-total"), function(key, item){
           $(this)[0].value = 'S/. 0.00';  
        })
        $.each(self.find(".producto_cantidad_grupo"), function(key, value){
            $(this)[0].value = '0'; 
        });
        $.each(self.find(".precio_total_grupo"), function(key, value){
           $(this)[0].innerHTML = 'S/. 0.00'; 
        });
    });    
}

function limpiar(){
    DOM.total_pedido_mesa.val("S/. 0.00");
    limpiarX(DOM.listado_cocina);
    limpiarX(DOM.listado_bar);
    limpiarY(DOM.listado_cocina);
    limpiarZ();
    DOM.array.splice(0,DOM.array.length);
}

function regresarPedido(){
    bloque(2);
    DOM.codigo_producto.val("");
    DOM.nodo.val("");
    DOM.observaciones.val("");
}

function utensiliosHTML(utensilios){
    var ut = '';
    if ( utensilios.length === 0 ) {
        ut += '<ul class="list-group">';
            ut += '<li class="list-group-item">SIN AGREGADOS</li>';
        ut += '</ul>';
    }else{
        ut += utensilios.length > 4 ? '<ul class="list-group iscroll-utensilio">' : '<ul class="list-group">';
        $.each(utensilios, function(i,item){                           
            ut += '<li class="list-group-item">';
                ut += '<div class="custom-control custom-checkbox">';
                    ut += '<input type="checkbox" class="custom-control-input" id="'+item.nombre+'">';
                    ut += '<label class="custom-control-label" for="'+item.nombre+'">'+item.nombre+'</label>';
                ut += '</div>';
            ut += '</li>';                                
        }); 
        ut += '</ul>';
    }
    return ut;
}

function abrirObservacionesSubProducto(ref,id,nodo,posicion){
    var x = ref.parentElement.parentElement;
    
    if ( $(x).find("select")[0].selectedIndex == 0 ) {
        Validar.alert("warning","Debe seleccionar un cantidad mayor que cero para agregar las observaciones del pedido",2000);
        return 0;
    }  

    var funcion = function (resultado) {        
        if (resultado.estado === 200) {
            if (resultado.datos.rpt === true) {
                DOM.modal_observaciones_sub_producto.modal("show");
                DOM.modal_observaciones_sub_producto.find(".modal-title").text(resultado.datos.msj.producto.nombre+ " DEL PLATO "+posicion);
                DOM.codigo_producto_sub.val(id);
                DOM.nodo_sub.val(nodo);     
                DOM.posicion_sub.val(posicion);
                DOM.foto_producto_sub.prop('src','../../administrador/images/productos/'+resultado.datos.msj.producto.foto);
                DOM.utensilios_sub.html(utensiliosHTML(resultado.datos.msj.utensilios));
                DOM.observaciones_sub.val("");
                recargar_observaciones_sub();
             }else{
                Validar.alert("warning",resultado.datos.msj.errorInfo[2],2000);
            }            
        }
    }
    new Ajxur.Api({
        modelo: "Producto",
        metodo: "listarProductosObservaciones",
        data_in : {
            p_id : id
        }
    }, funcion);
}

function recargar_observaciones_sub(){
    $.each(DOM.array, function(i,item){
        if ( ( DOM.codigo_producto_sub.val() === item.id_producto ) && ( DOM.posicion_sub.val() === item.item ) ) {
            DOM.observaciones_sub.val(item.observaciones);
            $.each(DOM.utensilios_sub.find("input"), function(i,item2){
                $.each(item.utensilios, function(key,value){
                    if ( $(item2)[0].id === value) {
                        $(item2).prop("checked", true);
                    }
                });
            });
        }
    });
}

function guardarObservacionSub(){
    acciones_observaciones_sub();
    limpiar_observaciones_sub();
}

function acciones_observaciones_sub(){
    var utensilios = [];
    var nota = "";

    $.each(DOM.utensilios_sub.find("input"), function(i,item){                
        if ( $(this)[0].checked ) {
            nota += $(this)[0].id+',';
            utensilios.push($(this)[0].id);
        }                
    });


    if ( DOM.array.length === 0 ) {
        var obj = {
            id_producto : DOM.codigo_producto_sub.val(),
            utensilios : utensilios,
            nota : nota.substring(0,nota.length-1),
            observaciones : DOM.observaciones_sub.val(),
            item: DOM.posicion_sub.val()
        }                
        DOM.array.push(obj);
    }else{
        $.each(DOM.array,function(i,item){
            if ( ( DOM.codigo_producto_sub.val() === item.id_producto ) && ( DOM.posicion_sub.val() === item.item ) ) {
                DOM.array.splice(i,1); 
            }
        });
        var obj = {
            id_producto : DOM.codigo_producto_sub.val(),
            utensilios : utensilios,
            nota : nota.substring(0,nota.length-1),
            observaciones : DOM.observaciones_sub.val(),
            item: DOM.posicion_sub.val()
        }                        
        DOM.array.push(obj);
    }   
}

function limpiar_observaciones_sub(){
    DOM.operacion.val("");
    DOM.modal_confirmacion.modal("hide");
    DOM.codigo_producto_sub.val("");
    DOM.nodo_sub.val("");
    DOM.observaciones_sub.val("");
    $.each(DOM.utensilios_sub.find("input"), function(i,item){                
        $(this).prop("checked",false);                
    });
    $("#modal-observaciones-sub-producto").modal("hide");
}


function abrirObservaciones(ref,id,nodo){
    var x = ref.parentElement.parentElement;

    if ( $(x).find("select")[0].selectedIndex == 0 ) {
        Validar.alert("warning","Debe seleccionar un cantidad mayor que cero para agregar las observaciones del pedido",2000);
        return 0;
    }  

    var funcion = function (resultado) {        
        if (resultado.estado === 200) {
            if (resultado.datos.rpt === true) {
                bloque(3);
                DOM.codigo_producto.val(id);
                DOM.nodo.val(nodo);
                DOM.titulo_producto.text(resultado.datos.msj.producto.nombre+(nodo === 0 ? "" : " DE LA PERSONA "+nodo));
                DOM.foto_producto.prop('src','../../administrador/images/productos/'+resultado.datos.msj.producto.foto);
                DOM.utensilios.html(utensiliosHTML(resultado.datos.msj.utensilios));
                recargar_observaciones();
             }else{
                Validar.alert("warning",resultado.datos.msj.errorInfo[2],2000);
            }            
        }
    }
    new Ajxur.Api({
        modelo: "Producto",
        metodo: "listarProductosObservaciones",
        data_in : {
            p_id : id
        }
    }, funcion);
}

function nombre_cliente(obj,parametro=null){
    switch(obj){
        case 'pedido':
            if ( DOM.estado_convencional.val() === '2' ) {
                DOM.blkNombreCliente.hide();
            }else{
                DOM.blkNombreCliente.show();    
            }            
            break;
        case 'anular':
            DOM.blkNombreCliente.hide();   
            DOM.nombre_cliente.val(parametro);
            break;
        case 'activar':
            DOM.blkNombreCliente.hide();   
            DOM.nombre_cliente.val(parametro);
            break;
        case 'activar2':
            DOM.blkNombreCliente.hide();   
            DOM.nombre_cliente.val(parametro);
            break;
        case 'entregar_unitario':
            DOM.blkNombreCliente.hide();   
            DOM.nombre_cliente.val(parametro);
            break;
        default:
            DOM.blkNombreCliente.hide();
            break;
    }

}

function confirmar(titulo,obj,parametro=null){
    DOM.operacion.val(obj);
    DOM.modal_confirmacion.modal("show");
    DOM.modal_confirmacion.find(".modal-title").text(titulo);
    nombre_cliente(obj,parametro);
}

function guardarObservacion(){
    acciones_observaciones();
    limpiar_observaciones();
}

function acciones_observaciones(){
    var utensilios = [];
    var nota = "";

    $.each(DOM.utensilios.find("input"), function(i,item){                
        if ( $(this)[0].checked ) {
            nota += $(this)[0].id+',';
            utensilios.push($(this)[0].id);
        }                
    });


    if ( DOM.array.length === 0 ) {
        var obj = {
            id_producto : DOM.codigo_producto.val(),
            utensilios : utensilios,
            nota : nota.substring(0,nota.length-1),
            observaciones : DOM.observaciones.val(),
            item : 0
        }                
        DOM.array.push(obj);
    }else{
        $.each(DOM.array,function(i,item){
            if ( ( DOM.codigo_producto.val() === item.codigo_producto ) && ( DOM.nodo.val() === item.nodo ) ) {
                DOM.array.splice(i,1); 
            }
        });
        var obj = {
            id_producto : DOM.codigo_producto.val(),
            utensilios : utensilios,
            nota : nota.substring(0,nota.length-1),
            observaciones : DOM.observaciones.val(),
            item : 0
        }                        
        DOM.array.push(obj);
    }   
}

function limpiar_observaciones(){
    DOM.operacion.val("");
    DOM.modal_confirmacion.modal("hide");
    DOM.codigo_producto.val("");
    DOM.nodo.val("");
    DOM.observaciones.val("");
    $.each(DOM.utensilios.find("input"), function(i,item){                
        $(this).prop("checked",false);                
    });
    bloque(2);
}



function confirmar_accion(){
    switch(DOM.operacion.val()){
        case 'pedido':            
            acciones_pedido();
            break;
        case 'anular':
            acciones_espera(4);
            break;
        case 'activar':
            acciones_espera(1);
            break;
        case 'activar2':
            acciones_activar_entrega(1);
            break;
        case 'editar':
            acciones_editar();
            break;
        case 'entregar':
            acciones_entrega();
            break;
        case 'entregar_unitario':
            acciones_entrega_unitaria();
            break;
        case 'sesion_cerrar':
            document.location.href = "cerrar_sesion.php";
            break;
    }
}

function acciones_entrega_unitaria(){
    console.log("LLEGUE ACA");
    var funcion = function (resultado) {        
        if (resultado.estado === 200) {
            if ( resultado.datos.rpt === true ){
                limpiar_entrega_unitaria();
                Validar.alert("warning",resultado.datos.msj,2000);
            }else{
                Validar.alert("warning",resultado.datos.msj.errorInfo[2],2000);                                
            }            
        }
    }

    new Ajxur.Api({
        modelo: "Pedido",
        metodo: "entregaPedidoUnitario",
        data_in :{
            p_id : DOM.nombre_cliente.val()
        }
    }, funcion);
}

function limpiar_entrega_unitaria(){
    DOM.modal_confirmacion.modal("hide");
    DOM.operacion.val("");
    DOM.nombre_cliente.val("");
    listarPedidoEntrega(DOM.codigo_mesa.val());

    setTimeout(function(){
        if ( DOM.listado_pedido_entrega.find("tr").length <= 1 ) {
            DOM.codigo_mesa.val("");
            DOM.mesa.val("");
            DOM.estado_convencional.val("");
            bloque(1);
        }  
    }, 50);
}

function acciones_entrega(){
    var funcion = function (resultado) {        
        if (resultado.estado === 200) {
            if ( resultado.datos.rpt === true ){
                limpiar_entrega();
                Validar.alert("warning",resultado.datos.msj,2000);
            }else{
                Validar.alert("warning",resultado.datos.msj.errorInfo[2],2000);                                
            }            
        }
    }

    new Ajxur.Api({
        modelo: "Pedido",
        metodo: "entregaPedido",
        data_in : {
            p_id_mesa : DOM.codigo_mesa.val()
        }
    }, funcion);
}

function limpiar_entrega(){
    DOM.modal_confirmacion.modal("hide");
    DOM.operacion.val("");
    DOM.nombre_cliente.val("");
    DOM.codigo_mesa.val("");
    DOM.mesa.val("");
    DOM.estado_convencional.val("");
    bloque(1);
}

function acciones_activar_entrega(estado){
    var funcion = function (resultado) {        
        if (resultado.estado === 200) {
            if ( resultado.datos.rpt === true ){
                limpiar_active_entrega();
                Validar.alert("warning",resultado.datos.msj,2000);
            }else{
                Validar.alert("warning",resultado.datos.msj.errorInfo[2],2000);                                
            }            
        }
    }

    new Ajxur.Api({
        modelo: "Pedido",
        metodo: "darBaja",
        data_out :[DOM.nombre_cliente.val(),estado]
    }, funcion);
}

function limpiar_active_entrega(){
    DOM.modal_confirmacion.modal("hide");
    DOM.operacion.val("");
    DOM.nombre_cliente.val("");
    listarPedidoEntrega(DOM.codigo_mesa.val());
}

function acciones_editar(){
    var funcion = function (resultado) {        
        if (resultado.estado === 200) {
            if (resultado.datos.rpt === true) {
                limpiar_pedido_editar();
                Validar.alert("warning",resultado.datos.msj,2000);                                   
            }else{
                Validar.alert("warning",resultado.datos.msj.errorInfo[2],2000);                
            }            
        }
    }
    new Ajxur.Api({
        modelo: "Pedido",
        metodo: "editar",
        data_in : {
            p_id : DOM.codigo_pedido.val()
        },
        data_out : [DOM.cantidad_pedido.val(),DOM.observaciones_pedido.val()]
    }, funcion);    
}
function cantidadEditar(){
    var html = '';
    for (var i = 1; i <= 100; i++){ 
        html += '<option value="'+i+'">'+i+'</option>';   
    }
    DOM.cantidad_pedido.html(html);
}

function acciones_espera(estado){
    var funcion = function (resultado) {        
        if (resultado.estado === 200) {
            if ( resultado.datos.rpt === true ){
                limpiar_espera();                
                Validar.alert("warning",resultado.datos.msj,2000);
            }else{
                Validar.alert("warning",resultado.datos.msj.errorInfo[2],2000);                                
            }            
        }
    }

    new Ajxur.Api({
        modelo: "Pedido",
        metodo: "darBaja",
        data_out :[DOM.nombre_cliente.val(),estado,DOM.codigo_mesa.val()]
    }, funcion);
}

function limpiar_espera(){
    DOM.modal_confirmacion.modal("hide");
    DOM.operacion.val("");
    DOM.nombre_cliente.val("");
    listarPedidoEspera(DOM.codigo_mesa.val());
    setTimeout(function(){
        if ( DOM.listado_pedido_espera.find("tr").length <= 1 ) {
            DOM.codigo_mesa.val("");
            DOM.mesa.val("");
            DOM.estado_convencional.val("");
            bloque(1);
        }  
    }, 50);
    
}

function acciones_pedido(){
    if ( DOM.nombre_cliente.val() === "" && DOM.estado_convencional.val() === "1" ) {
        Validar.alert("warning","Debe ingresar el nombre para guardar el pedido",2000);
        return 0;
    }

    $("#btn-confirmar-accion").attr("disabled","true");
    var toma_pedido = [];
    $.each(DOM.listado_cocina.find("div.card"), function(i,item){
        var self = $(this);
        $.each(self.find("select"), function(key,value){
            var self2 = $(this);
            var nodo = this.parentElement;
            var id_producto = parseInt($(nodo).find("input").eq(1).val());
            var cantidad = parseInt(self2.val());
            var precio = parseFloat($(nodo).find("input").eq(0).val());
            var item = key + 1;                
            if ( parseInt(self2.val()) > 0 ) {
                var obj = {
                    item : item,
                    id_producto: id_producto,
                    precio : precio,
                    cantidad : cantidad
                }
                toma_pedido.push(obj); 
            }
        });
    });

    $.each(DOM.listado_bar.find("div.card"), function(i,item){
        var self = $(this);        
        $.each(self.find("select"), function(key,value){
            var self2 = $(this);
            var nodo = this.parentElement;
            var id_producto = parseInt($(nodo).find("input").eq(1).val());
            var cantidad = parseInt(self2.val());
            var precio = parseFloat($(nodo).find("input").eq(0).val());
            var item = key + 1;                
            if ( parseInt(self2.val()) > 0 ) {
                var obj = {
                    item : item,
                    id_producto: id_producto,
                    precio : precio,
                    cantidad : cantidad
                }
                toma_pedido.push(obj); 
            }
        });
    });

    var json = JSON.stringify(toma_pedido);
    var json2 = JSON.stringify(DOM.array);

    if( toma_pedido.length == 0 ){
        Validar.alert("warning","Debe tener al menos un pedido para guardar.",2000);
        return 0;
    }
    var funcion = function (resultado) {        
        if (resultado.estado === 200) {
            if (resultado.datos.rpt === true) {                    
                limpiar_pedido();                
                Validar.alert('warning',resultado.datos.msj,2000);
                $("#btn-confirmar-accion").removeAttr("disabled");
            }else{
                Validar.alert("warning",resultado.datos.msj.errorInfo[2],2000);
            }            
        }
    }
    new Ajxur.Api({
        modelo: "Pedido",
        metodo: "agregar",
        data_in : {
            p_id_mesa : DOM.codigo_mesa.val(),
            p_detalle : json
        },
        data_out : [DOM.estado_convencional.val(), DOM.nombre_cliente.val(),json2]
    }, funcion);
}


function limpiar_pedido(){
    DOM.modal_confirmacion.modal("hide");
    DOM.operacion.val("");
    DOM.nombre_cliente.val("");
    DOM.total_pedido_mesa.val("S/. 0.00");
    limpiarX(DOM.listado_cocina);
    limpiarX(DOM.listado_bar);
    limpiarY(DOM.listado_cocina);
    limpiarZ();
    DOM.array.splice(0,DOM.array.length);
    bloque(1);
    cambiarDisponibilidad(0,DOM.codigo_mesa.val());
    DOM.codigo_mesa.val("");
    DOM.estado_convencional.val("");
    regresarTab();    
}

function regresarTab(){
    $.each($("#myTab").find("a"), function(i,item){
        if ( i === 0 ) {
            $(this).addClass("active");
            $(this).addClass("show");
        }else{
            $(this).removeClass("active");
            $(this).removeClass("show");        
        }
    });

    $.each($("#myTabContent").find(".tab-pane"), function(i,item){
        if ( i === 0 ) {
            $(this).addClass("active");
            $(this).addClass("show");
        }else{
            $(this).removeClass("active");
            $(this).removeClass("show");        
        }       
    });
}




function recargar_observaciones(){
    $.each(DOM.array, function(i,item){
        console.log(DOM.codigo_producto.val(),' ',item.id_producto);
        console.log(DOM.nodo.val(),' ',item.item);

        if ( ( DOM.codigo_producto.val() === item.id_producto ) && ( parseInt(DOM.nodo.val()) === item.item ) ) {
            DOM.observaciones.val(item.observaciones);
            $.each(DOM.utensilios.find("input"), function(i,item2){
                $.each(item.utensilios, function(key,value){
                    if ( $(item2)[0].id === value) {
                        $(item2).prop("checked", true);
                    }
                });
            });
        }
    });
}

function is(ref,id,nodo){    
    if ( $(ref)[0].selectedIndex === 0 && DOM.array.length > 0 ) {
        $.each(DOM.array,function(i,item){
            if ( ( id === parseInt(item.codigo_producto) ) && ( nodo === parseInt(item.nodo) ) ) {
                DOM.array.splice(i,1);
                Validar.alert("warning","Se ha retirado correctamente la información de este pedido", 2000);
            }
        });     
    } 
}

function cargarAll(){
    var funcion = function (resultado) {   
        if (resultado.estado === 200) {
            DOM.sesion = resultado.datos.msj.dni;
            DOM.ubicacion= resultado.datos.msj.ubicacion;
            if( DOM.sesion == "super" ){
                DOM.btnPedirMesero.hide();
            }             
        }
    }

    new Ajxur.Api({
        modelo: "Empleado",
        metodo: "obtenerSesionDatos"
    }, funcion);
}

function setEventos(){
    DOM.nombre_cliente.keypress(function(e){
        if ( e.which === 13 ) {
            acciones_pedido();
        }        
    });

    DOM.modal_sub_producto.on("change",".producto_cantidad_grupo",function(){
        var indicador = this.dataset.id;
        var modal = DOM.modal_sub_producto;


        $.each(modal.find("tbody"), function(i,item){
            var self = $(this);
            switch(i){
                case 0://empanadas
                    var cantidad = 0;
                    $.each(self.find("tr"), function(i, item){
                        cantidad += parseInt($(this).find("td").eq(indicador).find("select").val());
                    });
                    var nodo = DOM.listado_cocina.find("div.card-body.listado_producto_cocina").eq(0);                    
                    nodo.find(".cantidad_producto_sub_total").eq(indicador).val(cantidad);
                    var importe = parseFloat(cantidad*parseFloat(nodo.find(".producto_precio_sub_total").eq(indicador).val())).toFixed(2);
                    nodo.find(".precio_producto_sub_total").eq(indicador).val('S/. '+importe);
                    break;
                case 1://sandiwich
                    var cantidad = 0;
                    $.each(self.find("tr"), function(i, item){
                        cantidad += parseInt($(this).find("td").eq(indicador).find("select").val());
                    });
                    var nodo = DOM.listado_cocina.find("div.card-body.listado_producto_cocina").eq(1);                    
                    nodo.find(".cantidad_producto_sub_total").eq(indicador).val(cantidad);
                    var importe = parseFloat(cantidad*parseFloat(nodo.find(".producto_precio_sub_total").eq(indicador).val())).toFixed(2);
                    nodo.find(".precio_producto_sub_total").eq(indicador).val('S/. '+importe);
                    break;
            }
        });
        importe_toma_pedido(DOM.listado_cocina,DOM.listado_bar);        
    });



    DOM.modal_sub_producto.change(function(){
        var self = $(this);        
        $.each(self.find("tbody tr"), function(i,item){
            $td = $(this).find("td");
            $th = $(this).find(".precio_total_grupo");
            var suma = 0;
            $.each($td, function(i,item){                
                suma += parseFloat($(this).find("input")[0].value)*parseInt($(this).find("select")[0].value);
            });
            $th[0].innerHTML = 'S/. '+parseFloat(suma).toFixed(2);
        }); 

        var arreglo = [];
        $.each(self.find("tbody"), function(i,item){
            var total = 0;            
            $th = $(this).find("th.precio_total_grupo"); 
            $.each($th, function(i,item){                
                total += parseFloat($(this)[0].innerHTML.split(" ")[1]);                  
            });
            arreglo.push(total);
        });
        $.each(self.find(".total-sub-total"), function(i,item){            
            $(this)[0].value = 'S/. '+parseFloat(arreglo[i]).toFixed(2);            
        });
    });


    $(document).keydown(function(e){
        var code = (e.keyCode ? e.keyCode : e.which);
        if (code == 116 ) {
            e.preventDefault();
            return 0;
        }
    });

    
    DOM.texto_documento.keypress(function(e){           
        return Validar.soloNumeros(e);
    });

    DOM.listado_cocina.change(function(){
        tomaPedido( true , $(this) ); 
        importe_toma_pedido(DOM.listado_cocina,DOM.listado_bar);       
    });

    DOM.listado_bar.change(function(){
        tomaPedido( false , $(this) );                
        importe_toma_pedido(DOM.listado_cocina,DOM.listado_bar); 
    });

    DOM.cantidad_pedido.change(function(){
        importe_pedido_editar();
    });
}

function limpiar_pedido_editar(){
    DOM.codigo_pedido.val("");
    DOM.cantidad_pedido.val("1");
    DOM.precio_pedido.val("");
    DOM.importe_pedido.val("");
    DOM.observaciones_pedido.val("");
    DOM.modal_editar_pedido.modal("hide");
    DOM.modal_confirmacion.modal("hide");
    listarPedidoEspera(DOM.codigo_mesa.val());
}

function refrescarMesa(){
    setInterval(cargarMesas, 1000);
    $.ajaxSetup({ cache: false })
}

function cargarMesas(){
    var funcion = function (resultado) {        
        if (resultado.estado === 200) {
            if (resultado.datos.rpt === true) {
                var html = "";                                
                var bandera = false;
                if ( DOM.codigo_mesa.val() !== "" ) {
                    bandera = true;
                }
                $.each(resultado.datos.msj, function (i, item) { 
                    var texto = "secondary";
                    var actividad = "";
                    /* CONDICIONAL PARA SUPER */
                    if( DOM.sesion === "super" ){
                        if ( parseInt(item.espera) > 0 ) {
                            texto = 'warning';
                            actividad = 'onclick="abrirEspera('+item.id+",'"+item.numero+"','"+item.estado_convencional+"'"+')"';
                        }
                        html += '<button type="button" class="btn btn-'+texto+' btn-block" '+actividad+'>'+ item.numero+'</button>';

                    }else{
                        if ( !bandera ) {
                            if (DOM.ubicacion ==="1" || item.ubicacion==DOM.ubicacion){
                                if ( parseInt(item.estado_convencional) === 1 ) {
                                    if ( parseInt(item.disponibilidad) === 0) {
                                        texto = 'info';
                                        actividad = 'onclick="abrirPedido('+item.id+",'"+item.numero+"','"+item.estado_convencional+"'"+')"';
                                    }
                                    if ( parseInt(item.disponibilidad) === 1 ) {
                                        texto = 'danger';
                                        actividad = '';
                                    }
                                }
        
                                if ( parseInt(item.estado_convencional) === 2 ) {
                                    if ( parseInt(item.espera) === 0 ) {
                                        texto = 'dark';                                
                                        actividad = 'onclick="abrirPedido('+item.id+",'"+item.numero+"','"+item.estado_convencional+"'"+')"';
                                    } 
        
                                    if ( parseInt(item.espera) > 0 ) {
                                        texto = 'warning';
                                        actividad = 'onclick="abrirEspera('+item.id+",'"+item.numero+"','"+item.estado_convencional+"'"+')"';
                                    }
        
                                    if ( parseInt(item.preparado) > 0 ) {
                                        texto = 'success';
                                        actividad = 'onclick="abrirEntrega('+item.id+",'"+item.numero+"','"+item.estado_convencional+"'"+')"';
                                    }
        
                                    if ( parseInt(item.disponibilidad) === 1 ) {
                                        texto = 'danger';
                                        actividad = '';
                                    }
                                }
                            html += '<button type="button" class="btn btn-'+texto+' btn-block" '+actividad+'>'+ item.numero+'</button>';
                            }
                        }                        
                    }
                });
                DOM.listado_mesas.html(html);                
            }else{
                Validar.alert("warning",resultado.datos.msj.errorInfo[2],2000);                
            }            
        }
    }
    new Ajxur.Api({
        modelo: "Mesa",
        metodo: "llenarCB"
    }, funcion);
}

function abrirEntrega(id_mesa,mesa,estado_convencional){
    bloque(5);
    DOM.codigo_mesa.val(id_mesa);
    DOM.mesa.val(mesa);
    DOM.estado_convencional.val(estado_convencional);
    DOM.blkEntregar.find(".titulo").text(mesa.substring(0,1)+ mesa.toLowerCase().substring(1)+": Pedido en entrega o espera");
    listarPedidoEntrega(id_mesa);
}

function listarPedidoEntrega(id_mesa){
    var funcion = function (resultado) {        
        if (resultado.estado === 200) {
            if ( resultado.datos.rpt === true ) {
                var html = '';
                $.each(resultado.datos.msj.pedidos, function(i,item){
                    html += item.estado === "4" ? '<tr style="background: red;">':'<tr>';                      
                        html += '<td class="text-center">';
                            html += '<div class="justify-content-between">';
                                // if ( parseInt(item.item) > 0 ){
                                //     html += '<small sytle="font-size:7px;">Plato '+item.item+'</small>';
                                // } 
                                html += '<h5 sytle="font-size:12px;">'+item.producto+'</h5>';  
                                html += '<small sytle="font-size:7px;">'+item.nota+'</small>';
                            html += '</div>';
                        html += '</td>';
                        html += '<td class="text-center">'+item.cantidad+'</td>';
                        html += '<td class="text-center">S/. '+item.precio+'</td>';
                        html += '<td class="text-center">S/. '+item.importe+'</td>';
                        html += '<td class="text-center">';
                            if ( item.estado === "2" ) {
                                html += '&nbsp;&nbsp;';
                                html += '<button type="button" class="btn btn-xs btn-primary" onclick="confirmar('+"'¿Desea entregar este pedido?','entregar_unitario',"+item.id+')" title="Entrega"><i class="fas fa-file-import"></i></button>';                
                                html += '&nbsp;&nbsp;';
                            }
                            if ( item.estado === "1" ) {
                                html += '<button type="button" class="btn btn-warning btn-xs" data-toggle="modal" data-target="#modal-editar-pedido" onclick="editar('+item.id+')" title="Cambiar cantidad de pedido"><i class="fas fa-pen"></i></button>';
                                html += '&nbsp;&nbsp;';
                            }
                        html += '</td>';
                    html += '</tr>';
                });
                DOM.listado_pedido_entrega.html(html);
                var importe = resultado.datos.msj.total == null ? '0.00' : resultado.datos.msj.total;
                DOM.importe_espera.text("TOTAL: S/. "+importe);
            }else{
                Validar.alert("warning",resultado.datos.msj.errorInfo[2],2000);
            }            
        }
    }

    new Ajxur.Api({
        modelo: "Pedido",
        metodo: "listarPedidoMeseroEntrega",
        data_in : {
            p_id_mesa : id_mesa
        }
    }, funcion);
}

function consultar_mesa(){
    if ( DOM.cboMesasConsultar.val() === null ) {
        Validar.alert("warning","Debe seleccionar una mesa para consultar");
        return 0;
    }   

    abrirDetalleMesa(DOM.cboMesasConsultar.val(),"Samuel");    
}

function abrirDetalleMesa(id_mesa,mesa){
    DOM.codigo_mesa.val(id_mesa);
    DOM.mesa.val(mesa);
    //DOM.estado_convencional.val(estado_convencional);
    //DOM.blkListarPedidos.find(".titulo").text(mesa.substring(0,1)+ mesa.toLowerCase().substring(1)+": Pedido en espera");
    var funcion = function (resultado) {        
        if (resultado.estado === 200) {
            if ( resultado.datos.rpt === true ) {
                var html = '';
                $.each(resultado.datos.msj.pedidos, function(i,item){                    
                    //html += item.estado === "4" ? '<tr style="background: red;">':'<tr>';
                    switch (item.estado) {
                        case "1":
                            html += '<tr ><td style="background: yellow; display: flex;justify-content: center;align-items: center;font-size: 2rem"><i class="fas fa-pen"></i></td>';
                            break; 
                        case "2":
                            html += '<tr><td style="background: blue;display: flex;justify-content: center;align-items: center;font-size: 2rem"><i class="fas fa-fire"></i></td>';
                            break; 
                        case "3":
                            html += '<tr><td style="background: green;display: flex;justify-content: center;align-items: center;font-size: 2rem"><i class="fas fa-shopping-cart"></i></td>';
                            break; 
                        case "4":
                            html += '<tr style="text-decoration:line-through;color:red"><td style="color:black;background: red; display: flex;justify-content: center;align-items: center;font-size: 2rem"><i class="fas fa-trash"></i></td>';
                            break;                    
                        case "6":
                            html += '<tr style="text-decoration:line-through;color:green"><td style="color:white;background: black; display: flex;justify-content: center;align-items: center;font-size: 2rem"><i class="fas fa-print"></i></td>';
                            break;                    
                        default:
                            html += '<tr><td>&nbsp&nbsp&nbsp&nbsp</td>'
                            break;
                    }
                    
                        html += '<td class="text-center">';
                            html += '<div class="justify-content-between">';
                                /* if ( parseInt(item.item) > 0 ){
                                    html += '<small sytle="font-size:7px;">Plato '+item.item+'</small>';
                                } */
                                html += '<h5 sytle="font-size:12px;">'+item.producto+'</h5>';                                
                                html += '<small sytle="font-size:7px;">'+item.nota+'</small>';
                            html += '</div>';
                        html += '</td>';
                        html += '<td class="text-center">'+item.cantidad+'</td>';
                        html += '<td class="text-center">S/. '+item.precio+'</td>';
                        html += '<td class="text-center">S/. '+item.importe+'</td>';
                        html += '<td class="text-center">';
                        html += '</td>';
                    html += '</tr>';
                });
                DOM.listado_pedido_mozo.html(html);
                var importe = resultado.datos.msj.total == null ? '0.00' : resultado.datos.msj.total;
                DOM.importe_espera_mozo.text("TOTAL: S/. "+importe);
            }else{
                Validar.alert("warning",resultado.datos.msj.errorInfo[2],2000);
            }            
        }
    }

    new Ajxur.Api({
        modelo: "Pedido",
        metodo: "listarPedidosCajero",
        data_in : {
            p_id_mesa : id_mesa
        }
    }, funcion);
}

function abrirPuntos(){
    bloque(6);
}

function abrirAcciones(){
    bloque(7);
    cargarComboMesasVacias();
}

function abrirPedido(id_mesa,mesa,estado_convencional){
    cambiarDisponibilidad(1, id_mesa);
    DOM.codigo_mesa.val(id_mesa);
    DOM.mesa.val("");
    DOM.estado_convencional.val(estado_convencional);
    DOM.titulo_pedido.text("Pedido para "+(mesa.split(" ")[0] ? " el " : " la ")+ mesa.toLowerCase());
    bloque(2); 
}

function abrirEspera(id_mesa,mesa,estado_convencional){
    bloque(4);
    DOM.codigo_mesa.val(id_mesa);
    DOM.mesa.val(mesa);
    DOM.estado_convencional.val(estado_convencional);
    DOM.blkEspera.find(".titulo").text(mesa.substring(0,1)+ mesa.toLowerCase().substring(1)+": Pedido en espera");
    listarPedidoEspera(id_mesa);
}

function listarPedidoEspera(id_mesa){
    var funcion = function (resultado) {        
        if (resultado.estado === 200) {
            if ( resultado.datos.rpt === true ) {
                var html = '';
                $.each(resultado.datos.msj.pedidos, function(i,item){
                    html += item.estado === "4" ? '<tr style="background: red;">':'<tr>';                      
                        html += '<td class="text-center">';
                            html += '<div class="justify-content-between">';
                                // if ( parseInt(item.item) > 0 ){
                                //     html += '<small sytle="font-size:7px;">Plato '+item.item+'</small>';
                                // }
                                html += '<h5 sytle="font-size:12px;">'+item.producto+'</h5>';                                
                                html += '<small sytle="font-size:7px;">'+item.nota+'</small>';
                            html += '</div>';
                        html += '</td>';
                        html += '<td class="text-center">'+item.cantidad+'</td>';
                        html += '<td class="text-center">S/. '+item.precio+'</td>';
                        html += '<td class="text-center">S/. '+item.importe+'</td>';
                        html += '<td class="text-center">';
                            if ( item.estado === "1" ) {
                                if( DOM.sesion != "super"){
                                    html += '<button type="button" class="btn btn-warning btn-xs" data-toggle="modal" data-target="#modal-editar-pedido" onclick="editar('+item.id+')" title="Cambiar cantidad de pedido"><i class="fas fa-pen"></i></button>';
                                    html += '&nbsp;&nbsp;';
                                }
                                

                                if( DOM.sesion == "super" ) {
                                    html += '<button type="button" class="btn btn-xs btn-danger" onclick="confirmar('+"'¿Desea anular este pedido?','anular',"+item.id+')" title="Anular"><i class="fa fa-times"></i></button>';                
                                    html += '&nbsp;&nbsp;';
                                }                                
                            }
                        html += '</td>';
                    html += '</tr>';
                });
                DOM.listado_pedido_espera.html(html);
                var importe = resultado.datos.msj.total == null ? '0.00' : resultado.datos.msj.total;
                DOM.importe_espera.text("TOTAL: S/. "+importe);
            }else{
                Validar.alert("warning",resultado.datos.msj.errorInfo[2],2000);
            }            
        }
    }

    new Ajxur.Api({
        modelo: "Pedido",
        metodo: "listarPedidoMeseroEspera",
        data_in : {
            p_id_mesa : id_mesa
        }
    }, funcion);
}

function editar(id){
    DOM.modal_editar_pedido.find(".modal-title").text("Editar pedido");
    var funcion = function (resultado) {        
        if (resultado.estado === 200) {
            if ( resultado.datos.rpt === true ){
                DOM.codigo_pedido.val(resultado.datos.msj.id);
                DOM.cantidad_pedido.val(resultado.datos.msj.cantidad);
                DOM.precio_pedido.val("S/. "+resultado.datos.msj.precio);                
                DOM.observaciones_pedido.val(resultado.datos.msj.observaciones);
                importe_pedido_editar();
            }else{
                Validar.alert("warning",resultado.datos.msj.errorInfo[2],2000);
            }            
        }
    }

    new Ajxur.Api({
        modelo: "Pedido",
        metodo: "leerDatos",
        data_in : {
            p_id : id 
        }
    }, funcion);
}

function importe_pedido_editar(){
    var cantidad = parseInt(DOM.cantidad_pedido.val());
    var precio = parseFloat(DOM.precio_pedido.val().split(" ")[1]);
    DOM.importe_pedido.val("S/. "+parseFloat(cantidad*precio).toFixed(2));
}

function abrirMasPedido(){
    abrirPedido(DOM.codigo_mesa.val(),DOM.mesa.val(),DOM.estado_convencional.val());
}

function cerrarPedidoEspera(){
    DOM.codigo_mesa.val("");
    DOM.mesa.val("");
    DOM.estado_convencional.val("");
    DOM.texto_documento.val("");
    bloque(1);
}

function cerrarOtrasAcciones(){
    DOM.codigo_mesa.val("");
    DOM.mesa.val("");
    DOM.texto_documento.val("");
    DOM.listado_pedido_mozo.empty();
    DOM.cboMesasConsultar.val("");
    DOM.importe_espera_mozo.html("");
    bloque(1);
}

function guardarMesa(){
    if ( parseFloat(DOM.total_pedido_mesa.val().split(" ")[1]) === 0 ) {
        Validar.alert("warning","Debe tener al menos un pedido para guardar el pedido",2000);
        return 0;
    }
    confirmar("¿Desea guardar este pedido para esta mesa?","pedido");
}

function CerrarMesa(){
    cambiarDisponibilidad(0, $("#codigo_mesa").val());
    $("#codigo_mesa").val("");
    $("#mesa").val("");
    $("#estado_convencional").val("");

    
    $.each($("#myTab").find("a"), function(i,item){
        if ( i === 0 ) {
            $(this).addClass("active");
            $(this).addClass("show");
        }else{
            $(this).removeClass("active");
            $(this).removeClass("show");        
        }
    });

    $.each($("#myTabContent").find(".tab-pane"), function(i,item){
        if ( i === 0 ) {
            $(this).addClass("active");
            $(this).addClass("show");
        }else{
            $(this).removeClass("active");
            $(this).removeClass("show");        
        }       
    });
    bloque(1); 
    limpiar();

}

function cargarComboMesas(){
     var funcion = function (resultado) {        
        if (resultado.estado === 200) {
            if (resultado.datos.rpt === true) {
                var html = ""; 
                html = '<option value="" disabled selected>Seleccionar mesa</option>';                               
                $.each(resultado.datos.msj, function (i, item) { 
                    if( DOM.sesion === "super" ||DOM.ubicacion ==="1" || item.ubicacion==DOM.ubicacion ){
                        html += '<option value="' + item.id + '">'+ item.numero + '</option>';
                    }
                });
                DOM.cboMesasLiberar.html(html);
                DOM.cboMesasConsultar.html(html);                
            }else{
                Validar.alert("warning",resultado.datos.msj.errorInfo[2],2000);                
            }            
        }
    }
    new Ajxur.Api({
        modelo: "Mesa",
        metodo: "llenarCB"
    }, funcion);
}

function liberar_mesa(){
    if ( DOM.cboMesasLiberar.val() === null ) {
        Validar.alert("warning","Debe seleccionar una mesa para liberar");
        return 0;
    }   
    cambiarDisponibilidad(0,DOM.cboMesasLiberar.val());
    Validar.alert("warning","Se ha liberado correctamente",2000);
    $("#liberar_mesa").modal("hide");
}

function cambiarDisponibilidad(estado, codigo_mesa){
    var funcion = function (resultado) {        
        if (resultado.estado === 200) {
            if ( resultado.datos.rpt === false ){
                Validar.alert("warning",resultado.datos.msj.errorInfo[2],2000);
            }            
        }
    }

    new Ajxur.Api({
        modelo: "Mesa",
        metodo: "cambiarDisponibilidad",
        data_in : {
            p_disponibilidad : estado,
            p_id : codigo_mesa 
        }
    }, funcion);  
}

function cargarComboMesasVacias(){
    var funcion = function (resultado) {        
       if (resultado.estado === 200) {
           if (resultado.datos.rpt === true) {
               var html = ""; 
               html = '<option value="" disabled selected>Seleccionar mesa</option>';                               
               $.each(resultado.datos.msj, function (i, item) { 
                   if( DOM.sesion === "super" ||DOM.ubicacion ==="1" || item.ubicacion==DOM.ubicacion ){
                       html += '<option value="' + item.id + '">'+ item.numero + '</option>';
                   }
               });
               DOM.cboMesasDestino.html(html);
           }else{
               Validar.alert("warning",resultado.datos.msj.errorInfo[2],2000);                
           }            
       }
   }
   new Ajxur.Api({
       modelo: "Mesa",
       metodo: "llenarCBVacias"
   }, funcion);
}    

function mover_mesa(){
    if ( DOM.cboMesasConsultar.val() === null ) {
        Validar.alert("warning","Debe seleccionar una mesa origen para liberar");
        return 0;
    } 
    if ( DOM.cboMesasDestino.val() === null ) {
        Validar.alert("warning","Debe seleccionar una mesa destino para liberar");
        return 0;
    }      
    moverMesa(DOM.cboMesasConsultar.val(),DOM.cboMesasDestino.val());
    Validar.alert("warning","Se movió el pedido de la mesa correctamente",2000);
    $("#blkcambiar_mesa").modal("hide");
    cerrarOtrasAcciones();
}

function moverMesa(origen,destino){
    var funcion = function (resultado) {        
        if (resultado.estado === 200) {
            if ( resultado.datos.rpt === false ){
                Validar.alert("warning",resultado.datos.msj.errorInfo[2],2000);
            }            
        }
    }
    new Ajxur.Api({
        modelo: "Mesa",
        metodo: "moverMesa",
        data_out : [origen,destino]
    }, funcion);  
}