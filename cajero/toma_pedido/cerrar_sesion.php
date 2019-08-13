<?php

session_name("CAFETIN");
session_start();

unset($_SESSION["cod_usuario"]);
unset($_SESSION["usuario"]);
unset($_SESSION["cargo"]);
session_destroy();

header("location:../../sesion");

