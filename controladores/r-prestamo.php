<?php

include("../class/prestamo.php");
    $ambiente = $_POST[ 'ambiente' ];
    $h_ingreso = $_POST[ 'h_ingreso' ];
    $h_salida = $_POST[ 'h_salida' ];
    $No_documento= $_POST[ 'instructor' ];
    $f_prestamo = $_POST['inicio_prestamo'];
    $f_devolucion = $_POST['fin_prestamo'];
    $observaciones = $_POST['comentario'];
    if ( $f_prestamo && $f_devolucion )
    {
      
        prestamos::ingresar_prestamo($f_prestamo, $f_devolucion, $h_ingreso, $h_salida, $ambiente,$No_documento, $observaciones);
        
       
        
    }
    else{
       
        echo '<script language="javascript">alert("Tus datos no se guardaron, COMPLETE TODOS LOS CAMPOS");window.location.href="c-prestamo.php";</script>';
    }