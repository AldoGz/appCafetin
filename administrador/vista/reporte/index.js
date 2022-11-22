var DOM = {};
$(document).ready(function () {
    setDOM();        
    cargarTurnosCB();
    abrirReporte();
    
});
function abrirReporte(){
    DOM.fecha_inicio.val(fecha());
    DOM.fecha_fin.val(fecha());
    //bloque(3);
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
        mes='0'+mes; //agrega cero si el menor de 10 
    }
    return ano+"-"+mes+"-"+dia;    
}

function setDOM() {
    DOM.fecha_inicio = $("#fecha_inicio");
    DOM.fecha_fin = $("#fecha_fin");
    DOM.listar_reporte = $("#listado-reporte");
    DOM.texto_usuario_detalle = $("#texto-usuario");
    DOM.mesa_usuario_detalle = $("#mesa-usuario");
    DOM.cboTurno = $("#cboTurno");
}

function filtrarReporte(){
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
                DOM.cboTurno.html(html).selectpicker('refresh');
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


