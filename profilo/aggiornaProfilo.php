<?php
    require_once ("../login/conn.php"); 

    if (!isset($_SESSION)) {
        session_start();
    }
    
    if (isset($_SESSION["id_utente"])) {
        $id_utente = $_SESSION["id_utente"];
        $nome = $_POST["nome"];
        $cognome = $_POST["cognome"] ;

        if (!empty($nome) && !empty($cognome)) {
            $stmt = $conn->prepare("UPDATE utente SET nome = ?, cognome = ? WHERE id_utente = ?");
            $stmt->bind_param("ssi", $nome, $cognome, $id_utente);

            if ($stmt->execute()) {
                echo "Profilo aggiornato con successo!";
            } else {
                echo "Errore durante l'aggiornamento.";
            }

            $stmt->close();
        } else {
            echo "Compila tutti i campi.";
        }
    } else {
        echo "Utente non autenticato.";
    }

?>
