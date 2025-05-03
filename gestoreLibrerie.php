<?php
require_once("login/Conn.php");
require_once("aggiungiManga.php");

if (!isset($_SESSION)) {
    session_start();
}

if (!isset($_SESSION["username"])) {
    header("Location: index.php?msg=Effettua la login!");
    exit;
}

$id_utente = $_SESSION['id_utente'] ?? null;
if (!$id_utente) {
    header("Location: index.php?msg=Utente non riconosciuto.");
    exit;
}

$action = $_POST['action'] ?? null;
$id_manga = $_POST['id_manga'] ?? null;
$titolo_manga = $_POST['titolo_manga'] ?? '';
$autore_manga = $_POST['autore_manga'] ?? '';
$descrizione_manga = $_POST['descrizione_manga'] ?? '';
$volumi_manga = $_POST['volumi_manga'] ?? 0;
$capitoli_manga = $_POST['capitoli_manga'] ?? 0;
$rating_manga = $_POST['rating_manga'] ?? 0;
$immagine_manga = $_POST['immagine_manga'] ?? '';

if (!$id_manga || !$action) {
    header("Location: Librerie.php?msg=Dati mancanti.");
    exit;
}

if ($action === 'crea') {
    $nome = $_POST['nome'] ?? '';
    $tipologia = $_POST['tipologia'] ?? '';
    $descrizione = $_POST['descrizione'] ?? '';

    // Verifica se la libreria con lo stesso nome esiste già per quell'utente
    $stmt = $conn->prepare("SELECT id FROM libreria WHERE nome = ? AND id_utente = ?");
    $stmt->bind_param("si", $nome, $id_utente);
    $stmt->execute();
    $res = $stmt->get_result();
    if ($res->num_rows > 0) {
        header("Location: Librerie.php?msg=Libreria già esistente.");
        exit;
    }

    // Inserisci la nuova libreria
    $stmt = $conn->prepare("INSERT INTO libreria (id_utente, nome, tipologia, descrizione) VALUES (?, ?, ?, ?)");
    $stmt->bind_param("isss", $id_utente, $nome, $tipologia, $descrizione);
    if ($stmt->execute()) {
        $id_libreria = $stmt->insert_id;
    } else {
        header("Location: Librerie.php?msg=Errore nella creazione della libreria.");
        exit;
    }

} elseif ($action === 'seleziona') {
    $id_libreria = $_POST['libreria'] ?? null;
    if (!$id_libreria) {
        header("Location: Librerie.php?msg=Seleziona una libreria.");
        exit;
    }

    // Ottieni la tipologia della libreria selezionata
    $stmt = $conn->prepare("SELECT tipologia FROM libreria WHERE id = ? AND id_utente = ?");
    $stmt->bind_param("ii", $id_libreria, $id_utente);
    $stmt->execute();
    $result = $stmt->get_result();
    if ($result->num_rows === 0) {
        header("Location: Librerie.php?msg=Libreria non trovata.");
        exit;
    }
    $row = $result->fetch_assoc();
    $tipologia = $row['tipologia'];
} else {
    header("Location: Librerie.php?msg=Azione non valida.");
    exit;
}

// Verifica che il manga esista nel database, usando la funzione dal file gestoreAzioneConsiglio.php
IsMangaEsiste($conn, $id_manga, $titolo_manga, $autore_manga, $descrizione_manga, $volumi_manga, $capitoli_manga, $rating_manga, $immagine_manga);

// Controlla se la libreria esiste nella tabella libreria
$stmt = $conn->prepare("SELECT id FROM libreria WHERE id = ?");
$stmt->bind_param("i", $id_libreria);
$stmt->execute();
$res = $stmt->get_result();

if ($res->num_rows === 0) {
    // La libreria non esiste
    echo "Errore: La libreria con id $id_libreria non esiste.";
    exit;
}

// Inserisci il manga nella libreria
$stmt = $conn->prepare("INSERT INTO libreria_manga (id_libreria, id_manga) VALUES (?, ?)");
$stmt->bind_param("ii", $id_libreria, $id_manga);

if ($stmt->execute()) {
    $id_libreria_manga = $stmt->insert_id;

    // Inserimento dei dati specifici in base alla tipologia
    if ($tipologia === 'collezione' && isset($_POST['volumi'])) {
        $volumi = $_POST['volumi'];
        foreach ($volumi as $volume) {
            $numero_volume = intval($volume);
            $stmt = $conn->prepare("INSERT INTO collezione_volumi (id_libreria_manga, numero_volume) VALUES (?, ?)");
            $stmt->bind_param("ii", $id_libreria_manga, $numero_volume);
            $stmt->execute();
        }
    } elseif ($tipologia === 'lettura' && isset($_POST['capitolo']) && isset($_POST['stato'])) {
        $capitolo = intval($_POST['capitolo']);
        $stato = $_POST['stato'];
    
        // Se il capitolo selezionato è uguale al totale, forza lo stato a 'completato'
        if ($capitolo >= intval($capitoli_manga) && $capitoli_manga > 0) {
            $stato = 'completato';
        }
    
        // Validazione enum
        $valori_enum = ['in corso', 'completato', 'in pausa', 'abbandonato'];
        if (!in_array($stato, $valori_enum)) {
            echo "Errore: stato di lettura non valido.";
            exit;
        }
    
        $stmt = $conn->prepare("INSERT INTO stato_lettura (id_libreria_manga, numero_capitolo, stato) VALUES (?, ?, ?)");
        if (!$stmt) {
            echo "Errore nella preparazione della query: " . $conn->error;
            exit;
        }
    
        $stmt->bind_param("iis", $id_libreria_manga, $capitolo, $stato);
        if (!$stmt->execute()) {
            echo "Errore nell'inserimento dello stato di lettura: " . $stmt->error;
            exit;
        }
    }
    
    
    header("Location: ConsiglioAI.php?msg=Libreria aggiornata con successo!");
    exit;
} else {
    //echo "Errore nella query: " . $stmt->error; // Mostra l'errore
    //exit;
}
?>
