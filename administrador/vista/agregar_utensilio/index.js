var DOM = {};
$(document).ready(function () {
    setDOM();
    setEventos();
    cargarProducto();
});
function setDOM() {
    DOM.cboProducto = $("#cboProductos");
    DOM.cboUtensilio = $("#cboUtensilio");
}

function setEventos() {
    DOM.cboProducto.change(function(){
        if ( DOM.cboProducto.val() !== "" ) {
            cargarUtensilio();
        }
    });

    DOM.cboUtensilio.multiSelect({
        afterSelect: function(values){                                                
            agregar(values[0]);                        
        },
        afterDeselect: function(values){
            quitar(values[0]);
        }  
    });
}


function cargarUtensilio(){    
    var funcion = function (resultado) {
        if (resultado.estado === 200) {
            if (resultado.datos.rpt === true) { 
                var html = '';                
                $.each(resultado.datos.msj.u, function (i, item) { 
                    var bandera = false;
                    $.each(resultado.datos.msj.up, function(key,value){
                        if ( value.id === item.id ) {
                            bandera = true;
                        }                     
                    });
                    if ( bandera === false ) {
                        html += '<option value="' + item.id + '">'+ item.nombre + '</option>';      
                    }else{
                        html += '<option value="' + item.id + '" selected>'+ item.nombre + '</option>';  
                    }
                });
                DOM.cboUtensilio.html(html).multiSelect('refresh');
            }else{
                Validar.alert("warning",resultado.datos.msj.errorInfo[2],2000);
            }            
        } 
    };

    new Ajxur.Api({
        modelo: "Utensilio",
        metodo: "multiselectUtensilio",
        data_out : [DOM.cboProducto.val()]
    }, funcion);
}

function agregar(id_utensilio){
    var funcion = function (resultado) {
        if (resultado.estado === 200) {
            if (resultado.datos.rpt === true) {
                Validar.alert("warning",resultado.datos.msj,2000);
                cargarUtensilio();
            }else{
                Validar.alert("warning",resultado.datos.msj.errorInfo[2],2000);
            }            
        } 
    };

    new Ajxur.Api({
        modelo: "Utensilio",
        metodo: "agregarUtensilioProducto",
        data_out:[DOM.cboProducto.val(),id_utensilio]
    }, funcion);
}

function quitar(id_utensilio){
    var funcion = function (resultado) {
        if (resultado.estado === 200) {
            if (resultado.datos.rpt === true) {
                Validar.alert("warning",resultado.datos.msj,2000);
            }else{
                Validar.alert("warning",resultado.datos.msj.errorInfo[2],2000);
            }            
        } 
    };

    new Ajxur.Api({
        modelo: "Utensilio",
        metodo: "quitarUtensilioProducto",
        data_out:[DOM.cboProducto.val(),id_utensilio]
    }, funcion);
}

function cargarProducto(){
    var funcion = function (resultado) {
        if (resultado.estado === 200) {
            if (resultado.datos.rpt === true) {
                var html = '<option></option>';               
                $.each(resultado.datos.msj, function (i, item) { 
                    html += '<option value="' + item.id + '">'+ item.nombre + '</option>';
                });
                DOM.cboProducto.html(html).select2({
                    "placeholder":"Seleccionar producto"
                });
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