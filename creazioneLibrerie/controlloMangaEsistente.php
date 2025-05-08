<?php
require_once("../login/Conn.php");

function verificaMangaEsistente($id_manga) {
    global $conn;
    
    $q = "SELECT * FROM manga WHERE id = ?";
    $stmt = $conn->prepare($q);

    if (!$stmt) {
        // Mostra errore SQL se la prepare fallisce
        die("Errore nella prepare: " . $conn->error);
    }

    $stmt->bind_param("i", $id_manga);
    $stmt->execute();
    $result = $stmt->get_result();
    
    return $result->num_rows > 0;
}
?>
