<?php
    require_once("../login/Conn.php");
    require_once("aggiungiManga.php");

    session_start();

    if (!isset($_SESSION["username"]) || !isset($_SESSION["id_utente"])) {
        header("Location: index.php?msg=Effettua la login!");
        exit;
    }

    $id_utente = $_SESSION["id_utente"];
    $action = $_POST['action'];

    // Recupera i dati manga
    $id_manga = $_POST['id_manga'];
    $titolo_manga = $_POST['titolo_manga'];
    $autore_manga = $_POST['autore_manga'];
    $descrizione_manga = $_POST['descrizione_manga'];
    $volumi_manga = intval($_POST['volumi_manga']);
    $capitoli_manga = intval($_POST['capitoli_manga']);
    $rating_manga = floatval($_POST['rating_manga']);
    $immagine_manga = $_POST['immagine_manga'];

    $nome = $_POST['nome'];
    $descrizione = $_POST['descrizione'];

    // Verifica o inserisce manga
    IsMangaEsiste($conn, $id_manga, $titolo_manga, $autore_manga, $descrizione_manga, $volumi_manga, $capitoli_manga, $rating_manga, $immagine_manga);

    // Gestione libreria
    if ($action == 'crea') {

        $nome = $_POST['nome'];
        $descrizione = $_POST['descrizione'];
        $tipologia = $_POST['tipologia'];

        if (empty($nome) || empty($tipologia)) {
            header("Location: ../pagineVisualizzate/Librerie.php?msg=Nome o tipologia mancanti.");
            exit;
        }

        $stmt = $conn->prepare("SELECT id FROM libreria WHERE nome = ? AND id_utente = ?");
        $stmt->bind_param("si", $nome, $id_utente);
        $stmt->execute();
        $res = $stmt->get_result();
        if ($res->num_rows > 0) {
            header("Location: ../pagineVisualizzate/Librerie.php?msg=Libreria già esistente.");
            exit;
        }

        $stmt = $conn->prepare("INSERT INTO libreria (id_utente, nome, tipologia, descrizione) VALUES (?, ?, ?, ?)");
        $stmt->bind_param("isss", $id_utente, $nome, $tipologia, $descrizione);
        if (!$stmt->execute()) {
            header("Location: ../pagineVisualizzate/Librerie.php?msg=Errore nella creazione della libreria.");
            exit;
        }

        $id_libreria = $stmt->insert_id;

    }  elseif ($action == 'seleziona') {
        // Recupera l'ID della libreria selezionata
        $id_libreria = intval($_POST['id_libreria_selezionata']);

        // Verifica che l'ID della libreria sia valido
        if ($id_libreria == 0) {
            header("Location: ../pagineVisualizzate/Librerie.php?msg=Seleziona una libreria.");
            exit;
        }

        // Recupera la tipologia della libreria selezionata
        $stmt = $conn->prepare("SELECT tipologia, nome, descrizione FROM libreria WHERE id = ? AND id_utente = ?");
        $stmt->bind_param("ii", $id_libreria, $id_utente);
        $stmt->execute();
        $result = $stmt->get_result();

        // Se la libreria non esiste, mostra un messaggio di errore
        if ($result->num_rows == 0) {
            header("Location: ../pagineVisualizzate/Librerie.php?msg=Libreria non trovata.");
            exit;
        }

        // Assegna la tipologia della libreria
        $row = $result->fetch_assoc();
        $tipologia = $row['tipologia'];
        $nome = $row['nome'];
        $descrizione = $row['descrizione'];

    } else {
        header("Location: ../pagineVisualizzate/Librerie.php?msg=Azione non valida.");
        exit;
    }

    // Inserisci manga nella libreria
    $stmt = $conn->prepare("INSERT INTO libreria_manga (id_libreria, id_manga) VALUES (?, ?)");
    $stmt->bind_param("ii", $id_libreria, $id_manga);

    if (!$stmt->execute()) {
        header("Location: ../pagineVisualizzate/Librerie.php?msg=Errore nell'inserimento nella libreria: " . $stmt->error. "");
        exit;
    }

    $id_libreria_manga = $stmt->insert_id;

    // Gestione dettagli per tipologia
    $tipologia = strtolower(trim($tipologia));
    echo ".".$tipologia."."; 

    if ($tipologia == 'collezione') {
        $volumi = $_POST['volumi'];


        foreach ($volumi as $volume) {
            $numero_volume = intval($volume);
        
            $stmt = $conn->prepare("INSERT INTO collezione_volumi (id_libreria_manga, numero_volume) VALUES (?, ?)");
            $stmt->bind_param("ii", $id_libreria_manga, $numero_volume);
        
            $stmt->execute();
        }

    } elseif ($tipologia == 'lettura') {
        $capitolo = intval($_POST['capitolo']);
        $stato = $_POST['stato'];

        // Valori consentiti per enum
        $valori_enum = ['finito', 'in_corso', 'abbandonato'];

        if (!in_array($stato, $valori_enum)) {
            header("Location: ../pagineVisualizzate/Librerie.php?msg=Errore: stato di lettura non valido");
            exit;
        }

        // Se completato tutti i capitoli, forza stato a 'completato'
        if ($capitolo >= $capitoli_manga && $capitoli_manga > 0) {
            $stato = 'completato';
        }

        $stmt = $conn->prepare("INSERT INTO stato_lettura (id_libreria_manga, numero_capitolo, stato) VALUES (?, ?, ?)");
        $stmt->bind_param("iis", $id_libreria_manga, $capitolo, $stato);
        if (!$stmt->execute()) {
            header("Location: ../pagineVisualizzate/Librerie.php?msg=Errore nell'inserimento dello stato di lettura: " . $stmt->error . "");
            exit;
        }
    }

    // Tutto ok, reindirizza
    header("Location: ../pagineVisualizzate/ConsiglioAI.php?msg=Libreria aggiornata con successo!");
    exit;
?>
