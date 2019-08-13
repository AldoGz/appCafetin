 var DOM = {};

  $(document).ready(function () {
      setDOM();
      setEventos();
  });

  function setDOM() {
    DOM.form = $(".form-signin"),
    DOM.usuario = $("#txtusuario"),
    DOM.clave = $("#txtclave");
}

function limpiar() {
    DOM.usuario.val("");
    DOM.clave.val("");
}

function setEventos() { 
    DOM.form.submit(function (e) {
      e.preventDefault();
      if ( DOM.usuario.val() === "" ) {
        alert("Debe ingresar el usuario");
        return 0;
      }

      if ( DOM.clave.val() === "" ) {
        alert("Debe ingresar la clave de usuario");
        return 0;
      }
      var funcion = function (resultado) {
          if ( resultado.estado === 200 ) {
              if (resultado.datos.rpt === true) {                
                  if ( resultado.datos.estado === true ) {
                      switch(resultado.datos.msj.id_tipo_empleado){
                          case "1":
                              document.location.href = "../../administrador/vista/tipo_empleado/";
                              break;
                          case "2":
                              document.location.href = "../../mesero";
                              break;
                          case "3":
                              document.location.href = "../../cajero";
                              break;
                          case "4":
                              document.location.href = "../../server/kitchen/";
                              break;
                          case "5":
                              document.location.href = "../../server/pub/";
                              break;
                      }
                  }else{
                      Validar.alert("warning",resultado.datos.msj,2000);
                      limpiar();
                  }
              }else{
                  Validar.alert("warning",resultado.datos.msj.errorInfo[2],2000);                  
              } 
          }
        };

        new Ajxur.Api({
            modelo: "Sesion",
            metodo: "inicioSesion",                            
            data_in: {            
                p_usuario : DOM.usuario.val(),
                p_clave : DOM.clave.val()
            }
        }, funcion);
      
    });            
}