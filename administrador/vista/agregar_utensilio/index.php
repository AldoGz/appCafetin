<?php
    $rutaTemplate = "../build/";
    require_once $rutaTemplate.'validar.php';
?>
<!DOCTYPE html>
<html>
<head>
    <?php require_once $rutaTemplate.'meta.vista.php'; ?>
    <title>Agregados para producto</title>
    <?php require_once $rutaTemplate.'estilo2.vista.php'; ?>
    <link href="../../plugins/multi-select/css/multi-select.css" rel="stylesheet"> 
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
                                    <h2>Formulario de agregado para los productos</h2>
                                </div>
                            </div>
                        </div>
                        <div class="body">
                            <div class="row">
                                <div class="col-sm-12">
                                    <select class="form-control show-tick" id="cboProductos"></select>
                                </div>
                                <div class="col-sm-12" id="blkMultiple">
                                    <select id="cboUtensilio" multiple="multiple"></select>
                                </div>
                            </div>

                            
                        </div>
                    </div>
                </div>
                <div class="modal fade"  role="dialog" data-backdrop="static" data-keyboard="false" id="myModal">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                <h4 class="modal-title">Generar clave para el empleado</h4>
                            </div>                            
                            <div class="modal-body">
                                        <input type="hidden" id="txtcodigo_empleado" class="form-control input-sm" readonly=""/> 

                                <div class="row clearfix">
                                    <div class="col-sm-12" id="clave">                                       
                                        <div class="form-group form-float">
                                            <div class="form-line">
                                                <input type="text" id="strClave" class="form-control">
                                                <label class="form-label">Clave para el empleado</label>
                                            </div>
                                        </div>                                                                    
                                    </div>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button class="btn btn-success" type="button" id="btnGuardarClave">Grabar</button>
                            </div>
                            
                        </div>
                    </div>
                </div>


            </div>
            <!-- #CONTENIDO DE PAGINA WEB --> 
        </div>
    </section>
    <?php require_once $rutaTemplate.'script2.vista.php'; ?>    
    <script src="../../plugins/multi-select/js/jquery.multi-select.js"></script>

</body>
</html>

