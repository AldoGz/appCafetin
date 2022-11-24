<?php require_once '../build/code/pvalidar.vista.php'; ?>
<html lang="en">
<head>
    <?php require_once '../build/code/metas.vista.php'; ?>
    <title>BAR</title>
    <?php require_once '../build/code/estilos.vista.php'; ?> 
</head>
<body>
    <div class="card text-center" style="height: 100%;border-radius: 0px;">
        <div class="card-header">
            <div class="d-flex justify-content-between align-items-center" style="justify-content: center;">
                <h5><?php echo $_SESSION["usuario"]; ?><small id="t2"></small></h5>
                <button type="button" class="btn btn-primary" onclick="cerrarSesion()"> Cerrar sesión</button>
            </div>            
        </div>
        <div class="card-body tab-contenido-mostrar">
            <div id="listado-t2-mesas" class="row"></div>
        </div>

        <div class="modal fade"  role="dialog" data-backdrop="static" data-keyboard="false" id="confirmar_sesion">
            <div class="modal-dialog modal-dialog-centered">                        
                <div class="modal-content">
                    <div class="modal-header">
                        ¿Desea cerrar la sesión del barista?
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

    </div>
    <?php require_once '../build/code/scripts.vista.php'; ?>
</body>
</html>

