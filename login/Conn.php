<?php

    $conn= new mysqli("localhost","root","","lememe");
    
    if($conn->connect_errno){
    
        die($conn->connect_error);
    }


?>