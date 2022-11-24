var DOM = {};

$(document).ready(function () {
    setDOM();
    $(document).keydown(function(e){
        var code = (e.keyCode ? e.keyCode : e.which);
        if (code == 116 ) {
            e.preventDefault();
            return 0;
        }
    });
    cargarTipoServicio();
    refresh();
});
function setDOM() {
    DOM.t2 = $("#t2"),
    DOM.listado_t2_mesas = $("#listado-t2-mesas"),
    DOM.listado_t2_mesas_combinacion = $("#listado-t2-mesas-combinacion"),
    DOM.array = [];
    DOM.array2 = [];
    DOM.listado_t2_resumen = $("#listado-t2-resumen");
}

function cargarTipoServicio(){
    var funcion = function (resultado) {        
        if (resultado.estado === 200) {
            if (resultado.datos.rpt === true) {                                
                DOM.t2.text(" ("+resultado.datos.msj[1].nombre+")");
            }else{
                alert(resultado.datos.msj.errorInfo[2]);
            }            
        }
    }

    new Ajxur.Api({
        modelo: "TipoServicio",
        metodo: "llenarCB"
    }, funcion);
}


function refresh(){
    setInterval(cargarMesas, 1000);
    $.ajaxSetup({ cache: false })
}

function init(tabla,data,listado,detalle){
    mesas(tabla,data,listado,detalle);
}

function cinit(tabla,data,listado,detalle){
    mesas2(tabla,data,listado,detalle);
}

function cargarMesas(){
    var funcion = function (resultado) {        
        if (resultado.estado === 200) {
            if (resultado.datos.rpt === true) {
                init(
                    DOM.listado_t2_mesas.find("div.tabla"),
                    resultado.datos.msj.tabla,
                    DOM.listado_t2_mesas,
                    resultado.datos.msj.detalle
                );

                /* cinit(
                    DOM.listado_t2_mesas_combinacion.find("div.tabla"),
                    resultado.datos.msj.tabla2,
                    DOM.listado_t2_mesas_combinacion,
                    resultado.datos.msj.detalle2
                ); */

                cinit(
                    DOM.listado_t2_mesas_combinacion.find("div.tabla"),
                    resultado.datos.msj.test,
                    DOM.listado_t2_mesas_combinacion,
                    resultado.datos.msj.detalle2
                );
                listado_resumen(resultado.datos.msj.resumen);
                timbre(resultado.datos.msj.timbre,2);
            }else{
                Validar.alert("warning",resultado.datos.msj.errorInfo[2],2000);
            }            
        }
    }

    new Ajxur.Api({
        modelo: "Pedido",
        metodo: "listarMesasEnEspera",
        data_out : [2]
    }, funcion);
}


function mesas(tabla,data,listado,detalle){    
    if ( tabla.length > data.length ) {
        var id_mesa = obtenerMesaEliminar(tabla,data);
        DOM.array.splice(detenerCronometro(id_mesa),1);                    
    }

    if ( tabla.length < data.length ) {
        var html = '';
        /* switch(tabla.length){
            case 0:                
                $.each(data, function(i,item){
                    var actual = new Date().getTime();
                    var inicio = new Date(item.fecha_registro).getTime();
                    var diff = new Date(actual-inicio);
                    
                    if ( diff.getUTCMinutes() >= 5 && diff.getUTCSeconds() >= 0 ) {
                        anularToo(item.id_mesa);
                        DOM.array.splice(detenerCronometro(item.id_mesa),1);  
                    }else{
                        html += iniciarMesa(item,detalle);
                        iniciarCronometro(item.id_mesa, item.fecha_registro);       
                    }                    
                });
                break;
            default: */

                $.each(data, function(i,item){                    
                    if ( tabla[i] === undefined ) {
                        var actual = new Date().getTime();
                        var inicio = new Date(item.fecha_registro).getTime();
                        var diff = new Date(actual-inicio);
                        
                        if ( diff.getUTCMinutes() >= 15 && diff.getUTCSeconds() >= 0 ) {
                            anularToo(item.id_mesa);
                            DOM.array.splice(detenerCronometro(item.id_mesa),1);  
                        }else{
                            html += iniciarMesa(item,detalle); 
                            iniciarCronometro(item.id_mesa,item.fecha_registro);
                        }                         
                    }
                });
                /* break;
        } */
        console.log("data=>",data);
        console.log("tabla=>",tabla)

        listado.append(html);        
    }
    //tomaPedido(tabla,detalle);
}




