<?php
require_once("login/Conn.php");

if (!isset($_SESSION)) {
    session_start();
}

if (!isset($_SESSION["username"])) {
    header("Location: index.php?msg=Effettua la login!");
    exit;
}

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

// Recupera valori dal POST
$id_utente = $_SESSION["id_utente"];

$id_manga = $_POST["id_manga"];
$titolo_manga = $_POST["titolo_manga"];
$autore_manga = $_POST["autore_manga"];
$descrizione = $_POST["descrizione_manga"];
$volumi = $_POST["volumi_manga"];
$capitoli = $_POST["capitoli_manga"];
$rating = $_POST["rating_manga"];
$immagine = $_POST["immagine_manga"];

if ($id_manga && $id_utente) {

    // 1. Assicurati che il manga esista nella tabella
    IsMangaEsiste($conn, $id_manga, $titolo_manga, $autore_manga, $descrizione, $volumi, $capitoli, $rating, $immagine);

    // 2. Aggiungi ai preferiti
    if (isset($_POST["preferiti"])) {
        $q = "INSERT INTO preferiti (id_utente, id_manga) VALUES (?, ?)";
        $stmt = $conn->prepare($q);
    
        if ($stmt) {
            $stmt->bind_param("ii", $id_utente, $id_manga);
            $success = $stmt->execute();
    
            if ($success) {
                header("Location: ConsiglioAI.php?msg=Preferito aggiunto!");
                exit;
            } else {
                header("Location: ConsiglioAI.php?msg=Errore: " . $stmt->error);
                exit;
            }
        } else {
            header("Location: ConsiglioAI.php?msg=Errore nella query: " . $conn->error);
            exit;
        }

    // 3. Oppure aggiungi alla collezione
    } elseif (isset($_POST["Collezione"])) {
        $q = "INSERT INTO collezione (id_utente, id_manga) VALUES (?, ?)";
        $stmt = $conn->prepare($q);

        if ($stmt) {
            $stmt->bind_param("ii", $id_utente, $id_manga);
            $success = $stmt->execute();

            if ($success) {
                header("Location: ConsiglioAI.php?msg=Collezione aggiornata!");
                exit;
            } else {
                header("Location: ConsiglioAI.php?msg=Errore: " . $stmt->error);
                exit;
            }
        } else {
            header("Location: ConsiglioAI.php?msg=Errore nella query: " . $conn->error);
            exit;
        }
    }
}

//header("Location: ConsiglioAI.php?msg=Operazione non valida.");
//exit;
?>
