<?php require_once '../build/code/validar.vista.php'; ?>
<html lang="en">
<head>
    <?php require_once '../build/code/metas.vista.php'; ?>
    <title>MESERO</title>
    <?php require_once '../build/code/estilos.vista.php'; ?>    
  </head>
  <body>
    <div class="cuerpo row">
            <div class="col-10">
                <div class="card text-center fondo" style="height:100%;" id="blkSinAcciones"> 
                    <div class="card-header"  style="height: 100%;display: flex; justify-content: center; align-items: center;">
                        <img src="../../imagenes/logo.png" width="380">
                    </div>
                </div>

                <div class="card" style="height:100%;" id="blkPedido"> 
                    <div class="card-header">
                        <div class="row">
                            <div class="col-md-8">
                                <h5 id="titulo-pedido"></h5>
                            </div>
                            <div class="col-md-2">
                                <input class="form-control form-control-sm" id="total_pedido_mesa" disabled value="S/. 0.00" style="text-align-last:center;">
                            </div>
                            <div class="col-md-1">                              
                                <button type="button" class="btn btn-success btn-block" onclick="guardarMesa()"><i class="fas fa-save"></i></button>                                                             
                            </div>

                            <div class="col-md-1">                              
                                <button type="button" class="btn btn-danger btn-block" onclick="CerrarMesa()"><i class="fas fa-times"></i></button>                                                             
                            </div>
                        </div> 
                    </div>
                    <div class="card-body" style="height: 250px;overflow-x:hidden;overflow-y:scroll;white-space:nowrap">
                        <ul class="nav nav-tabs" id="myTab" role="tablist">
                            <li class="nav-item">
                                <a class="nav-link active" id="home-tab" data-toggle="tab" href="#home" role="tab" aria-controls="home" aria-selected="true">COCINA</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" id="profile-tab" data-toggle="tab" href="#profile" role="tab" aria-controls="profile" aria-selected="false">BAR</a>
                            </li>
                        </ul>
                        <div class="tab-content" id="myTabContent" style="margin: 15 0 15 0;">   
                            <div class="tab-pane fade show active" id="home" role="tabpanel" aria-labelledby="profile-tab">
                                <div class="row" id="listado_cocina"></div>
                            </div>

                            <div class="tab-pane fade" id="profile" role="tabpanel" aria-labelledby="home-tab">
                                <div class="row" id="listado_bar"></div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="card" style="height:100%;" id="blkObservaciones">
                    <input type="hidden" id="codigo_producto" placeholder="Código de producto">
                    <input type="hidden" id="nodo" placeholder="SOY PLATO">
                    <div class="card-header">
                        <div class="form-inline">
                            <i class="fas fa-arrow-left" onclick="regresarPedido()" style="cursor:pointer;"></i>&nbsp;&nbsp;   
                            <h5 id="titulo_producto" style="margin-top:5px;"></h5>
                        </div>
                    </div>
                    <div class="card-body" style="margin-top:30px;">                       
                        <div class="row justify-content-md-center">
                            <div class="col-md-4">
                                <div class="card">
                                    <img id="foto_producto" height="200">                                
                                </div>
                            </div>
                            <div class="col-md-5" id="utensilios"></div>
                            <div class="col-md-9" style="margin-top: 15px;">
                                <div class="form-group">
                                    <label for="comment"><strong>Observaciones</strong></label>
                                    <textarea class="form-control" rows="6" id="observaciones"></textarea>
                                </div>                            
                            </div>
                            <div class="col-md-9">
                                <div class="row justify-content-end">
                                    <div class="col-md-3">
                                        <button type="button" class="btn btn-success btn-block" onclick="guardarObservacion()"><i class="fas fa-save"></i> Guardar</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                    </div>
                </div>

                <div class="card" style="height:100%;" id="blkEnEspera">
                    <div class="card-header">
                        <div class="row">
                            <div class="col-md-8">
                                <h5 class="titulo"></h5> 
                            </div>
                            <div class="col-md-4">
                                <h4 id="importe_espera" style="text-align-last:right; color:red"></h4>
                            </div>
                        </div>
                    </div>
                    <div class="card-body" style="height: 250px;overflow-x:hidden;overflow-y:scroll;white-space:nowrap">                        
                        <div class="col-md-12">
                            <table class="table table-stripe">
                                <thead>
                                    <tr>
                                        <th class="text-center">Producto</th>
                                        <th class="text-center">Cantidad</th>
                                        <th class="text-center">Precio</th>
                                        <th class="text-center">Importe</th>
                                        <th class="text-center">OPC</th>
                                    </tr>
                                </thead>
                                <tbody id="listado_pedido_espera"></tbody>
                            </table>                            
                        </div>
                                               
                    </div>
                    <div class="card-footer">
                        <div class="col-md-12">
                            <div class="row justify-content-md-center">
                                <div class="col-md-3">
                                    <button type="button" class="btn btn-success btn-block" onclick="abrirMasPedido()"><i class="fas fa-plus"></i> Pedidos</button>
                                </div>
                                <div class="col-md-3">
                                    <button type="button" class="btn btn-danger btn-block" onclick="cerrarPedidoEspera()"><i class="fas fa-save"></i> Salir</button>
                                </div>
                            </div>
                        </div> 
                    </div>
                </div>

                <div class="card" style="height:100%;" id="blkEntregar">
                    <div class="card-header">
                        <div class="row">
                            <div class="col-md-8">
                                <h5 class="titulo"></h5> 
                            </div>
                            <div class="col-md-4">
                                <h4 id="importe_entrega" style="text-align-last:right; color:red"></h4>
                            </div>
                        </div>
                    </div>
                    <div class="card-body" style="height: 250px;overflow-x:hidden;overflow-y:scroll;white-space:nowrap">                        
                        <div class="col-md-12">
                            <table class="table table-stripe">
                                <thead>
                                    <tr>
                                        <th class="text-center">Producto</th>
                                        <th class="text-center">Cantidad</th>
                                        <th class="text-center">Precio</th>
                                        <th class="text-center">Importe</th>
                                        <th class="text-center">OPC</th>
                                    </tr>
                                </thead>
                                <tbody id="listado_pedido_entrega"></tbody>
                            </table>                            
                        </div>
                                               
                    </div>
                    <div class="card-footer">
                        <div class="col-md-12">
                            <div class="row justify-content-md-center">
                                <div class="col-md-3">
                                    <button type="button" class="btn btn-success btn-block" onclick="abrirMasPedido()"><i class="fas fa-plus"></i> Pedidos</button>
                                </div>
                                <div class="col-md-3">
                                    <button type="button" class="btn btn-primary btn-block" onclick="confirmar('¿Desea entregar todo este pedido?','entregar')"><i class="fas fa-file-import"></i> Entregar</button>
                                </div>
                                <div class="col-md-3">
                                    <button type="button" class="btn btn-danger btn-block" onclick="cerrarPedidoEspera()"><i class="fas fa-save"></i> Salir</button>
                                </div>
                            </div>
                        </div> 
                    </div>
                </div>

                <div class="card" style="height:100%;" id="blkPuntos">
                    <div class="card-header">
                        <div class="row">
                            <div class="col-md-11">
                                <h5 class="titulo">Consultar Puntos</h5> 
                            </div>
                            <div class="col-md-1">
                                <button type="button" class="btn btn-danger btn-block" onclick="cerrarPedidoEspera()"><i class="fas fa-times"></i></button>                                                             
                            </div>
                        </div>
                    </div>
                    <div class="card-body"> 
                        <div class="row">                       
                            <div class="col-md-10">
                                <div class="form-group">
                                    <label for="texto_documento">Consultar DNI/RUC</label>
                                    <input type="email" class="form-control form-control-sm" id="texto_documento" placeholder="Buscar" maxlength="11">
                                </div>                          
                            </div>
                            <div class="col-md-1">
                                <button type="button" class="btn btn-primary btn-block" onclick="buscar_consulta()" style="margin-top:32px;"><i class="fas fa-search"></i></button>                                                             
                            </div>                             
                            <div class="col-md-1">
                                <button type="button" class="btn btn-secondary btn-block" onclick="limpiar_consulta()" style="margin-top:32px;"><i class="fas fa-broom"></i></button>                                                             
                            </div> 
                            <div class="col-md-6">
                                <div class="col-md-12">
                                    <table class="table">
                                        <thead>
                                            <tr>
                                                <th class="text-center" colspan="3">Listado de puntos</th>
                                            </tr>
                                            <tr>
                                                <th class="text-center">Item</th>
                                                <th class="text-center">Producto</th>
                                                <th class="text-center">Puntos</th>
                                            </tr>
                                        </thead>
                                        <tbody id="listado_promociones">
                                        </tbody>
                                    </table>
                                </div>                        
                            </div> 
                            <div class="col-md-6">
                                <div class="col-md-12">
                                    <table class="table">
                                        <thead>
                                            <tr>
                                                <th class="text-center" colspan="3">Consultar puntos</th>
                                            </tr>
                                            <tr>
                                                <th class="text-center">DNI</th>
                                                <th class="text-center">Razón social</th>
                                                <th class="text-center">Puntos</th>
                                            </tr>
                                        </thead>
                                        <tbody id="listado_consulta">
                                            <tr>
                                                <td class="text-center" colspan="3">SIN RESULTADOS</td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>                        
                            </div>
                            
                        </div>
                                               
                    </div>
                </div>

                <!-- MODAL SUB PRODUCTO -->
                <div id="modal-sub-producto"></div>
                <!-- MODAL SUB PRODUCTO -->

                <!-- MODAL OBSERVACIONES SUB PRODUCTO -->
                <div class="modal fade"  role="dialog" data-backdrop="static" data-keyboard="false" id="modal-observaciones-sub-producto">
                    <div class="modal-dialog modal-lg modal-dialog-centered">                        
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title"></h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body">
                                <input type="hidden" id="codigo_producto_sub" placeholder="Código de producto">                
                                <input type="hidden" id="posicion_sub" placeholder="POSICION">
                                <div class="row justify-content-md-center">
                                    <div class="col-md-4">
                                        <div class="card">
                                            <img id="foto_producto_sub" height="200">                                
                                        </div>
                                    </div>
                                    <div class="col-md-5" id="utensilios_sub"></div>
                                    <div class="col-md-9" style="margin-top: 15px;">
                                        <div class="form-group">
                                            <label for="comment"><strong>Observaciones</strong></label>
                                            <textarea class="form-control" rows="6" id="observaciones_sub"></textarea>
                                        </div>                            
                                    </div>
                                    <div class="col-md-9">
                                        <div class="row justify-content-end">
                                            <div class="col-md-3">
                                                <button type="button" class="btn btn-success btn-block" onclick="guardarObservacionSub()"><i class="fas fa-save"></i> Guardar</button>
                                            </div>
                                        </div>
                                    </div>
                                </div> 
                            </div>
                        </div>
                    </div>
                </div>
                <!-- MODAL OBSERVACIONES SUB PRODUCTO -->

                <!-- MODAL DESCRIPCION PRODUCTO -->
                <div class="modal fade"  role="dialog" data-backdrop="static" data-keyboard="false" id="modal-producto">
                    <div class="modal-dialog modal-lg modal-dialog-centered">                        
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title"></h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body">
                                <div class="row">
                                    <div class="col-md-7">
                                        <div id="modal-producto-descripcion"></div>
                                    </div>
                                    <div class="col-md-5">
                                        <img id="modal-producto-foto" class="img-responsive">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- MODAL DESCRIPCION PRODUCTO -->

                <!-- MODAL EDITAR PEDIDO -->
                <div class="modal fade"  role="dialog" data-backdrop="static" data-keyboard="false" id="modal-editar-pedido">
                    <div class="modal-dialog modal-lg modal-dialog-centered">                        
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title"></h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body">
                                <input type="hidden" id="codigo_pedido" class="form-control">
                                <div class="row">
                                    <div class="col-md-4">
                                        <div class="form-group">
                                            <label for="cantidad_pedido"><strong>Cantidad</strong></label>
                                            <select class="form-control" id="cantidad_pedido" style="text-align-last:center;"></select>
                                        </div>                                        
                                    </div>
                                    <div class="col-md-4">
                                         <div class="form-group">
                                             <label for="precio_pedido"><strong>Precio</strong></label>
                                             <input class="form-control" id="precio_pedido" disabled style="text-align-last:center;">                                        
                                         </div>
                                     </div>
                                     <div class="col-md-4">
                                         <div class="form-group">
                                             <label for="importe_pedido"><strong>Importe</strong></label>
                                             <input class="form-control" id="importe_pedido" disabled style="text-align-last:center;">                                        
                                         </div>
                                     </div>
                                     <div class="col-md-12">
                                         <div class="form-group">
                                             <label for="observaciones_pedido"><strong>Observación</strong></label>
                                             <textarea class="form-control" rows="6" id="observaciones_pedido"></textarea>                                                                                   
                                         </div>
                                     </div>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-success" onclick="confirmar('¿Desea editar este pedido?','editar')"><i class="fas fa-save"></i> Guarda</button>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- MODAL EDITAR PEDIDO -->

                <!-- MODAL LIBERAR MESA -->
                <div class="modal fade"  role="dialog" data-backdrop="static" data-keyboard="false" id="liberar_mesa">
                    <div class="modal-dialog modal-lg modal-dialog-centered">                        
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title">LIBERAR MESA</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body" style="height:100px;">                                
                                <div class="row justify-content-md-center">
                                    <div class="col-md-6">
                                        <select class="form-control" id="mesas_liberar" style="text-align-last:center;"></select>
                                                                              
                                    </div>
                                    <div class="col-md-3">
                                        <button type="button" class="btn btn-success btn-block btn-xs" onclick="liberar_mesa()"><i class="fas fa-save"></i> Guarda</button>
                                     </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- MODAL LIBERAR MESA -->     



                <!-- MODAL DE CONFIRMACION -->
                <div class="modal fade"  role="dialog" data-backdrop="static" data-keyboard="false" id="modal_confirmacion">                    
                    <div class="modal-dialog modal-dialog-centered">                        
                        <div class="modal-content">
                            <div class="modal-header">
                                <input type="hidden" class="form-control" id="operacion">
                                <h5 class="modal-title"></h5>
                            </div>
                            <div class="modal-body">                          
                                <div class="row" id="blkNombreCliente">
                                    <div class="col-12">
                                        <div class="form-group">
                                            <label for="nombre_cliente">Ingrese el nombre del cliente</label>
                                            <input type="text" class="form-control" id="nombre_cliente" placeholder="Ingrese el nombre del cliente">
                                        </div>
                                    </div>
                                </div>
                                <div class="row justify-content-center">
                                    <div class="col-3">
                                        <button type="button" class="btn btn-success btn-block" onclick="confirmar_accion()">Si</button>
                                    </div>
                                    <div class="col-3">
                                         <button type="button" class="btn btn-danger btn-block" class="close" data-dismiss="modal" aria-label="Close">No</button>
                                    </div>
                                </div>                         
                            </div>
                        </div>
                    </div>
                </div>
                <!-- MODAL DE CONFIRMACION -->
            </div>
            <!-- LISTADO DE MESA -->
            <div class="col-2">
                <div class="card text-center" style="height:100%;">
                    <div class="card-body  iscroll-mesas">
                        <button type="button" class="btn btn-link btn-block" onclick="abrirPuntos()" style="text-decoration:none;background:midnightblue;color:white;">Puntos</button>                        
                        <hr>
                        <div id="listado-mesas"></div>
                        <hr>
                        <button type="button" class="btn btn-primary btn-block" onclick="confirmar('¿Desea cerrar sesion?','sesion_cerrar')"><i class="fas fa-power-off"></i></button>                       
                        <hr>
                        <button type="button" class="btn btn-link btn-block" style="text-decoration:none;background:#881420;color:white;" data-toggle="modal" data-target="#liberar_mesa">LIBERAR MESA</button>
                        
                        <input type="hidden" class="form-control" id="codigo_mesa" placeholder="ID MESA"> 
                        <input type="hidden" class="form-control" id="mesa" placeholder="LA MESA"> 
                        <input type="hidden" class="form-control" id="estado_convencional" placeholder="EC"> 
                    </div>
                </div>
            </div>
        
    </div>


                           
    <?php require_once '../build/code/scripts.vista.php'; ?>



</body>
</html>