function iniciarMesa(item,detalle){    
    var html = '';
    html += '<div class="col-md-12 tabla" data-id="'+item.id_mesa+'">';
        html += '<div class="body" style="background: #000000;border: 17px solid;border-color: #dcd2cb;margin-bottom: 20px;">';
            html += '<div style="margin: 20px;color: white;">';
                /*CABECERA*/
                html += '<div class="d-flex justify-content-between align-items-center" style="justify-content: center;">';
                    html += item.mesa;
                    html += '<h5 id="cronometro'+item.id_mesa+'">';
                        html += '<span class="badge badge-success badge-pill">';
                            html += '<min id="cron01-'+item.id_mesa+'">00:00</min>';
                        html += '</span>';
                    html += '</h5>';
                html += '</div>';  
                /*CABECERA*/
                /*CUERPO*/
                html += '<div id="detalle-pedido'+item.id_mesa+'">';
                    $.each(detalle,function(key,value){
                        if ( item.id_mesa == value.id_mesa ) {                                
                            n
                        }                                 
                    });
                html += '</div>';  
                /*CUERPO*/
                /*PIE*/
                html += '<p style="margin-top:40px;font-size: 20px;"><small>'+item.empleado+'</small></p>';                                            
                /*PIE*/
            html += '</div>';
        html += '</div>';
    html += '</div>';
    return html;
}

function tomaPedido(tabla,detalle){
    //ACA VIENE EL SONIDO
    $.each(tabla,function(i,item){
        var html = '';
        var referencia = this.dataset.id; 
        $.each(detalle,function(key,value){
            if ( referencia == value.id_mesa ) {                                
                html += '<div class="btn btn-default btn-lg btn-block alert" role="alert" style="height: 68px;color: white;" onclick="cambiarEstado('+value.id+","+value.id_mesa+')">';                                        
                    html += '<h5 class="alert-heading" style="font: oblique bold 75% cursive;color: white;font-size: 30px;">'+value.cantidad+' '+value.producto+'</h5>';
                    html += '<p style="font: oblique bold 45% cursive;color: white;font-size: 20px;">'+value.nota+'</p>';
                html += '</div>'; 
            }                                 
        });
        $("#detalle-pedido"+referencia).html(html);        
    });
}

function iniciarCronometro(id_mesa, fecha_registro){
    var actividad = id_mesa;
    var cronometro = "#cron01-"+actividad;

    var tiempo_corriendo = setInterval(function(){
        // obteneos la fecha actual
        var actual = new Date().getTime();
        var inicio = new Date(fecha_registro).getTime();
 
        // obtenemos la diferencia entre la fecha actual y la de inicio
        var diff = new Date(actual-inicio);

        

        $(cronometro).text(LeadingZero(diff.getUTCMinutes())+":"+LeadingZero(diff.getUTCSeconds()));


        if ( diff.getUTCMinutes() >= 1 && diff.getUTCSeconds() >= 30 ) {
            $("#cronometro"+actividad)[0].children[0].classList.remove("badge-success");
            $("#cronometro"+actividad)[0].children[0].classList.add("badge-warning");
        }

        if ( diff.getUTCMinutes() >= 3 ) {
            $("#cronometro"+actividad)[0].children[0].classList.remove("badge-warning");
            $("#cronometro"+actividad)[0].children[0].classList.add("badge-danger");
        } 
        if ( diff.getUTCMinutes() >= 5 && diff.getUTCSeconds() >= 0 ) {
            anularToo(id_mesa);
            DOM.array.splice(detenerCronometro(id_mesa),1);  
        }
    }, 1000);     
    DOM.array.push({id_mesa:id_mesa,interval:tiempo_corriendo});
}

function detenerCronometro(id_mesa){
    var indice;
    $.each(DOM.array, function(i,item){
        if ( item.id_mesa === id_mesa ) {
            indice = i;            
            clearInterval(item.interval);           
        }
    });
    return indice;
}

function cambiarEstado(codigo_pedido,id_mesa){
    var actividad = id_mesa;
    var kpi = $("#cron01-"+actividad).get(0).textContent;

    var funcion = function (resultado) {        
        if (resultado.estado === 200) {
            if (resultado.datos.rpt === true) {                 
                Validar.alert("warning",resultado.datos.msj,2000);
            }else{
                Validar.alert("warning",resultado.datos.msj.errorInfo[2],2000);                
            }            
        }
    }

    new Ajxur.Api({
        modelo: "Pedido",
        metodo: "cambiarEstadoPreparado",
        data_in : {
            p_id : codigo_pedido
        },
        data_out : [kpi]
    }, funcion);
}

function timbre(estado,tipo){    
    if ( parseInt(estado) > 0 ) {                
        audio = new Audio();
        audio.src = "sound.mp3";       
        audio.play();        
        var funcion = function (resultado) {        
            if (resultado.estado === 200) {
                if (resultado.datos.rpt === false ){
                    Validar.alert("warning",resultado.datos.msj.errorInfo[2],2000);
                }            
            }
        }
        new Ajxur.Api({
            modelo: "Pedido",
            metodo: "desactivarTimbre",
            data_out : [tipo]
        }, funcion);
    }
}

