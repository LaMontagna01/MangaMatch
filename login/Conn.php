<?php

    $conn= new mysqli("localhost","root","","MangaMatch");
    
    if($conn->connect_errno){
    
        die($conn->connect_error);
    }


?>