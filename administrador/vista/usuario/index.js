var DOM = {};
$(document).ready(function () {
    setDOM();
    setEventos();
    listar();
});
function setDOM() {
}

function setEventos() {	

    $("#btnGuardarClave").click(function(){
        var funcion = function (resultado) {
            if (resultado.estado === 200) {
                if (resultado.datos.rpt === true) {
                    $("#myModal").modal("hide");
                    $("#strClave").val();
                    $("#clave").find(".form-line").removeClass('focused');
                    listar();
                    Validar.alert("warning",resultado.datos.msj,2000);
                }else{
                    Validar.alert("warning",resultado.datos.msj.errorInfo[2],2000);
                }    
            } 
        };
        new Ajxur.Api({
            modelo: "Empleado",
            metodo: "generaClave",
            data_in : {
                p_id : $("#txtcodigo_empleado").val()
            },
            data_out : [$("#strClave").val()]
        }, funcion);  
    });
}

function listar(){
    var funcion = function (resultado) {
        if (resultado.estado === 200) {
            if (resultado.datos.rpt === true) {
                var html = "";
                html += '<table id="tabla-listado-empleados" class="table table-bordered table-striped display nowrap" cellspacing="0" width="100%">';                
                html += '<thead>';
                html += '<tr>';
                html += '<th style="text-align: center">DNI</th>';
                html += '<th style="text-align: center">Nombres y Apellidos</th>';
                html += '<th style="text-align: center">Cargo</th>';
                html += '<th style="text-align: center">Clave</th>';
                html += '<th style="text-align: center">OPCIONES</th>';
                html += '</tr>';
                html += '</thead>';
                html += '<tbody>';                
                $.each(resultado.datos.msj, function (i, item) {                 
                    html += '<tr>';                    
                    html += '<td align="center">' + item.dni + '</td>';
                    html += '<td align="center">' + item.nombres_apellidos + '</td>';
                    html += '<td align="center">' + item.cargo + '</td>';
                    html += '<td align="center">' + item.clave + '</td>';

                    html += '<td align="center">';

                    var tmpEstado = item.estado_usuario != "1" ?
                        {icon: "up", title: "Habilitar", bol: 1, boton: "btn-warning"} :
                        {icon: "down", title: "Deshabilitar", bol: 0, boton: "btn-danger"};

                    html += '<button type="button" class="btn btn-xs '+tmpEstado.boton+' waves-effect" title="'+tmpEstado.title+' usuario" onclick="darBaja('+item.id+","+tmpEstado.bol+')"><i class="material-icons">thumb_'+tmpEstado.icon+'</i></button>';
                    html += '&nbsp;&nbsp;';

                    html += '<button type="button" class="btn btn-xs btn-info waves-effect" title="Ingresar clave de usuario" data-toggle="modal" data-target="#myModal" onclick="abrirModal('+item.id+')"><i class="material-icons">lock</i></button>';
                    html += '&nbsp;&nbsp;';

                    html += '</td>';
                    html += '</tr>';
                });
                html += '</tbody>';
                html += '<tfoot>';            
                html += '</tfoot>';
                html += '</table>';
                $("#listado").html(html);
                $("#tabla-listado-empleados").dataTable({
                    "responsive": true
                });
            }else{
                Validar.alert("warning",resultado.datos.msj.errorInfo[2],2000);
            }    
        } 
    };
    new Ajxur.Api({
        modelo: "Empleado",
        metodo: "listarUsuario"
    }, funcion);
}

function abrirModal(codigo_empleado){
    $("#txtcodigo_empleado").val(codigo_empleado);
    $("#strClave").val("");

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
        modelo: "Empleado",
        metodo: "cambiarUsuario",
        data_in: {
            p_id : codigo_categoria,
            p_estado : estado
        }
    }, funcion);
}