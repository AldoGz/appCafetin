<?php
    $rutaTemplate = "../build/";
    require_once $rutaTemplate.'validar.php';
    //include $rutaTemplate.'AccesoAuxiliar.clase.php';
    //$objAcceso = new AccesoAuxiliar();
?>
<!DOCTYPE html>
<html>
<head>
    <?php require_once $rutaTemplate.'meta.vista.php'; ?>
    <title>Reporte</title>
    <?php require_once $rutaTemplate.'estilo.vista.php'; ?>
</head>

<body class="theme-cyan">
    <?php require_once $rutaTemplate.'loader.vista.php'; ?> 
    <?php require_once $rutaTemplate.'cabecera.vista.php'; ?>           
    <section>        
        <aside id="leftsidebar" class="sidebar">
            <?php require_once $rutaTemplate.'user-info.vista.php'; ?> 
            <?php require_once $rutaTemplate.'menu.vista.php'; ?> 
            <?php require_once $rutaTemplate.'pie-pagina.vista.php'; ?> 
        </aside>
    </section>
    <section class="content">
        <div class="container-fluid">
            <!-- CONTENIDO DE PAGINA WEB -->
            <div class="row">                
                <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                    <div class="card" style="height: 95%;" id="blkAlertas">
                        <div class="header">
                            <div class="text-center">
                                <h2>REPORTE DE PEDIDOS</h2>
                            </div>                            
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
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <label for="fecha_inicio">Fecha inicio:</label>
                                        <input type="date" class="form-control" id="fecha_inicio" style="border:solid; border-width:1px;border-radius:10px;border-color:#009688;">
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <label for="fecha_fin">Fecha fin:</label>
                                        <input type="date" class="form-control" id="fecha_fin" style="border:solid; border-width:1px;border-radius:10px;border-color:#009688;">
                                    </div>
                                </div>
                                <div class="col-md-2">
                                    <div class="form-group">
                                        <label for="fecha_fin">Seleccione un Turno:</label>
                                        <select class="form-control" id="cboTurno" style="text-align-last:center;"></select>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="row justify-content-center" style="margin-top: 10px;">

                                            <button id="FiltrarReporte"type="button" class="btn bg-cyan  btn-sm waves-effect" title="Filtrar Reporte" onclick="filtrarReporte()"><i class="material-icons">youtube_searched_for</i>&nbsp;&nbsp;&nbsp;&nbsp;Filtrar&nbsp;&nbsp;&nbsp;&nbsp;</button>

                                    </div>                              
                                </div>                                                                                     
                            </div>
                        <div class="body">
                            <div class="row">
                                <div class="col-sm-12">
                                <div id="listado-reporte"></div>                   
                                    <button class="btn btn-lg bg-cyan btn-sm" onclick="tableToExcel('tb_export')">Exportar Tabla a Excel </button>
                                    
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
                <div class="modal fade"  role="dialog" data-backdrop="static" data-keyboard="false" id="ver">
                    <div class="modal-dialog modal-lg modal-dialog-centered">                        
                        <div class="modal-content" style="height: 95%;overflow-x:hidden;overflow-y:scroll;white-space:nowrap">
                            <div class="modal-header">                                
                                <div class="col-md-11">
                                        <h5>Ver detalle de pedido</h5>
                                </div>                             
                                <div class="col-md-1">                              
                                        <button type="button" class="btn btn-lg btn-danger btn-block" data-dismiss="modal" aria-label="Close"><i class="fas fa-times"></i></button>                         
                                
                                </div>                            
                            </div>
                            <div class="modal-body">
                                <div class="col-md-12" style="margin:10px;color:red;">
                                    <div id="texto-usuario"></div>
                                    <div id="mesa-usuario"></div>
                                </div>
                                <div class="col-md-12" style="margin-top:10px;">
                                    <table class="table table-bordered">
                                <thead>
                                    <tr>
                                        <th class="text-center" scope="col">PEDIDO</th>
                                        <th class="text-center" scope="col">PRECIO</th>
                                        <th class="text-center" scope="col">CANTIDAD</th>                                        
                                        <th class="text-center" scope="col">SUBTOTAL</th>
                                        <th class="text-center" scope="col">DESCUENTO</th>
                                        <th class="text-center" scope="col">TOTAL</th>
                                        <!-- <th class="text-center" scope="col">NOTA</th> -->
                                    </tr>
                                </thead>
                                <tbody id="listado-ver"></tbody>
                            </table>
                                </div>                           
                            </div>
                        </div>
                    </div>
                </div>
            <!-- #CONTENIDO DE PAGINA WEB -->             
        </div>        
    </section>
    <?php require_once $rutaTemplate.'script.vista.php'; ?>
</body>
</html>