function listado_resumen(detalle){   
    var html = '';
    $.each(detalle, function(i,item){

        html += '<div class="alert alert-secondary" role="alert">';
            html += item.cantidad+' '+item.producto;
            html += '<br><small>'+item.nota+'</small></br>';
        html += '</div>';

    });
    DOM.listado_t2_resumen.html(html);
}

function obtenerMesaEliminar(tabla,data){
    var id_mesa = '';
    $.each(tabla, function(i,item){ 
        var bandera = true;
        var referencia = this.dataset.id;
        $.each(data, function(k,v){
            if ( referencia === v.id_mesa ) {
                bandera = false;
            }
        });

        if ( bandera ) {
            id_mesa = referencia;
            this.remove();
        }                       
    });
    return id_mesa;
}

function obtenerMesaEliminar2(tabla,data){
    var id_mesa = '';
    $.each(tabla, function(i,item){ 
        var bandera = true;
        var referencia = this.dataset.id;
        $.each(data, function(k,v){
            if ( referencia === v.id_mesa ) {
                bandera = false;
            }
        });

        if ( bandera ) {
            id_mesa = referencia;
            this.remove();
        }                       
    });
    return id_mesa;
}



function mesas2(tabla,data,listado,detalle){
    if ( tabla.length > data.length ) {
        var id_mesa = obtenerMesaEliminar2(tabla,data);
        DOM.array.splice(detenerCronometro2(id_mesa),1);                    
    }

    if ( tabla.length < data.length ) {
        var html = '';
        /* switch(tabla.length){
            case 0:
                $.each(data, function(i,item){
                    var actual = new Date().getTime();
                    var inicio = new Date(item.fecha_registro).getTime();
                    var diff = new Date(actual-inicio);
                    
                    if ( diff.getUTCMinutes() >= 5 && diff.getUTCSeconds() >= 0 ) {
                        anularToo(item.id_mesa);
                        DOM.array.splice(detenerCronometro(item.id_mesa),1);  
                    }else{
                        html += iniciarMesa2(item,detalle);
                        iniciarCronometro2(item.id_mesa, item.fecha_registro);       
                    } 
                });
                break;
            default:
                $.each(data, function(i,item){
                    if ( tabla[i] === undefined ) {
                        var actual = new Date().getTime();
                        var inicio = new Date(item.fecha_registro).getTime();
                        var diff = new Date(actual-inicio);
                        
                        if ( diff.getUTCMinutes() >= 5 && diff.getUTCSeconds() >= 0 ) {
                            anularToo(item.id_mesa);
                            DOM.array.splice(detenerCronometro(item.id_mesa),1);  
                        }else{
                            html += iniciarMesa2(item,detalle);
                            iniciarCronometro2(item.id_mesa, item.fecha_registro);       
                        }                         
                    }
                });
                break;
        } */
        
        $.each(data, function(i,item){
            if ( tabla[i] === undefined ) {
                /* var actual = new Date().getTime();
                var inicio = new Date(item.fecha_registro).getTime();
                var diff = new Date(actual-inicio);
                
                if ( diff.getUTCMinutes() >= 5 && diff.getUTCSeconds() >= 0 ) {
                    anularToo(item.id_mesa);
                    DOM.array.splice(detenerCronometro(item.id_mesa),1);  
                }else{ */
                    html += iniciarMesa2(item,detalle);
                    iniciarCronometro2(item.id_mesa, item.fecha_registro);       
                //}                         
            }
        });
        listado.append(html);        
    }
    tomaPedido2(tabla,data);
}


function iniciarMesa2(item,detalle){    
    console.log(item);
    var html = '';
    html += '<div class="col-md-4 tabla" data-id="'+item.id_mesa+'">';
        html += '<div class="body" style="background: #000000;border: 17px solid;border-color: #dcd2cb;margin-bottom: 20px;">';
            html += '<div style="margin: 20px;color: white;">';
                /*CABECERA*/
                html += '<div class="d-flex justify-content-between align-items-center" style="justify-content: center;">';
                    html += '<span style="font-size: 20px;font: oblique bold cursive;">'+item.mesa+'</span>';
                    html += '<h5 id="ccronometro'+item.id_mesa+'">';
                        html += '<span class="badge badge-success badge-pill">';                        
                            html += '<min id="cron02-'+item.id_mesa+'">--:--</min>';                            
                        html += '</span>';
                    html += '</h5>';
                html += '</div>';  
                /*CABECERA*/



                /*CUERPO*/
                html += '<div id="cdetalle-pedido'+item.id_mesa+'">';
                    $.each(item.children,function(key,value){                        
                        html += '<div class="btn btn-default btn-lg btn-block alert" role="alert" style="height: 68px;color: white;" onclick="cambiarEstado2('+value.id+","+item.id_mesa+')">';
                            html += '<h5 class="alert-heading" style="font: oblique bold 75% cursive;color: white;font-size: 30px;">'+value.cantidad+' '+value.producto+'</h5>';
                            html += '<p style="font: oblique bold 45% cursive;color: white;font-size: 20px;">'+value.nota+ '</p>';
                        html += '</div>';                          
                    });
                html += '</div>';  
                /*CUERPO*/
                /*PIE*/
                html += '<p style="margin-top:40px;font-size: 20px;"><small>'+item.empleado+'</small></p>';                                            
                /*PIE*/
            html += '</div>';
        html += '</div>';
    html += '</div>';
    return html;
}


