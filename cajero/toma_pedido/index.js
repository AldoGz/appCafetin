var DOM = {};

$(document).ready(function () {
    setDOM();
    setEventos();
    listarTC();     
    bloque(1);
    refrescarMesa();
    $("#blkDireccion").hide();
    //listarPromociones();
});


function setDOM(){
    DOM.blkSinAcciones = $("#blkSinAcciones");
    DOM.blkPagarMesa = $("#blkPagarMesa");
    DOM.blkAlertas = $("#blkAlertas");
    DOM.blkListarPedidos = $("#blkListarPedidos");

    DOM.listado_producto_1 = $("#listado-producto-1");
    DOM.listado_producto_2 = $("#listado-producto-2");

    DOM.cboTurno = $("#cboTurno");
    DOM.cboMedioPago = $("#cboMedioPago");
    
    DOM.titulo_entregado = $("#titulo-panel-entregados");
    DOM.estado_convencional = $("#estado_convencional");
    
    DOM.cantidad = $("#cantidad");
    DOM.observaciones = $("#observaciones");
    DOM.btnConfirmarPedido = $("#ConfirmarPedido");
    DOM.btnCerrarPedido = $("#CerrarPedido");
    DOM.btnGuardarPedido = $("#GuardarPedido");
    DOM.btnGuardarEntregable = $("#ConfirmarEntregable");

    DOM.btnCerrarEntregable = $("#CerrarEntregable");

    DOM.btnPagoParcial = $("#Pago_parcial");

    DOM.listado_mesas = $("#listado-mesas");
    DOM.listado_pedido_entregado = $("#listado-pedido-entregado");
    DOM.listado_pedido_espera = $("#listado_pedido_espera");
    DOM.importe_espera = $("#importe_espera");

    //**//
    DOM.btnCerrarReporte = $("#CerrarReporte");
    DOM.btnCerrarPedidosListado = $("#CerrarPedidosListado");
    
    DOM.listar_reporte = $("#listado-reporte");
    DOM.fecha_inicio = $("#fecha_inicio");
    DOM.fecha_fin = $("#fecha_fin");
    DOM.btnFiltrarReporte = $("#FiltrarReporte");
    DOM.btnCerrarPago = $("#CerrarPago");

    DOM.tipo_comprobante = $("#tipo_comprobante");
    DOM.serie_comprobante = $("#serie_comprobante");
    DOM.correlativo = $("#correlativo");
    DOM.documento = $("#documento");
    DOM.razon_social = $("#razon_social");
    DOM.direccion = $("#direccion");
    DOM.usuario = $("#usuario");


    DOM.listado_apagar = $("#listado-pedidos-por-pagar");
    DOM.titulo = $("#titulo-panel");
    DOM.codigo_mesa = $("#codigo_mesa");
    DOM.mesa = $("#mesa");;

    DOM.btnPagar = $("#PagarPedido");

    DOM.listado_pedidos_puntos = $("#listado-pedidos-puntos");
    //DOM.listado_promociones = $("#listado-pedidos-puntos-promocion");

    DOM.ticket = $("#text_ticket");
    DOM.text_descuento = $("#text_descuento");
    DOM.monto = $("#monto_pagado");
    DOM.monto_descuento = $("#monto_descuento");
    DOM.monto_amortizacion = $("#monto_amortizacion");
    DOM.btnDescuento = $("#btnDescuento");
    DOM.cantidad_puntos = $("#cantidad_puntos");
    DOM.texto_usuario_detalle = $("#texto-usuario");
    DOM.mesa_usuario_detalle = $("#mesa-usuario");
    DOM.fecha_usuario_detalle = $("#fecha-usuario");
    DOM.array = [];

    DOM.ticket_flag = false;
}

