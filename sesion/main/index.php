<?php require_once '../build/code/validar.vista.php' ?>   
<html lang="en">
<head>
    <?php require_once '../build/code/metas.vista.php' ?>    
    <title>Iniciar Sesion</title>
    <?php require_once '../build/code/estilos.vista.php' ?>    
</head>
<body class="text-center">
    <form class="form-signin">
        <img class="mb-4" src="../../imagenes/ilogo.png" width="120" height="120">
        <h1 class="h3 mb-3 font-weight-normal">Iniciar sesión</h1>
        <label for="txtusuario" class="sr-only">Usuario</label>
        <input type="text" id="txtusuario" class="form-control" placeholder="Usuario" required="" autofocus="" maxlength="8" autocomplete="off">
        <br>
        <label for="txtclave" class="sr-only">Contraseña</label>
        <input type="password" id="txtclave" class="form-control" placeholder="Contraseña" required="" autocomplete="off">
        <br>
        <button class="btn btn-lg btn-primary btn-block" type="submit" id="btnIngresar">Ingresar</button>
    </form>
    <?php require_once '../build/code/scripts.vista.php' ?>
</body>
</html>