function tomaPedido2(tabla,data){
    
    $.each(tabla,function(i,item){
        var html = '';
        var referencia = this.dataset.id;
        $.each(data[i].children,function(key,value){
            if ( referencia == value.id_mesa ) {                                
                html += '<div class="btn btn-default btn-lg btn-block alert" role="alert" style="height: 68px;color: white;" onclick="cambiarEstado2('+value.id+","+value.id_mesa+')">';                     
                    html += '<h5 class="alert-heading" style="font: oblique bold 75% cursive;color: white;font-size: 30px;">'+value.cantidad+' '+value.producto+'</h5>';
                    html += '<p style="font: oblique bold 45% cursive;color: white;font-size: 20px;">'+value.nota+'</p>';
                html += '</div>'; 
            }                                 
        });
        $("#cdetalle-pedido"+referencia).html(html);        
    });
}

function iniciarCronometro2(id_mesa, fecha_registro){
    var actividad = id_mesa;
    var cronometro = "#cron02-"+actividad;

    var tiempo_corriendo = setInterval(function(){
        // obteneos la fecha actual
        var actual = new Date().getTime();
        var inicio = new Date(fecha_registro).getTime();
 
        // obtenemos la diferencia entre la fecha actual y la de inicio
        var diff = new Date(actual-inicio);

        

        $(cronometro).text(LeadingZero(diff.getUTCMinutes())+":"+LeadingZero(diff.getUTCSeconds()));


        if ( diff.getUTCMinutes() >= 1 && diff.getUTCSeconds() >= 30 ) {
            $("#ccronometro"+actividad)[0].children[0].classList.remove("badge-success");
            $("#ccronometro"+actividad)[0].children[0].classList.add("badge-warning");
        }

        if ( diff.getUTCMinutes() >= 3 ) {
            $("#ccronometro"+actividad)[0].children[0].classList.remove("badge-warning");
            $("#ccronometro"+actividad)[0].children[0].classList.add("badge-danger");
        } 
        /* if ( diff.getUTCMinutes() >= 5 && diff.getUTCSeconds() >= 0 ) {
            anularToo(id_mesa);
            DOM.array.splice(detenerCronometro(id_mesa),1);  
        } */
    }, 1000);     
    DOM.array2.push({id_mesa:id_mesa,interval:tiempo_corriendo});    
}

/* Funcion que pone un 0 delante de un valor si es necesario */
function LeadingZero(Time){
    return (Time < 10) ? "0" + Time : + Time;
}


function detenerCronometro2(id_mesa){
    var indice;
    $.each(DOM.array2, function(i,item){
        if ( item.id_mesa === id_mesa ) {
            indice = i;            
            clearInterval(item.interval);           
        }
    });
    return indice;
}


function cambiarEstado2(codigo_pedido,id_mesa){
    var actividad = id_mesa;
    var kpi = $("#cron02-"+actividad).get(0).textContent;

    var funcion = function (resultado) {        
        if (resultado.estado === 200) {
            if (resultado.datos.rpt === true) {                 
                Validar.alert("warning",resultado.datos.msj,2000);
            }else{
                Validar.alert("warning",resultado.datos.msj.errorInfo[2],2000);                
            }            
        }
    }

    new Ajxur.Api({
        modelo: "Pedido",
        metodo: "cambiarEstadoPreparado",
        data_in : {
            p_id : codigo_pedido
        },
        data_out : [kpi]
    }, funcion);
}

function cerrarSesion(){
    $("#confirmar_sesion").modal("show");
}

function FinSesion(){
    document.location.href = "cerrar_sesion.php";
}

function anularToo(id_mesa){
    var actividad = id_mesa;

    var funcion = function (resultado) {        
        if (resultado.estado === 200) {
            if (resultado.datos.rpt === true) {                 
                console.log(resultado.datos.msj);
            }else{
                Validar.alert("warning",resultado.datos.msj.errorInfo[2],2000);                
            }            
        }
    }

    new Ajxur.Api({
        modelo: "Pedido",
        metodo: "anularTotalPedido",
        data_in : {
            p_id_mesa : id_mesa
        }
    }, funcion);
}