function bloque(tipo){
    switch(tipo){
        case 1: //INICIO
            DOM.blkSinAcciones.show();
            DOM.blkPagarMesa.hide();
            DOM.blkAlertas.hide();
            DOM.blkListarPedidos.hide();
            break;
        case 2: //ABRIR FACTURACION
            DOM.blkSinAcciones.hide();
            DOM.blkPagarMesa.show();
            DOM.blkAlertas.hide();
            DOM.blkListarPedidos.hide();
            break;
        case 3:
            DOM.blkSinAcciones.hide();
            DOM.blkPagarMesa.hide();
            DOM.blkAlertas.show();
            DOM.blkListarPedidos.hide();
            break;
        case 4: //LISTAR PEDIDOS
            DOM.blkSinAcciones.hide();
            DOM.blkPagarMesa.hide();
            DOM.blkAlertas.hide();
            DOM.blkListarPedidos.show();
            break;
    }
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
                    if ( !bandera ) {
                        if ( parseInt(item.espera) > 0 || parseInt(item.preparado) > 0) {
                            texto = "success";
                            actividad = 'onclick="abrirEspera('+item.id+",'"+item.numero+"','"+item.estado_convencional+"'"+')"';
                        }
                        else if ( parseInt(item.recogido) === 0 ) {
                            texto = "info";
                            actividad = "";

                        }else {
                            texto = "danger";
                            actividad = 'onclick="abrirFacturacion('+item.id+",'"+item.numero+"'"+ ')"';
                        }                   
                    }
                    html += '<button type="button" class="btn btn-'+texto+' btn-block" '+actividad+' >'+ item.numero+'</button>';
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

function abrirEspera(id_mesa,mesa,estado_convencional){
    bloque(4);
    DOM.codigo_mesa.val(id_mesa);
    DOM.mesa.val(mesa);
    DOM.estado_convencional.val(estado_convencional);
    DOM.blkListarPedidos.find(".titulo").text(mesa.substring(0,1)+ mesa.toLowerCase().substring(1)+": Detalle del Pedido");
    var funcion = function (resultado) {        
        if (resultado.estado === 200) {
            if ( resultado.datos.rpt === true ) {
                var html = '';
                DOM.btnPagoParcial.html('');
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
                            DOM.btnPagoParcial.html('<button type="button" class="btn btn-danger btn-block" onclick="abrirFacturacion('+id_mesa+",'"+mesa+"'"+ ')" >Pago Parcial</button>');
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
        metodo: "listarPedidosCajero",
        data_in : {
            p_id_mesa : id_mesa
        }
    }, funcion);
}

function abrirFacturacion(id_mesa,mesa){
    cargarMediosPago();
    DOM.titulo.text("Facturación para "+((mesa.substring(0,1) === 'M' ||mesa.substring(0,1) === 'B')  ? 'la ' :'el ')+mesa.toUpperCase());
    DOM.codigo_mesa.val(id_mesa);  
    bloque(2);
    
   

    var funcion = function (resultado) {        
        if (resultado.estado === 200) {
            if ( resultado.datos.rpt === true ){
                 var html = '';
                $.each(resultado.datos.msj.listado, function(i,item){
                    html += '<tr>';
                        html += '<td class="text-center">';
                            html += '<input type="checkbox" name="id_toma_pedido" value="'+item.id+'" style="margin-top: 7px;" checked>';
                        html += '</td>';
                        html += '<td class="text-center">';
                            html += '<div class="d-flex w-100 justify-content-between">';
                                html += '<h5>'+item.producto+'</h5>';                                
                                html += '<small>'+item.nota+'</small>';
                            html += '</div>';
                        html += '</td>';
                        
                        html += '<td class="text-center"><input type="number" name="inputNumber" value="'+item.cantidad+'" min="1" max="'+item.cantidad+'"></td>';
                        
                        html += '<td class="text-center">S/. '+item.precio+'</td>';
                        html += '<td class="text-center">S/. '+item.descuento+'</td>';
                        
                        html += '<td class="text-center" name="itemImporte">S/. '+item.importe+'</td>';
                    html += '</tr>';  
                    DOM.array.push(item.id);
                });
                DOM.listado_apagar.html(html);
                DOM.usuario.val(resultado.datos.msj.pedido.nombre_cliente);
                DOM.monto.val("S/. "+parseFloat(montoTotal()).toFixed(2));
                DOM.monto_descuento.val("S/. 0.00");
                DOM.monto_amortizacion.val("S/. "+parseFloat(montoTotal()).toFixed(2));
            }else{
                Validar.alert("warning",resultado.datos.msj.errorInfo[2],2000);
            }            
        }
    }

    new Ajxur.Api({
        modelo: "Pedido",
        metodo: "listarPedidoFacturacion",
        data_in : {
            p_id_mesa : DOM.codigo_mesa.val()
        }
    }, funcion);  
}

function montoTotal(){
    var importe = 0;
    $.each(DOM.listado_apagar.find("tr"), function(i, item){
        importe += parseFloat($(this).find("td").eq(5).html().split(" ")[1]);        
    });
    return importe;
}

function montoAmortizacion(){
    var importe = 0;
    $.each(DOM.listado_apagar.find("tr"), function(i, item){
        importe += parseFloat($(this).find("td").eq(5).html().split(" ")[1]);        
    });
    return importe;
}

function fecha(){
    var fecha = new Date(); //Fecha actual
    var mes = fecha.getMonth()+1; //obteniendo mes
    var dia = fecha.getDate(); //obteniendo dia
    var ano = fecha.getFullYear(); //obteniendo año
    if(dia<10){
        dia='0'+dia; //agrega cero si el menor de 10    
    }    
    if(mes<10){
        mes='0'+mes //agrega cero si el menor de 10 
    }
    return ano+"-"+mes+"-"+dia;    
}

function abrirReporte(){
    DOM.fecha_inicio.val(fecha());
    DOM.fecha_fin.val(fecha());
    cargarTurnosCB();
    bloque(3);
}

function listarTC(){
    var funcion = function (resultado) {        
        if (resultado.estado === 200) {
            if ( resultado.datos.rpt === true ){
                var html = '<option value="" selected>Seleccionar tipo comprobante</option>';                
                $.each(resultado.datos.msj, function(i,item){
                    html += '<option value="'+item.id+'">('+item.abreviatura+') '+item.nombre+'</option>';
                });
                DOM.tipo_comprobante.html(html);
            }else{
                Validar.alert("warning",resultado.datos.msj.errorInfo[2],2000);
            }            
        }
    }

    new Ajxur.Api({
        modelo: "Comprobante",
        metodo: "listarTC"
    }, funcion);  
}

function listarSC(){
    var funcion = function (resultado) {        
        if (resultado.estado === 200) {
            if ( resultado.datos.rpt === true ){
                var html = '<option value="" selected>Seleccionar tipo comprobante</option>';
                $.each(resultado.datos.msj, function(i,item){
                    html += '<option value="'+parseInt(item.numero)+'">'+item.numero+'</option>';
                });
                DOM.serie_comprobante.html(html);
            }else{
                Validar.alert("warning",resultado.datos.msj.errorInfo[2],2000);
            }            
        }
    }

    new Ajxur.Api({
        modelo: "Comprobante",
        metodo: "listarSC",
        data_in : {
            p_id_tipo_comprobante : DOM.tipo_comprobante.val()
        }
    }, funcion);  
}

function viewCorrelativo(){
    var funcion = function (resultado) {        
        if (resultado.estado === 200) {
            if ( resultado.datos.rpt === true ){
                DOM.correlativo.val(resultado.datos.msj.correlativo);                
            }else{
                Validar.alert("warning",resultado.datos.msj.errorInfo[2],2000);
            }            
        }
    }

    new Ajxur.Api({
        modelo: "Comprobante",
        metodo: "viewCorrelativo",
        data_in : {
            p_id_tipo_comprobante : DOM.tipo_comprobante.val(),
            p_numero : DOM.serie_comprobante.val()
        }
    }, funcion);  
}

function error(parametro){
    var funcion = function (resultado) {        
        console.log("OKIS ERROR");
    }
    new Ajxur.Api({
        modelo: "Log",
        metodo: "agregar",
        data_in : {
            p_nombre : parametro
        }
    }, funcion);
}

function GuardarFacturacion(){
    var funcion = function (resultado) {        
        if (resultado.estado === 200) {
            if (resultado.datos.rpt === true) { 
                DOM.codigo_mesa.val("");
                DOM.tipo_comprobante.val("");
                DOM.serie_comprobante.empty();
                DOM.correlativo.val("");
                DOM.documento.val("");
                DOM.razon_social.val("");
                DOM.direccion.val("");
                DOM.usuario.val("");
                DOM.monto.val("");
                DOM.monto_descuento.val("");
                DOM.monto_amortizacion.val("");
                DOM.listado_apagar.empty();
                DOM.cboMedioPago.val("s");
                bloque(1);
                $("#blkDireccion").hide();
                $("#confirmar_pago").modal("hide");
                DOM.cantidad_puntos.val("");
                DOM.ticket.val("");
                DOM.text_descuento.val("");
                DOM.listado_pedidos_puntos.html('<tr><td colspan="4" class="text-center">Sin resultados</td></tr>');
                DOM.array.splice(0,DOM.array.length);                
                Validar.alert("warning",resultado.datos.msj,2000);                    
                //window.open('../documento/index.php','_blank');
            }else{
                Validar.alert("warning",resultado.datos.msj.errorInfo[2],2000);                                   
            }            
        }
    }
    var producto = '';
    var cantidad = 0;
    let detallePdo = [];
    $.each(DOM.listado_apagar.find("tr"),function(i,item){
        let obj = {
            "cantidad" : parseInt($(this).find("td").eq(2).find("input").val()),
            "producto" : $(this).find("td").eq(1).find("h5").eq(0).html(),
            "precio" : $(this).find("td").eq(3).html().split(" ")[1],
            "descuento" : $(this).find("td").eq(4).html().split(" ")[1],
            "importe" : $(this).find("td").eq(5).html().split(" ")[1],
        }
        detallePdo.push(obj);

        //var dataset = this.dataset.id;
        //if ( this.dataset.id !== undefined ) {
            producto += $(this).find("td").eq(1).find("h5").eq(0).html();
            cantidad += parseInt($(this).find("td").eq(2).find("input").val());
        //}        
    });


    var json = JSON.stringify(DOM.array);

    const data_out = [
        DOM.tipo_comprobante.val(),
        DOM.serie_comprobante.val(),
        parseInt(DOM.correlativo.val()), 
        DOM.documento.val(),
        DOM.razon_social.val(),
        DOM.direccion.val(),
        DOM.usuario.val(),
        DOM.monto.val().split(" ")[1],
        DOM.monto_descuento.val().split(" ")[1],
        DOM.monto_amortizacion.val().split(" ")[1],
        DOM.ticket.val(),
        DOM.cboMedioPago.val(),
        producto,
        cantidad,
        DOM.cantidad_puntos.val(),
        json,
        //EXTRA POR MIENTRA DESPUES ARREGLAR PRODUCTOS
        JSON.stringify(detallePdo)

    ];

    new Ajxur.Api({
        modelo: "Pedido",
        metodo: "realizarPago",
        data_in : {
            p_id_mesa : DOM.codigo_mesa.val()
        },
        data_out : data_out
    }, funcion); 
}

function setEventos(){
    $(document).keydown(function(e){
        var code = (e.keyCode ? e.keyCode : e.which);
        if (code == 116 ) {
            e.preventDefault();
            return 0;
        }
    });

    DOM.listado_apagar.on("change","input[name=inputNumber]", function(){
        var fila = this.parentElement.parentElement;
        var cantidad=$(fila).find("td").eq(2).find("input").val();
        var precio=$(fila).find("td").eq(3).html().split(" ")[1];
        var subtotal=cantidad*precio;
        $(fila).find("td").eq(4).html('S/. '+parseFloat((DOM.text_descuento.val().split(" ")[0])/100*subtotal).toFixed(2));
        var descuento=$(fila).find("td").eq(4).html().split(" ")[1];
        var newImporte=cantidad*precio-descuento;                         
        $(fila).find("td").eq(5).html('S/. '+parseFloat(newImporte).toFixed(2));

        DOM.array.splice(0,DOM.array.length);
        var nodo = this.parentElement.parentElement.parentElement;
        var subtotal2 = 0;
        var descuentos = 0;

        $.each($(nodo).find("tr"), function(i,item){
            var input = $(this).find("td").eq(0);           

            if ( input.find("input")[0].checked ) {
                //console.log($(this).find("td").eq(5));
                subtotal2 += parseFloat($(this).find("td").eq(3).html().split(" ")[1])*parseFloat($(this).find("td").eq(2).find("input").val());
                descuentos += parseFloat($(this).find("td").eq(4).html().split(" ")[1]);
                //total += parseFloat($(this).find("td").eq(5).html().split(" ")[1]);
                DOM.array.push(input.find("input")[0].value);
            }            
        });
        DOM.monto.val('S/. '+parseFloat(subtotal2).toFixed(2));
        DOM.monto_descuento.val('S/. '+parseFloat(descuentos).toFixed(2));
        DOM.monto_amortizacion.val('S/. '+parseFloat(subtotal2-descuentos).toFixed(2)); 

    });

    DOM.listado_apagar.on("change","input[name=id_toma_pedido]", function(){
        DOM.array.splice(0,DOM.array.length);
        var nodo = this.parentElement.parentElement.parentElement;
        var subtotal = 0;
        var descuentos = 0;
        var total = 0;

        $.each($(nodo).find("tr"), function(i,item){
            var input = $(this).find("td").eq(0);           

            if ( input.find("input")[0].checked ) {
                //console.log($(this).find("td").eq(5));
                subtotal += parseFloat($(this).find("td").eq(3).html().split(" ")[1])*parseFloat($(this).find("td").eq(2).find("input").val());
                descuentos += parseFloat($(this).find("td").eq(4).html().split(" ")[1]);
                //total += parseFloat($(this).find("td").eq(5).html().split(" ")[1]);
                DOM.array.push(input.find("input")[0].value);
            }            
        });
        DOM.monto.val('S/. '+parseFloat(subtotal).toFixed(2));
        DOM.monto_descuento.val('S/. '+parseFloat(descuentos).toFixed(2));
        DOM.monto_amortizacion.val('S/. '+parseFloat(subtotal-descuentos).toFixed(2));        
    });


    $("input[name=intTipo]").change(function(){
        DOM.listar_reporte.empty();
    });
    
    DOM.btnPagar.click(function(){
        if ( DOM.tipo_comprobante.val() === "" )  {
            Validar.alert("warning","Debe seleccionar un tipo de comprobante",2000);
            return 0;
        }

        if ( DOM.serie_comprobante.val() === "" ) {
            Validar.alert("warning","Debe seleccionar un serie de comprobante",2000);
            return 0;
        }

        if ( DOM.correlativo.val() === "" ) {
            Validar.alert("warning","Debe haber seleccionado un serie para un correlativo",2000);
            return 0;
        }

        if ( DOM.tipo_comprobante.val() === "03" && DOM.documento.val() === "" ) {
            Validar.alert("warning","Debe ingresar el número de factura",2000);
            return 0;
        }

        if ( DOM.tipo_comprobante.val() === "02" && DOM.documento.val() === "" ) {
            Validar.alert("warning","Debe ingresar el número de DNI",2000);
            return 0;
        }
        if ( DOM.array.length == 0) {
            Validar.alert("warning","Debe seleccionar detalle de Pedido",2000);
            return 0;
        }

        $("#confirmar_pago").modal("show");        
    });

    DOM.ticket.keyup(function(e){
        var funcion = function (resultado) {        
            if (resultado.estado === 200) {
                if (resultado.datos.rpt === true) { 
                                        
                    var datos = resultado.datos.msj;
                    if ( datos === false ) return 0;
                    
                    if ( datos.porcentaje === undefined ) {
                        DOM.text_descuento.val("");
                        return 0;
                    }else{
                        $("#cargando").modal('show'); 
                        setTimeout(function(){ 
                            DOM.text_descuento.val(datos.porcentaje+" %");
                            $("#cargando").modal('hide');    
                        }, 100);  
                    }                                          
                }else{
                    Validar.alert("warning",resultado.datos.msj.errorInfo[2],2000);
                }            
            }
        }
        new Ajxur.Api({
            modelo: "PB",
            metodo: "buscarTicket",
            data_in : {
                p_ticket : DOM.ticket.val()
            }
        }, funcion);
    });

    DOM.documento.keyup(function(e){
        if ( DOM.tipo_comprobante.val() === "" || DOM.correlativo.val() === "" ||  ( DOM.serie_comprobante.val() === "" ||  DOM.serie_comprobante.val() === null ) ) {
            Validar.alert("warning","Debe completar el comprobante de pago",2000);
            DOM.documento.val("");
            return 0;
        }
        if ( DOM.documento.val().length < 11 && DOM.tipo_comprobante.val() === "03" ) {
            DOM.razon_social.val("");   
            return 0;
        }

        if ( DOM.documento.val().length < 8 && DOM.tipo_comprobante.val() === "02" ) {
            DOM.razon_social.val("");   
            return 0;
        }

        $("#cargando").modal('show');

        if ( DOM.tipo_comprobante.val() === "03" && DOM.documento.val().length === 11 ) {            
            var funcion = function (resultado) {        
                if (resultado.estado === 200) {
                    if (resultado.datos.rpt === true) {                    
                        var datos = resultado.datos.msj;
                        setTimeout(function(){ 
                            DOM.razon_social.val(datos.documento.informacion.razonSocial); 
                            var direccion = datos.documento.informacion.direccion === null ?
                                "SIN DOMICILIO FISCAL" : 
                                datos.documento.informacion.direccion;                                
                            $("#direccion").val(direccion);

                            var html = '';
                            if ( datos.puntos.length ===0 ) {
                                html += '<tr>';
                                    html += '<td colspan="4" class="text-center">Sin resultados</td>';
                                html += '</tr>'; 
                            }else{
                                $.each(datos.puntos, function(i,item){
                                html += '<tr>';
                                    html += '<td class="text-center"><button type="button" class="btn btn-info btn-xs" data-toggle="modal" data-target="#ver" onclick="abrirDetalle('+item.id+')" title="Ver detalle"><i class="far fa-eye"></i></button></td>';
                                    html += '<td class="text-center">'+item.comprobante+'</td>';
                                    html += '<td class="text-center">'+item.fecha_registro_facturacion+'</td>';
                                    html += '<td class="text-center">'+item.total+'</td>';
                                html += '</tr>';
                                });
                            }

                            DOM.listado_pedidos_puntos.html(html);
                            $("#cargando").modal('hide');    
                        }, 100);  
                                                                  
                    }else{
                        Validar.alert("warning",resultado.datos.msj.errorInfo[2],2000);
                    }            
                }
            }
            new Ajxur.Api({
                modelo: "Documento",
                metodo: "preguntar",
                data_in : {
                    p_documento : DOM.documento.val()
                }, 
                data_out : ["RUC"]
            }, funcion);        
        }

        if ( DOM.tipo_comprobante.val() === "02" && DOM.documento.val().length === 8 ) {
            var funcion = function (resultado) {        
                if (resultado.estado === 200) {
                    if (resultado.datos.rpt === true) { 
                        var datos = resultado.datos.msj;
                        setTimeout(function(){ 
                            DOM.razon_social.val(datos.documento.informacion.nombres+" "+datos.documento.informacion.apellidoPaterno+" "+datos.documento.informacion.apellidoMaterno);  

                            var html = '';
                            if ( datos.puntos.length ===0) {
                                html += '<tr>';
                                    html += '<td colspan="4" class="text-center">Sin resultados</td>';
                                html += '</tr>'; 
                            }else{
                                $.each(datos.puntos, function(i,item){
                                html += '<tr>';
                                    html += '<td class="text-center"><button type="button" class="btn btn-info btn-xs" data-toggle="modal" data-target="#ver" onclick="abrirDetalle('+datos.puntos.id+')" title="Ver detalle"><i class="far fa-eye"></i></button></td>';
                                    html += '<td class="text-center">'+item.comprobante+'</td>';
                                    html += '<td class="text-center">'+item.fecha_registro_facturacion+'</td>';
                                    html += '<td class="text-center">'+item.total+'</td>';
                                html += '</tr>';
                                });
                            }

                            DOM.listado_pedidos_puntos.html(html); 
                            $("#cargando").modal('hide');        
                        }, 100); 
                                                               
                    }else{
                        Validar.alert("warning",resultado.datos.msj.errorInfo[2],2000);
                    }            
                }
            }
            new Ajxur.Api({
                modelo: "Documento",
                metodo: "preguntar",
                data_in : {
                    p_documento : DOM.documento.val()
                },
                data_out : ["DNI"]
            }, funcion);
        }
        
    });

    DOM.tipo_comprobante.change(function(){
        switch(DOM.tipo_comprobante.val()){
            case "":
                $("#blkDireccion").hide();
                DOM.serie_comprobante.prop("disabled",false);
                DOM.correlativo.prop("disabled",false);
                DOM.documento.prop("disabled",false);
                DOM.serie_comprobante.empty();
                DOM.correlativo.val("");
                DOM.documento.val("");
                DOM.documento.prop("disabled",true);                
                DOM.razon_social.val("");
                DOM.direccion.val("");
                DOM.ticket.prop("disabled",false);
                break;
            case "01"://TICKET
                $("#blkDireccion").hide();
                DOM.serie_comprobante.prop("disabled",false);
                DOM.correlativo.val("");
                DOM.razon_social.val("");
                DOM.razon_social.prop("disabled",false);
                DOM.correlativo.prop("disabled",false);
                DOM.documento.prop("disabled",true);
                listarSC();    
                break;
            case "02"://BOLETA
                $("#blkDireccion").hide();
                DOM.serie_comprobante.prop("disabled",false);
                DOM.correlativo.val("");
                DOM.razon_social.val("");
                DOM.razon_social.prop("disabled",true);
                DOM.correlativo.prop("disabled",false);
                //DOM.documento.prop("disabled",false);
                listarSC();    
                break;
            case "03"://FACTURA
                $("#blkDireccion").show();
                DOM.serie_comprobante.prop("disabled",false);
                DOM.correlativo.val("");
                DOM.razon_social.val("");
                DOM.razon_social.prop("disabled",true);
                DOM.correlativo.prop("disabled",false);
                //DOM.documento.prop("disabled",false);
                listarSC();    
                break;                
        }     
    });

    DOM.serie_comprobante.change(function(){
        if ( DOM.serie_comprobante.val() !== "") {
            viewCorrelativo();
        }else{
            DOM.correlativo.val("");
        }
        if  (DOM.tipo_comprobante.val()==='02' ||DOM.tipo_comprobante.val()==='03')
        {
            DOM.documento.prop("disabled",false);
        }
    })

    DOM.btnCerrarReporte.click(function(){
        DOM.listar_reporte.empty();
        DOM.fecha_inicio.val(fecha());
        DOM.fecha_fin.val(fecha());
        bloque(1);
        DOM.codigo_mesa.val("");
    });

    DOM.btnCerrarPedidosListado.click(function(){
        bloque(1);
        DOM.codigo_mesa.val("");
    });

    DOM.btnFiltrarReporte.click(function(){
        var tipo;
        var finicio;
        var ffin;
        var turno=DOM.cboTurno.val();
        $.each($("input[name='intTipo']"), function(i,item){
            if ( $(this)[0].checked ) {
                tipo = $(this)[0].value;
            }
        });

        if(turno==='*'){
            finicio=DOM.fecha_inicio.val()+' 00:00:00';
            ffin=DOM.fecha_fin.val()+' 23:59:59';
        }
        if(turno==='1'){
            finicio=DOM.fecha_inicio.val()+' 00:00:00';
            ffin=DOM.fecha_fin.val()+' 23:59:59';
        }
        else if(turno==='2') {
            finicio=DOM.fecha_inicio.val()+' 00:00:00';
            ffin=DOM.fecha_fin.val()+' 15:59:59';
        }
        else if (turno==='3'){
            finicio=DOM.fecha_inicio.val()+' 16:00:00';
            ffin=DOM.fecha_fin.val()+' 23:59:59';
        }
        
        var funcion = function (resultado) {        
            if (resultado.estado === 200) {
                if (resultado.datos.rpt === true) { 
                    DOM.listar_reporte.empty();
                    if ( resultado.datos.msj.length === 0 ) {
                        Validar.alert("warning","No se encontrado datos para este reporte",2000);                        
                        return 0;
                    }else{
                        var html = '';
                        var suma  = 0;
                        var suma_subtotales  = 0;
                        var suma_descuentos = 0;
                        var suma_totales = 0;
                        var combo = document.getElementById("cboTurno");
                        html += '<table id="tb_export" class="table table-bordered">'
                        if ( tipo === "1" ) {
                            html += '<caption><font hidden>Reporte de Ventas con Fecha inicio: '+DOM.fecha_inicio.val()+' Fecha Fin: '+DOM.fecha_fin.val()+' en el turno "'+combo.options[combo.selectedIndex].text+'"</font></caption>';
                            html += '<thead>';
                                html += '<tr>';
                                    html += '<th class="text-center" scope="col"></th>';
                                    html += '<th class="text-center" scope="col">Comprobante</th>';
                                    html += '<th class="text-center" scope="col">Fecha pedido</th>';
                                    html += '<th class="text-center" scope="col">Fecha facturación</th>';
                                    html += '<th class="text-center" scope="col">SubTotal</th>';                                    
                                    html += '<th class="text-center" scope="col">Descuento</th>';                                    
                                    html += '<th class="text-center" scope="col">Total</th>';                                    
                                    html += '<th class="text-center" scope="col">Ticket</th>';
                                    html += '<th class="text-center" scope="col">Medio Pago</th>';
                                html += '</tr>';
                            html += '</thead>';
                            html += '<tbody>';
                            $.each(resultado.datos.msj, function(i,item){
                                html += '<tr data-id="'+item.id_pedido+'">';
                                    html += '<td class="text-center">';
                                        html += '<button type="button" class="btn btn-info btn-xs" data-toggle="modal" data-target="#ver" onclick="abrirDetalle('+item.id+')" title="Ver detalle"><i class="far fa-eye"><font hidden>'+item.id+'</font></i></button>';
                                    html += '</td>';
                                    html += '<td class="text-center">'+item.comprobante+'</td>';
                                    html += '<td class="text-center">'+item.fecha_registro_pedido+'</td>';
                                    html += '<td class="text-center">'+item.fecha_registro_facturacion+'</td>';
                                    html += '<td class="text-center">S/. '+item.subtotal+'</td>';
                                    html += '<td class="text-center">S/. '+item.descuentos+'</td>';
                                    html += '<td class="text-center">S/. '+item.total+'</td>';
                                    html += '<td class="text-center">'+item.ticket+'</td>';                                
                                    html += '<td class="text-center">'+item.medioPago+'</td>';
                                html += '</tr>';
                                suma_subtotales  += parseFloat(item.subtotal);  
                                suma_descuentos+= parseFloat(item.descuentos);  
                                suma_totales+= parseFloat(item.total);  
                            });
                            html += '<tr><td colspan="4"></td><td class="text-center">S/. '+suma_subtotales.toFixed(2)+'</td><td class="text-center">S/. '+suma_descuentos.toFixed(2)+'</td><td class="text-center">S/. '+suma_totales.toFixed(2)+'</td></tr>';
                            html += '</tbody>';
                        }else{
                            html += '<caption><font hidden>Reporte de Productos con Fecha inicio: '+DOM.fecha_inicio.val()+' Fecha Fin: '+DOM.fecha_fin.val()+' en el turno "'+combo.options[combo.selectedIndex].text+'"</font></caption>';
                            html += '<thead>';
                                html += '<tr>';
                                    html += '<th class="text-center" scope="col">Item</th>';
                                    html += '<th class="text-center" scope="col">Producto</th>';
                                    html += '<th class="text-center" scope="col">Cantidad</th>';
                                    html += '<th class="text-center" scope="col">Monto</th>';
                                html += '</tr>';
                            html += '</thead>';
                            html += '<tbody>';
                            $.each(resultado.datos.msj, function(i,item){
                                html += '<tr data-id="'+item.id_pedido+'">';
                                    html += '<td class="text-center">'+(i+1)+'</td>';
                                    html += '<td class="text-center">'+item.nombre+'</td>';
                                    html += '<td class="text-center">'+item.cantidad+'</td>';
                                    html += '<td class="text-center">S/. '+item.monto+'</td>';
                                html += '</tr>';
                                suma  += parseFloat(item.monto);  
                            });
                            html += '</tbody>';
                            html += '<tr><td colspan="3"></td><td class="text-center">S/. '+suma.toFixed(2)+'</td></tr>';
                        }
                        html += '</table>';
                        DOM.listar_reporte.html(html); 
                    }                    
                }else{
                    Validar.alert("warning",resultado.datos.msj.errorInfo[2],2000);       
                }            
            }
        }
        new Ajxur.Api({
            modelo: "Pedido",
            metodo: "reportePago",
            data_out : [tipo,finicio,ffin]
            //data_out : [tipo,DOM.fecha_inicio.val(),DOM.fecha_fin.val()]
        }, funcion);
    });

    DOM.btnCerrarPago.click(function(){
        DOM.tipo_comprobante.val("");
        DOM.serie_comprobante.empty();
        DOM.correlativo.val("");
        DOM.documento.val("");
        DOM.documento.prop('disabled',true);
        DOM.razon_social.val("");
        DOM.direccion.val("");
        $("#blkDireccion").hide();
        DOM.listado_apagar.empty();
        bloque(1);
        DOM.codigo_mesa.val("");
        DOM.monto.val("");
        DOM.monto_descuento.val("");
        DOM.monto_amortizacion.val("");
        DOM.cantidad_puntos.val("");
        DOM.ticket.val("");
        DOM.ticket.prop('disabled',false);
        DOM.text_descuento.val("");
        DOM.listado_pedidos_puntos.html('<tr><td colspan="4" class="text-center">Sin resultados</td></tr>');  
        DOM.array.splice(0,DOM.array.length);        
        DOM.btnDescuento.prop("disabled",false);      
    });
}

function agregarDescuento(){
    if ( DOM.text_descuento.val() === "" ) {        
        Validar.alert("warning","No tiene ningún descuento",2000);
        return 0;
    }

    var monto_amortizacion = parseFloat(DOM.monto_amortizacion.val().split(" ")[1]);
    var monto_descuento = monto_amortizacion*parseFloat(DOM.text_descuento.val().split(" ")[0])/100;
    var nuevo_amortizacion = monto_amortizacion-monto_descuento;

    DOM.monto_descuento.val("S/. "+parseFloat(monto_descuento).toFixed(2));
    DOM.monto_amortizacion.val("S/. "+parseFloat(nuevo_amortizacion).toFixed(2));
    DOM.ticket.prop("disabled", true);
    DOM.btnDescuento.prop("disabled",true);
    
    $.each( DOM.listado_apagar.find("tr"), function(key, value){
        $cantidad = parseInt($(this).find("td").eq(2).find("input").val());
        $precio = parseFloat($(this).find("td").eq(3).html().split(" ")[1]);
        $subtotal = $cantidad*$precio;        
        $importe = parseFloat($subtotal-($subtotal*parseFloat(DOM.text_descuento.val().split(" ")[0])/100)).toFixed(2);
        $descuento = parseFloat($subtotal - $importe).toFixed(2);

        $(this).find("td").eq(4).html(`S/. ${$descuento}`);
        $(this).find("td").eq(5).html(`S/. ${$importe}`);
    });
}

function borrarDescuento(){
    DOM.text_descuento.val("");
    DOM.ticket.val("");
    DOM.ticket.prop("disabled", false);
    DOM.btnDescuento.prop("disabled",false);

    DOM.monto_descuento.val("S/.0.00 ");
    DOM.monto_amortizacion.val(DOM.monto.val());
        
    $.each( DOM.listado_apagar.find("tr"), function(key, value){
        $descuento = parseFloat(0.00).toFixed(2);
        $(this).find("td").eq(4).html(`S/. ${$descuento}`);
    });
}


function abrirDetalle(id_pedido){
    var funcion = function (resultado) {        
        if (resultado.estado === 200) {
            if (resultado.datos.rpt === true) { 
                var html = '';
                var suma_subtotales  = 0;
                var suma_descuentos = 0;
                var suma_totales = 0;
                $.each(resultado.datos.msj.rpt, function(i,item){
                    html += '<tr>';
                        html += '<td class="text-center">';
                            html += '<div class="justify-content-between">';
                                html += '<h5>'+item.producto+'</h5>';                                
                                html += '<small>'+item.nota+'</small>';
                            html += '</div>';
                        html += '</td>';
                        html += '<td class="text-center">S/. '+item.precio+'</td>';
                        html += '<td class="text-center">'+item.cantidad+'</td>';                                                
                        html += '<td class="text-center">S/. '+item.importe+'</td>';
                        html += '<td class="text-center">S/. '+item.descuento+'</td>';
                        html += '<td class="text-center">S/. '+item.total+'</td>';
                    html += '</tr>';
                    suma_subtotales  += parseFloat(item.importe);  
                    suma_descuentos+= parseFloat(item.descuento);  
                    suma_totales+= parseFloat(item.total); 
                });
                html += '<tr><td colspan="3"></td><td class="text-center">S/. '+suma_subtotales.toFixed(2)+'</td><td class="text-center">S/. '+suma_descuentos.toFixed(2)+'</td><td class="text-center">S/. '+suma_totales.toFixed(2)+'</td></tr>';
                $("#listado-ver").html(html);                 
                DOM.texto_usuario_detalle.html('<h5>USUARIO: '+resultado.datos.msj.etiqueta+'</h5>');    
                DOM.mesa_usuario_detalle.html('<h5>'+resultado.datos.msj.mesa+'</h5>');                                                    
                DOM.fecha_usuario_detalle.html('<h5>'+resultado.datos.msj.fecha+'</h5>'); 
            }else{
                Validar.alert("warning",resultado.datos.msj.errorInfo[2],2000);       
            }            
        }
    }
    new Ajxur.Api({
        modelo: "Pedido",
        metodo: "verDetallePedidoPagado",
        data_in : {
            p_id : id_pedido
        }
    }, funcion);
}


function cerrarSesion(){
    $("#confirmar_sesion").modal("show");
}

function FinSesion(){
    DOM.array.splice(0,DOM.array.length);
    document.location.href = "cerrar_sesion.php";
}

function listarPromociones(){
    var funcion = function (resultado) {        
        if (resultado.estado === 200) {
            if ( resultado.datos.rpt === true ){
                var html = "";
                $.each(resultado.datos.msj, function(i,item){
                    html += '<tr onclick="usar_puntos('+item.id+')" style="cursor:pointer;">';
                        html += '<td class="text-center">'+(i+1)+'</td>';
                        html += '<td class="text-center">('+item.cantidad_producto+') '+item.producto+'</td>';
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

function usar_puntos(id){ 
    if ( DOM.listado_pedidos_puntos.find("td").length === 1 ) {
        Validar.alert("warning","No tiene referencia de puntos", 2000);
        return 0;
    }

    var funcion = function (resultado) {        
        if (resultado.estado === 200) {
            if ( resultado.datos.rpt === true ){

                var cantidad_puntos = parseInt(resultado.datos.msj.cantidad_puntos);
                var cantidad_referencia = parseInt(DOM.listado_pedidos_puntos.find("td").eq(2).html());           

                if ( cantidad_puntos > cantidad_referencia ) {
                    Validar.alert("warning","No tiene suficientes puntos para reclamar",2000);
                    return 0;
                }

                var suma  = 0;
                $.each(DOM.listado_apagar.find("tr"), function(i,item){
                    var producto = $(this).find("td").eq(0).find("h5").eq(0).html();

                    if ( producto == resultado.datos.msj.nombre ) {
                        suma  += parseInt($(this).find("td").eq(1).html());    
                    }
                });

                if ( suma  === 0 ) {
                    Validar.alert("warning","Ningún pedido es similar a la promoción",2000);
                    return 0;
                }

                if ( suma  < parseInt(resultado.datos.msj.cantidad_producto) ) {
                    Validar.alert("warning","No tiene suficiente cantidad para reclamar tu promoción",2000);
                    return 0;   
                }

                DOM.cantidad_puntos.val(resultado.datos.msj.cantidad_puntos);

                var importe = parseFloat(parseInt(resultado.datos.msj.cantidad_producto)*parseFloat(resultado.datos.msj.precio)).toFixed(2);
                var bandera = false;
                $.each(DOM.listado_apagar.find("tr"), function(i,item){
                    if ( this.dataset.id !== undefined ) {
                        bandera = true;
                    }
                });

                if ( bandera ) {
                    Validar.alert("warning","Ud ya tiene una promoción por puntos actualmente",2000);
                    return 0;
                }

                var html = '';
                html += '<tr data-id="1">';
                    html += '<td class="text-center">';
                        html += '<div class="d-flex w-100 justify-content-between">';
                            html += '<h5>'+resultado.datos.msj.nombre+'</h5>';                                
                            html += '<small></small>';
                        html += '</div>';
                    html += '</td>';
                    html += '<td class="text-center">'+resultado.datos.msj.cantidad_producto+'</td>';
                    html += '<td class="text-center">S/. '+resultado.datos.msj.precio+'</td>';        
                    html += '<td class="text-center" style="color:red;">(S/. '+importe+')</td>';
                html += '</tr>';                    
                DOM.listado_apagar.append(html);

                var amortizacion = parseFloat(DOM.monto_amortizacion.val().split(" ")[1]);
                var precio = parseFloat(resultado.datos.msj.precio);
                var nueva_amortizacion = amortizacion-precio;

                DOM.monto_amortizacion.val("S/. "+parseFloat(nueva_amortizacion).toFixed(2));
            } else{
                Validar.alert("warning",resultado.datos.msj.errorInfo[2],2000);                                
            }           
        }
    }

    new Ajxur.Api({
        modelo: "PP",
        metodo: "leerDatos",
        data_in : {
            p_id : id
        }
    }, funcion); 
}
var tableToExcel = (function() {
  var uri = 'data:application/vnd.ms-excel;base64,'
    , template = '<html xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:x="urn:schemas-microsoft-com:office:excel" xmlns="http://www.w3.org/TR/REC-html40"><meta http-equiv="content-type" content="application/vnd.ms-excel; charset=UTF-8"><head><!--[if gte mso 9]><xml><x:ExcelWorkbook><x:ExcelWorksheets><x:ExcelWorksheet><x:Name>{worksheet}</x:Name><x:WorksheetOptions><x:DisplayGridlines/></x:WorksheetOptions></x:ExcelWorksheet></x:ExcelWorksheets></x:ExcelWorkbook></xml><![endif]--></head><body><table>{table}</table></body></html>'
    , base64 = function(s) { return window.btoa(unescape(encodeURIComponent(s))) }
    , format = function(s, c) { return s.replace(/{(\w+)}/g, function(m, p) { return c[p]; }) }
  return function(table, name) {
    if (!table.nodeType) table = document.getElementById(table)
    var ctx = {worksheet: name || 'Hoja1', table: table.innerHTML}
    window.location.href = uri + base64(format(template, ctx))
  }
})()

function cargarTurnosCB(){
    var funcion = function (resultado) {        
        if (resultado.estado === 200) {
            if (resultado.datos.rpt === true) {
                var html = "";               
                //html += '<option value="*">Seleccione un turno</option>';
                $.each(resultado.datos.msj, function (i, item) { 
                    html += '<option value="' + item.id + '">'+ item.descripcion + '</option>';
                });
                DOM.cboTurno.html(html);
            }else{
                Validar.alert("warning",resultado.datos.msj.errorInfo[2],2000); 
            }            
        }
    };

    new Ajxur.Api({
        modelo: "Turnos",
        metodo: "llenarCB"
    }, funcion);
}   

function cargarMediosPago(){
    var funcion = function (resultado) {        
        if (resultado.estado === 200) {
            if (resultado.datos.rpt === true) {
                var html = "";               
                //html += '<option value="*">Seleccione un turno</option>';
                $.each(resultado.datos.msj, function (i, item) { 
                    html += '<option value="' + item.id + '">'+ item.descripcion + '</option>';
                });
                DOM.cboMedioPago.html(html);
            }else{
                Validar.alert("warning",resultado.datos.msj.errorInfo[2],2000); 
            }            
        }
    };

    new Ajxur.Api({
        modelo: "MediosPago",
        metodo: "llenarCB"
    }, funcion);
}  