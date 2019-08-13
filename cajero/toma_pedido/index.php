<?php require_once '../build/code/validar.vista.php'; ?>
<html lang="en">
<head>
    <?php require_once '../build/code/metas.vista.php'; ?>
    <title>CAJERO</title>
    <?php require_once '../build/code/estilos.vista.php'; ?>
</head>
<body>
    <div class="cuerpo row">
        
        <div class="col-md-10">
            <div class="card text-center fondo" style="height: 100%;" id="blkSinAcciones">
                <div class="card-header"  style="height: 100%;display: flex; justify-content: center; align-items: center;">
                    <img src="../../imagenes/logo.png" width="380">
                </div>
            </div>

            <div class="card" style="height: 100%;" id="blkAlertas">
                <div class="card-header">
                    <div class="text-center">
                        <h5>REPORTE DE PEDIDOS</h5>
                    </div> 
                </div>
                <div class="card-body" style="overflow-x: hidden;overflow-y: scroll;white-space: nowrap;">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="form-group">
                                <label for="fecha_fin"><strong>Tipo de reporte: </strong></label>   
                            </div>                               
                        </div>
                        <div class="col-md-12" style="margin-top: -15px;margin-bottom: 15px;">                                
                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="radio" name="intTipo" id="rdfc" value="1" checked>
                                <label class="form-check-label" for="rdfc">Facturacion de pago</label>
                            </div>
                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="radio" name="intTipo" id="rdpv" value="2">
                                <label class="form-check-label" for="rdpv">Productos vendidos</label>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="form-group">
                                <label for="fecha_inicio">Fecha inicio:</label>
                                <input type="date" class="form-control" id="fecha_inicio">
                                
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="form-group">
                                <label for="fecha_fin">Fecha fin:</label>
                                <input type="date" class="form-control" id="fecha_fin">                                        
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="row justify-content-center" style="margin-top: 30px;">
                                <div class="col-6">
                                    <button type="button" class="btn btn-success btn-block" id="FiltrarReporte"><i class="fas fa-filter"></i> Filtrar</button>
                                </div>
                                <div class="col-6">
                                    <button type="button" class="btn btn-danger btn-block" id="CerrarReporte"><i class="fas fa-sign-out-alt"></i> Salir</button>
                                </div>
                            </div>                              
                        </div>
                    </div>
                    <div id="listado-reporte"></div>                   

                </div>
            </div>

            
            
            <!-- PAGADO -->
            <div class="card" style="height: 100%;" id="blkPagarMesa">
                <div class="card-header">
                    <div class="text-center">

                        <h5 id="titulo-panel"></h5>                                                            
                    </div> 
                </div>
                <div class="card-body" style="height: 300px;overflow-x:hidden;overflow-y:scroll;white-space:nowrap">
                    <div class="row">
                        <div class="col-md-4">
                            Tipo de comprobante
                            <select class="form-control" id="tipo_comprobante"></select>
                        </div>
                        <div class="col-md-4">
                            Serie
                            <select class="form-control" id="serie_comprobante">
                            </select>
                        </div>
                        <div class="col-md-4">
                            Correlativo
                            <input class="form-control" id="correlativo">
                        </div>

                        <div class="col-md-3">
                            Documento
                            <input type="text" class="form-control" id="documento">
                        </div>
                        <div class="col-md-6">
                            Nombres y Apellidos / Razón social
                            <input type="text" class="form-control" id="razon_social" disabled>
                        </div>
                        <div class="col-md-3">
                            Usuario
                            <input type="text" class="form-control" id="usuario" disabled>
                        </div>
                        <div class="col-md-12" id="blkDireccion">
                            Dirección
                            <input type="text" class="form-control" id="direccion" disabled>
                        </div>
                        
                        <div class="col-md-4">
                            Monto Total
                            <input type="text" class="form-control" id="monto_pagado" disabled>
                        </div>
                        <div class="col-md-4">
                            Monto descuento
                            <input type="text" class="form-control" id="monto_descuento" disabled>
                        </div>
                        <div class="col-md-4">
                            Monto Amortización
                            <input type="text" class="form-control" id="monto_amortizacion" disabled>
                        </div>

                        <div class="col-md-7" style="margin-top:30px;height: 300px;overflow-x:hidden;overflow-y:scroll;white-space:nowrap">
                            <div class="row">
                                <div class="col-md-7">
                                    Ticket
                                    <input type="text" class="form-control" id="text_ticket">
                                </div>
                                <div class="col-md-3">
                                    Descuento
                                    <input type="text" class="form-control" id="text_descuento" disabled>
                                </div>

                                <div class="col-md-2">
                                    <br>
                                    <button id="btnDescuento" type="button" class="btn btn-secondary btn-lg btn-block" onclick="agregarDescuento()"><i class="fas fa-file-import"></i></button>
                                </div>
                            </div>
                            <div class="row" style="margin-top:15px;">
                                <div class="col-md-12">
                                    <table class="table table-bordered">
                                        <thead>
                                            <tr>
                                                <th class="text-center" scope="col"></th>
                                                <th class="text-center" scope="col">PEDIDO</th>
                                                <th class="text-center" scope="col">CANTIDAD</th>
                                                <th class="text-center" scope="col">PRECIO</th>                                            
                                                <th class="text-center" scope="col">IMPORTE</th>
                                            </tr>
                                        </thead>
                                        <tbody id="listado-pedidos-por-pagar"></tbody>
                                    </table>
                                </div>
                            </div>
                        </div>

                        <div class="col-md-5" style="margin-top:30px;height: 300px;overflow-x:hidden;overflow-y:scroll;white-space:nowrap">
                            <input id="cantidad_puntos" type="hidden">
                            <div class="row">
                                <div class="col-md-12">
                                    <table class="table table-bordered">
                                        <thead>
                                            <tr>
                                                <th class="text-center" scope="col">DNI/RUC</th>
                                                <th class="text-center" scope="col">Razón social</th>
                                                <th class="text-center" scope="col">Puntos</th>
                                            </tr>
                                        </thead>
                                        <tbody id="listado-pedidos-puntos">
                                            <tr>
                                                <td colspan="3" class="text-center">Sin resultados</td>
                                            </tr>
                                        </tbody>
                                    </table>                                        
                                </div>
                                <div class="col-md-12">
                                    <table class="table table-bordered">
                                        <thead>
                                            <tr>
                                                <th class="text-center" scope="col">Item</th>
                                                <th class="text-center" scope="col">Producto</th>
                                                <th class="text-center" scope="col">Puntos</th>
                                            </tr>
                                        </thead>
                                        <tbody id="listado-pedidos-puntos-promocion"></tbody>
                                    </table>                                        
                                </div> 
                            </div>
                        </div>


                    </div>
                        

                </div>
                <div class="card-footer">
                    <div class="row justify-content-center">
                        <div class="col-3">
                            <button type="button" class="btn btn-secondary btn-block" id="PagarPedido"><i class="fas fa-cash-register"></i> Pagar</button>
                        </div>
                        <div class="col-3">
                            <button type="button" class="btn btn-danger btn-block" id="CerrarPago"><i class="fas fa-sign-out-alt"></i> Salir</button>
                        </div>                                
                    </div>
                </div>
            </div>
        </div>
        <!-- LISTADO DE MESA -->
        <div class="col-md-2">
            <div class="card text-center" style="height: 100%;">
                <div class="card-body  iscroll-mesas"> 
                    <input type="hidden" class="form-control" id="codigo_mesa" placeholder="ID MESA"> 
                    <button type="button" class="btn btn-warning btn-block" onclick="abrirReporte()">REPORTE</button>   
                    <hr>                                           
                    <div id="listado-mesas"></div>
                    <hr>
                    <button type="button" class="btn btn-primary btn-block" onclick="cerrarSesion()"><i class="fas fa-power-off"></i></button>
                    
                    
                </div>
            </div>
        </div>

        <div class="modal fade"  role="dialog" data-backdrop="static" data-keyboard="false" id="confirmar_sesion">
            <div class="modal-dialog modal-dialog-centered">                        
                <div class="modal-content">
                    <div class="modal-header">
                        ¿Desea cerrar la sesión del cajero?
                    </div>
                    <div class="modal-body">                            
                        <div class="row justify-content-center">
                            <div class="col-3">
                                <button type="button" class="btn btn-success btn-block" onclick="FinSesion()">Si</button>
                            </div>
                            <div class="col-3">
                                 <button type="button" class="btn btn-danger btn-block" class="close" data-dismiss="modal" aria-label="Close">No</button>
                            </div>
                        </div>
                        
                        
                    </div>
                </div>
            </div>
        </div>

        <div class="modal fade"  role="dialog" data-backdrop="static" data-keyboard="false" id="ver">
            <div class="modal-dialog modal-lg modal-dialog-centered">                        
                <div class="modal-content">
                    <div class="modal-header">
                        <h5>Ver detalle de pedido</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="col-md-12" style="margin:10px;color:red;">
                            <div id="texto-usuario"></div>
                        </div>
                        <div class="col-md-12" style="margin-top:10px;">
                            <table class="table table-bordered">
                                <thead>
                                    <tr>
                                        <th class="text-center" scope="col">PEDIDO</th>
                                        <th class="text-center" scope="col">PRECIO</th>
                                        <th class="text-center" scope="col">CANTIDAD</th>
                                        <th class="text-center" scope="col">IMPORTE</th>
                                    </tr>
                                </thead>
                                <tbody id="listado-ver"></tbody>
                            </table>
                        </div>                           
                    </div>
                </div>
            </div>
        </div>

        <div class="modal fade"  role="dialog" data-backdrop="static" data-keyboard="false" id="confirmar_pago">
            <div class="modal-dialog modal-dialog-centered">                        
                <div class="modal-content">
                    <div class="modal-header">
                        ¿Desea guardar este facturacion de esta mesa?
                    </div>
                    <div class="modal-body">
                        <div class="row justify-content-center">
                            <div class="col-3">
                                <button type="button" class="btn btn-success btn-block" onclick="GuardarFacturacion()">Si</button>
                            </div>
                            <div class="col-3">
                                 <button type="button" class="btn btn-danger btn-block" class="close" data-dismiss="modal" aria-label="Close">No</button>
                            </div>
                        </div>                            
                    </div>
                </div>
            </div>
        </div>

        <!-- Modal -->
        <div class="modal fade" id="cargando" role="dialog" data-backdrop="static" data-keyboard="false">
            <div class="modal-dialog modal-dialog-centered" style="display:flex;justify-content:center;align-items:center;">
                <img src="../../servidor/img/loader.gif" width="100" height="100" style="color:#FFF">
                <label style="color:#FFF">Procesando, espere por favor</label>
            </div>
        </div>
        <!-- Modal -->



        
    </div>
    <?php require_once '../build/code/scripts.vista.php'; ?>
</body>
</html>