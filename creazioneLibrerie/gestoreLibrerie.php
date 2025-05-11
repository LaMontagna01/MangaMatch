<?php
require_once("../login/Conn.php");
require_once("./aggiungiManga.php");

if (!isset($_SESSION)) {
    session_start();
}

if (!isset($_SESSION["username"])) {
    header("Location: ../pagineVisualizzate/ConsiglioAI.php?msg=" . urlencode("Effettua il login per gestire la libreria!"));
    exit;
}

$action = $_POST["action"] ?? '';

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
    else{
        if ($action == 'crea') {
            $nome = $_POST['nome'] ?? '';
            $tipologia = $_POST['tipologia'] ?? '';
            $descrizione = $_POST['descrizione'] ?? '';
            $id_manga = $_POST['id_manga'] ?? null;


            if ($nome && $tipologia && $id_manga) {
                $tipologie_permesse = ['Collezione', 'Lettura'];
                if (!in_array($tipologia, $tipologie_permesse)) {
                    header("Location: ../pagineVisualizzate/ConsiglioAI.php?msg=" . urlencode("Tipologia non valida!"));
                    exit;
                }

                $q = "INSERT INTO libreria (id_utente, nome, tipologia, descrizione) VALUES (?, ?, ?, ?)";
                $stmt = $conn->prepare($q);
                $stmt->bind_param("isss", $_SESSION["id_utente"], $nome, $tipologia, $descrizione);

                if ($stmt->execute()) {
                    $id_libreria = $stmt->insert_id;

                    $q_link = "INSERT INTO libreria_manga (id_libreria, id_manga) VALUES (?, ?)";
                    $stmt_link = $conn->prepare($q_link);
                    $stmt_link->bind_param("ii", $id_libreria, $id_manga);
                    $stmt_link->execute();
                    $id_libreria_manga = $stmt_link->insert_id;

                    if ($tipologia == 'Collezione') {
                        $volumi = $_POST['volumi'] ?? [];
                        if (!empty($volumi)) {
                            $q_vol = "INSERT INTO collezione_volumi (id_libreria_manga, numero_volume) VALUES (?, ?)";
                            $stmt_vol = $conn->prepare($q_vol);
                            foreach ($volumi as $volume) {
                                $stmt_vol->bind_param("ii", $id_libreria_manga, $volume);
                                $stmt_vol->execute();
                            }
                        }
                    } elseif ($tipologia == 'Lettura') {
                        $capitolo = $_POST['capitolo'] ?? '';
                        $stato = $_POST['stato'] ?? '';
                        if ($capitolo && $stato) {
                            $q_stato = "INSERT INTO stato_lettura (id_libreria_manga, numero_capitolo, stato) VALUES (?, ?, ?)";
                            $stmt_stato = $conn->prepare($q_stato);
                            $stmt_stato->bind_param("iis", $id_libreria_manga, $capitolo, $stato);
                            $stmt_stato->execute();
                        }
                    }

                    header("Location: ../pagineVisualizzate/ConsiglioAI.php?msg=" . urlencode("Libreria creata con successo!"));
                    exit;
                } else {
                    header("Location: ../pagineVisualizzate/ConsiglioAI.php?msg=" . urlencode("Errore nella creazione della libreria! " . $stmt->error));
                    exit;
                }
            } else {
                header("Location: ../pagineVisualizzate/ConsiglioAI.php?msg=" . urlencode("Nome, tipologia e id manga sono obbligatori!"));
                exit;
            }
    
        } 
        elseif ($action == 'seleziona') {
            $id_libreria = $_POST['id_libreria_selezionata'] ?? null;
            $id_manga = $_POST['id_manga'] ?? null;

            if ($id_libreria && $id_manga) {
                $q_tipo = "SELECT tipologia FROM libreria WHERE id = ?";
                $stmt_tipo = $conn->prepare($q_tipo);
                $stmt_tipo->bind_param("i", $id_libreria);
                $stmt_tipo->execute();
                $stmt_tipo->bind_result($tipologia);
                $stmt_tipo->fetch();
                $stmt_tipo->close();

                $q_link = "INSERT INTO libreria_manga (id_libreria, id_manga) VALUES (?, ?)";
                $stmt_link = $conn->prepare($q_link);
                $stmt_link->bind_param("ii", $id_libreria, $id_manga);
                $stmt_link->execute();
                $id_libreria_manga = $stmt_link->insert_id;

                if ($tipologia == 'Collezione') {
                    $volumi = $_POST['volumi'] ?? [];
                    if (!empty($volumi)) {
                        $q_vol = "INSERT INTO collezione_volumi (id_libreria_manga, numero_volume) VALUES (?, ?)";
                        $stmt_vol = $conn->prepare($q_vol);
                        foreach ($volumi as $volume) {
                            $stmt_vol->bind_param("ii", $id_libreria_manga, $volume);
                            $stmt_vol->execute();
                        }
                        header("Location: ../pagineVisualizzate/ConsiglioAI.php?msg=" . urlencode("Manga aggiunto alla libreria collezione!"));
                        exit;
                    } else {
                        header("Location: ../pagineVisualizzate/ConsiglioAI.php?msg=" . urlencode("Volumi mancanti!"));
                        exit;
                    }
                } elseif ($tipologia == 'Lettura') {
                    $capitolo = $_POST['capitolo'] ?? '';
                    $stato = $_POST['stato'] ?? '';
                    if ($capitolo && $stato) {
                        $q_stato = "INSERT INTO stato_lettura (id_libreria_manga, numero_capitolo, stato) VALUES (?, ?, ?)";
                        $stmt_stato = $conn->prepare($q_stato);
                        $stmt_stato->bind_param("iis", $id_libreria_manga, $capitolo, $stato);
                        $stmt_stato->execute();
                        header("Location: ../pagineVisualizzate/ConsiglioAI.php?msg=" . urlencode("Manga aggiunto alla libreria lettura!"));
                        exit;
                    } else {
                        header("Location: ../pagineVisualizzate/ConsiglioAI.php?msg=" . urlencode("Capitolo o stato mancanti!"));
                        exit;
                    }
                }

            } else {
                header("Location: ../pagineVisualizzate/ConsiglioAI.php?msg=" . urlencode("ID libreria o manga mancanti!"));
                exit;
            }
        }
    }
}
else {
    header("Location: ../pagineVisualizzate/ConsiglioAI.php?msg=" . urlencode("Azione non valida!"));
    exit;
}
?>
