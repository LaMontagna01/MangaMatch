<?php
require_once("../login/Conn.php");

if (!isset($_SESSION)) {
    session_start();
}

if (!isset($_SESSION["username"])) {
    echo json_encode(["error" => "Effettua il login per gestire la libreria!"]);
    exit;
}

$action = $_POST["action"] ?? '';

if ($action == 'crea') {
    // Creazione di una nuova libreria
    $nome = $_POST['nome'] ?? '';
    $tipologia = $_POST['tipologia'] ?? '';
    $descrizione = $_POST['descrizione'] ?? '';

    // Verifica se nome e tipologia sono forniti
    if ($nome && $tipologia) {
        // Validazione della tipologia
        $tipologie_permesse = ['collezione', 'lettura'];
        if (!in_array($tipologia, $tipologie_permesse)) {
            echo json_encode(["error" => "Tipologia non valida!"]);
            exit;
        }
        
        // Inserisce la nuova libreria nel database
        $q = "INSERT INTO libreria (id_utente, nome, tipologia, descrizione) VALUES (?, ?, ?, ?)";
        $stmt = $conn->prepare($q);
        $stmt->bind_param("isss", $_SESSION["id_utente"], $nome, $tipologia, $descrizione);
        
        if ($stmt->execute()) {
            echo json_encode(["success" => "Libreria creata con successo!"]);
        } else {
            echo json_encode(["error" => "Errore nella creazione della libreria! " . $stmt->error]);
        }
    } else {
        echo json_encode(["error" => "Nome e tipologia sono obbligatori!"]);
    }
} elseif ($action == 'seleziona') {
    // Aggiungi manga a libreria esistente
    $id_libreria = $_POST['id_libreria_selezionata'] ?? null;
    $id_manga = $_POST['id_manga'] ?? null;

    if ($id_libreria && $id_manga) {
        $q = "INSERT INTO libreria_manga (id_libreria, id_manga) VALUES (?, ?)";
        $stmt = $conn->prepare($q);
        $stmt->bind_param("ii", $id_libreria, $id_manga);
        
        if ($stmt->execute()) {
            echo json_encode(["success" => "Manga aggiunto alla libreria!"]);
        } else {
            echo json_encode(["error" => "Errore nell'aggiunta alla libreria! " . $stmt->error]);
        }
    } else {
        echo json_encode(["error" => "Dati mancanti!"]);
    }
} else {
    echo json_encode(["error" => "Azione non valida!"]);
}
?>
