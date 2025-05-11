<?php
require_once("../login/Conn.php");

if (!isset($_SESSION)) {
    session_start();
}

if (!isset($_SESSION["username"])) {
    header("Location: ../pagineVisualizzate/profilo.php?status=Effettua il login per rimuovere dai preferiti!");
    exit;
}

$id_utente = $_SESSION["id_utente"];
$id_manga = $_POST["id_manga"] ?? null;

if ($id_manga && $id_utente) {
    // Verifica se il manga è nei preferiti
    $checkQuery = "SELECT * FROM preferiti WHERE id_utente = ? AND id_manga = ?";
    $stmt = $conn->prepare($checkQuery);
    $stmt->bind_param("ii", $id_utente, $id_manga);
    $stmt->execute();
    $result = $stmt->get_result();

    if ($result->num_rows === 0) {
        // Se il manga non è nei preferiti, restituisci errore
        header("Location: ../pagineVisualizzate/profilo.php?status=error&message=" . urlencode("Questo manga non è nei tuoi preferiti."));
        exit;
    }

    // Rimozione dai preferiti
    $deleteQuery = "DELETE FROM preferiti WHERE id_utente = ? AND id_manga = ?";
    $stmt = $conn->prepare($deleteQuery);
    $stmt->bind_param("ii", $id_utente, $id_manga);

    if ($stmt->execute()) {
        header("Location: ../pagineVisualizzate/profilo.php?status=success&message=" . urlencode("Manga rimosso dai preferiti."));
        exit;
    } else {
        header("Location: ../pagineVisualizzate/profilo.php?status=error&message=" . urlencode("Errore nella rimozione dai preferiti."));
        exit;
    }
} else {
    header("Location: ../pagineVisualizzate/profilo.php?status=error&message=" . urlencode("Dati mancanti."));
    exit;
}
?>
