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
$id_manga = $_POST["id_manga"] ?? null;

// Verifica che l'ID manga sia stato passato
if ($id_manga && $id_utente) {
    // Controlla se l'ID manga esiste nel database
    $q = "SELECT * FROM manga WHERE id = ?";
    $stmt = $conn->prepare($q);
    $stmt->bind_param("i", $id_manga);
    $stmt->execute();
    $result = $stmt->get_result();

    if ($result->num_rows > 0) {
        // Il manga esiste nel DB, ora controlla se è già nei preferiti dell'utente
        $q = "SELECT * FROM preferiti WHERE id_utente = ? AND id_manga = ?";
        $stmt = $conn->prepare($q);
        $stmt->bind_param("ii", $id_utente, $id_manga);
        $stmt->execute();
        $resultPreferiti = $stmt->get_result();

        if ($resultPreferiti->num_rows > 0) {
            // Il manga è già nei preferiti
            header("Location: ../pagineVisualizzate/profilo.php?status=error&message=" . urlencode("Questo manga è già nei tuoi preferiti."));
            exit;
        } else {
            // Il manga non è nei preferiti, aggiungilo
            $q = "INSERT INTO preferiti (id_utente, id_manga) VALUES (?, ?)";
            $stmt = $conn->prepare($q);
            $stmt->bind_param("ii", $id_utente, $id_manga);
            if ($stmt->execute()) {
                // Redirect con messaggio di successo
                header("Location: ../pagineVisualizzate/profilo.php?status=success&message=" . urlencode("Manga aggiunto ai preferiti!"));
                exit;
            } else {
                // Redirect con errore
                header("Location: ../pagineVisualizzate/ConsiglioAI.php?status=error&message=" . urlencode("Errore nell'aggiunta ai preferiti!"));
                exit;
            }
        }
    } else {
        // Il manga non esiste nel DB, bisogna aggiungere tutti i dati
        $datiManga = [
            "id_manga" => $id_manga,
            "titolo_manga" => $_POST["titolo_manga"] ?? null,
            "autore_manga" => $_POST["autore_manga"] ?? null,
            "descrizione_manga" => $_POST["descrizione_manga"] ?? null,
            "volumi_manga" => $_POST["volumi_manga"] ?? null,
            "capitoli_manga" => $_POST["capitoli_manga"] ?? null,
            "rating_manga" => $_POST["rating_manga"] ?? null,
            "immagine_manga" => $_POST["immagine_manga"] ?? null
        ];

        // Verifica se tutti i dati sono stati passati, altrimenti mostra errore
        if (!$datiManga["titolo_manga"] || !$datiManga["autore_manga"] || !$datiManga["descrizione_manga"]) {
            header("Location: ../pagineVisualizzate/ConsiglioAI.php?status=error&message=" . urlencode("Dati mancanti!"));
            exit;
        }

        // Se i dati sono completi, aggiungi il manga al DB
        $risultato = aggiungiManga($conn, $datiManga);

        if (isset($risultato["error"])) {
            // Se ci sono errori nell'aggiunta, redirigi con errore
            header("Location: ../pagineVisualizzate/ConsiglioAI.php?status=error&message=" . urlencode("Errore nell'aggiunta del manga."));
            exit;
        }

        // Ora che il manga è stato aggiunto al DB, aggiungilo anche ai preferiti
        $q = "INSERT INTO preferiti (id_utente, id_manga) VALUES (?, ?)";
        $stmt = $conn->prepare($q);
        $stmt->bind_param("ii", $id_utente, $id_manga);
        if ($stmt->execute()) {
            // Redirect con messaggio di successo
            header("Location: ../pagineVisualizzate/profilo.php?status=success&message=" . urlencode("Manga aggiunto ai preferiti!"));
            exit;
        } else {
            // Redirect con errore
            header("Location: ../pagineVisualizzate/ConsiglioAI.php?status=error&message=" . urlencode("Errore nell'aggiunta ai preferiti!"));
            exit;
        }
    }
} else {
    // Redirect con errore se manca l'ID manga o l'utente
    header("Location: ../pagineVisualizzate/profilo.php?status=error&message=" . urlencode("Dati mancanti!"));
    exit;
}
?>
