<?php
require_once("../login/Conn.php");
require_once("controlloMangaEsistente.php");

if (!isset($_SESSION)) {
    session_start();
}

function aggiungiManga($conn, $dati) {
    $id_manga = $dati["id_manga"] ?? null;
    $titolo = $dati["titolo_manga"] ?? null;
    $autore = $dati["autore_manga"] ?? null;
    $descrizione = $dati["descrizione_manga"] ?? null;
    $volumi = $dati["volumi_manga"] ?? null;
    $capitoli = $dati["capitoli_manga"] ?? null;
    $rating = $dati["rating_manga"] ?? null;
    $immagine = $dati["immagine_manga"] ?? null;

    if ($id_manga && $titolo && $autore && $descrizione && $volumi && $capitoli && $rating) {
        // Verifica se il manga esiste già nel database
        if (verificaMangaEsistente($id_manga)) {
            return ["erroe" => "Manga già presente nel database."];
        }

        // Aggiungi il manga alla libreria
        $q = "INSERT INTO manga (id, nome, autore, descrizione, volumi, capitoli, rating, immagine) 
              VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        $stmt = $conn->prepare($q);
        $stmt->bind_param("isssiiis",  $id_manga, $titolo, $autore, $descrizione, $volumi, $capitoli, $rating, $immagine);

        if ($stmt->execute()) {
            return ["success" => "Manga aggiunto alla libreria!"];
        } else {
            return ["error" => "Errore nell'aggiunta alla libreria!"];
        }
    } else {
        return ["error" => "Dati mancanti per aggiungere il manga!"];
    }
}

?>
