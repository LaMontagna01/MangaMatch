<?php
    function IsMangaEsiste($conn, $id, $nome, $autore, $descrizione, $volumi, $capitoli, $rating, $immagine) {
        $check = $conn->prepare("SELECT id FROM manga WHERE id = ?");
        if (!$check) {
            die("Errore SELECT: " . $conn->error);
        }
        $check->bind_param("i", $id);
        $check->execute();
        $check->store_result();

        if ($check->num_rows == 0) {
            $insert = $conn->prepare("INSERT INTO manga (id, nome, autore, descrizione, volumi, capitoli, rating, immagine) 
                                    VALUES (?, ?, ?, ?, ?, ?, ?, ?)");
            if (!$insert) {
                die("Errore INSERT: " . $conn->error);
            }
            $insert->bind_param("isssiiis", $id, $nome, $autore, $descrizione, $volumi, $capitoli, $rating, $immagine);
            $insert->execute();
            $insert->close();
        }

        $check->close();
    }
?>