<?php
require_once("../login/Conn.php");
require_once("aggiungiManga.php");

if (!isset($_SESSION)) {
    session_start();
}

if (!isset($_SESSION["username"])) {
    header("Location: ../pagineVisualizzate/ConsiglioAI.php?status=Effettua il login per aggiungere ai preferiti!");
    exit;
}

$id_utente = $_SESSION["id_utente"];

$datiManga = [
    "id_manga" => $_POST["id_manga"] ?? null,
    "titolo_manga" => $_POST["titolo_manga"] ?? null,
    "autore_manga" => $_POST["autore_manga"] ?? null,
    "descrizione_manga" => $_POST["descrizione_manga"] ?? null,
    "volumi_manga" => $_POST["volumi_manga"] ?? null,
    "capitoli_manga" => $_POST["capitoli_manga"] ?? null,
    "rating_manga" => $_POST["rating_manga"] ?? null,
    "immagine_manga" => $_POST["immagine_manga"] ?? null
];

// Logica per gestire l'aggiunta ai preferiti
if ($datiManga["id_manga"] && $id_utente) {

    $risultato = aggiungiManga($conn, $datiManga);

    if (isset($risultato["error"])) {
        // Redirect con messaggio di errore
        header("Location: ../pagineVisualizzate/ConsiglioAI.php?status=error&message=" . urlencode("Errore nell'aggiunta del manga."));
        exit;
    }
    
    
    // Verifica se il manga è già nei preferiti
    $q = "SELECT * FROM preferiti WHERE id_utente = ? AND id_manga = ?";
    $stmt = $conn->prepare($q);
    $stmt->bind_param("ii", $id_utente, $datiManga["id_manga"]);
    $stmt->execute();
    $result = $stmt->get_result();

    if ($result->num_rows > 0) {
        // Redirect con messaggio di errore
        header("Location: ../pagineVisualizzate/ConsiglioAI.php?status=error&message=" . urlencode("Questo manga è già nei tuoi preferiti."));
        exit;
    } else {
        // Aggiungi il manga ai preferiti
        $q = "INSERT INTO preferiti (id_utente, id_manga) VALUES (?, ?)";
        $stmt = $conn->prepare($q);
        $stmt->bind_param("ii", $id_utente, $datiManga["id_manga"]);
        if ($stmt->execute()) {
            // Redirect con messaggio di successo
            header("Location: ../pagineVisualizzate/ConsiglioAI.php?status=success&message=" . urlencode("Manga aggiunto ai preferiti!"));
            exit;
        } else {
            // Redirect con errore
            header("Location: ../pagineVisualizzate/ConsiglioAI.php?status=error&message=" . urlencode("Errore nell'aggiunta ai preferiti!"));
            exit;
        }
    }
} else {
    // Redirect con errore se i dati mancano
    header("Location: ../pagineVisualizzate/ConsiglioAI.php?status=error&message=" . urlencode("Dati mancanti!"));
    exit;
}

?>
