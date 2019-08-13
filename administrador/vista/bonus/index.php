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
    <title>Promoción bonus</title>
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
            <div class="row clearfix">
                <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                    <div class="card">
                        <div class="header">
                            <div class="row clearfix">
                                <div class="col-xs-12 col-sm-8">
                                    <h2>Formulario de promoción bonus</h2>
                                </div>
                                <div class="col-xs-12 col-sm-2 align-right">
                                    <select class="form-control show-tick" id="cboEstado">           
                                        <option value="1">ACTIVOS</option>
                                        <option value="0">INACTIVOS</option>
                                    </select>
                                </div>
                                <div class="col-xs-12 col-sm-2 align-right">
                                    <button id="btnAgregar" type="button" class="btn bg-cyan btn-block btn-sm waves-effect" data-toggle="modal" href="#myModal" title="Nuevo categoria">NUEVO</button>
                                </div>
                            </div>
                        </div>
                        <div class="body">
                            <div class="row">
                                <div class="col-sm-12">
                                    <div id="listado"></div>
                                    <!-- Modal -->
                                    <div class="modal fade" id="myModal" role="dialog" style="display: none;">
                                        <div class="modal-dialog modal-lg" role="document">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <h4 class="modal-title"></h4>
                                                </div>
                                                <form name="frm-grabar" id="frm-grabar"  role="form">
                                                    <div class="modal-body">
                                                        <input type="hidden" id="intCodigoCategoria" name="intCodigoCategoria" class="form-control">
                                                        <input type="hidden" id="operacion" name="operacion" class="form-control">


                                                        <div class="row clearfix">
                                                            <div class="col-sm-12">
                                                                <div class="row clearfix">
                                                                    <div class="col-sm-6" id="XTicket">
                                                                        <br>
                                                                        <div class="form-group form-float">
                                                                            <div class="form-line">
                                                                                <input type="text" id="strTicket" name="strTicket" class="form-control">
                                                                                <label class="form-label">Ticket</label>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="col-sm-6" id="XDescripcion">
                                                                        <br>
                                                                        <div class="form-group form-float">
                                                                            <div class="form-line">

                                                                                <input type="text" id="strDescripcion" name="strDescripcion" class="form-control">
                                                                                <label class="form-label">Descripción</label>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="col-sm-4">
                                                                        <div class="form-group">
                                                                            <label class="form-label">Fecha inicio</label>
                                                                            <input type="date" id="strFechaInicio" name="strFechaInicio" class="form-control">
                                                                        </div>
                                                                    </div>
                                                                    <div class="col-sm-4">
                                                                        <div class="form-group">
                                                                            <label class="form-label">Fecha fin</label>
                                                                            <input type="date" id="strFechaFin" name="strFechaFin" class="form-control">
                                                                        </div>
                                                                    </div>
                                                                    <div class="col-sm-4" id="XPorcentaje">
                                                                        <br>
                                                                        <div class="form-group form-float">
                                                                            <div class="form-line">

                                                                                <input type="text" id="strPorcentaje" name="strPorcentaje" class="form-control">
                                                                                <label class="form-label">Porcentaje</label>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>                                                          .
                                                    </div>
                                                    <div class="modal-footer">
                                                        <button type="submit" id="boton" class="btn btn-link waves-effect">Guardar</button>
                                                        <button type="button" class="btn btn-link waves-effect" data-dismiss="modal">Cerrar</button>
                                                    </div>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- #Modal -->
                                </div>
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

