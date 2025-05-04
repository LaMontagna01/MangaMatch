<?php
    require_once("../login/Conn.php");
    if (!isset($_SESSION)) {
        session_start();
    }
    // Verifica che l'utente sia loggato
    if (!isset($_SESSION["username"])) {
        header("Location: index.php?msg=Effettua la login!");
        exit;
    }

    if (isset($_GET["msg"]))
        echo "<h2>" . $_GET["msg"] . "</h2>";

    // Recupero dei manga inviati via POST
    $manga = [
        'id_manga' => $_POST['id_manga'],
        'titolo_manga' => $_POST['titolo_manga'],
        'autore_manga' => $_POST['autore_manga'],
        'descrizione_manga' => $_POST['descrizione_manga'],
        'volumi_manga' => $_POST['volumi_manga'],
        'capitoli_manga' => $_POST['capitoli_manga'],
        'rating_manga' => $_POST['rating_manga'],
        'immagine_manga' => $_POST['immagine_manga'],
    ];

    // Recupera tutte le librerie dell'utente
    $q = "SELECT id, nome, tipologia FROM libreria WHERE id_utente = ?";
    $stmt = $conn->prepare($q);
    $stmt->bind_param("i", $_SESSION["id_utente"]);
    $stmt->execute();
    $librerie_utente = $stmt->get_result();

?>

<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestisci Librerie</title>
    <script src="../creazioneLibrerie/scriptLibrerie.js"></script>
</head>
<body>
    <h2>Gestisci Libreria</h2>
    <form action="../creazioneLibrerie/gestoreLibrerie.php" method="POST">
        
        <input type="hidden" name="id_libreria_selezionata" id="id_libreria_selezionata">
        <input type="hidden" name="id_manga" value="<?php echo $manga['id_manga']; ?>">
        <input type="hidden" name="titolo_manga" value="<?php echo $manga['titolo_manga']; ?>">
        <input type="hidden" name="autore_manga" value="<?php echo $manga['autore_manga']; ?>">
        <input type="hidden" name="descrizione_manga" value="<?php echo $manga['descrizione_manga']; ?>">
        <input type="hidden" name="volumi_manga" value="<?php echo $manga['volumi_manga']; ?>">
        <input type="hidden" name="capitoli_manga" value="<?php echo $manga['capitoli_manga']; ?>">
        <input type="hidden" name="rating_manga" value="<?php echo $manga['rating_manga']; ?>">
        <input type="hidden" name="immagine_manga" value="<?php echo $manga['immagine_manga']; ?>">

        <label for="action">Cosa vuoi fare?</label>
        <select id="action" name="action" onchange="showFormOptions()">
            <option value="" disabled selected>-- Seleziona --</option>
            <option value="crea">Crea Nuova Libreria</option>
            <option value="seleziona">Seleziona Libreria Esistente</option>
        </select>

        <div id="creaLibreriaForm" style="display: none;">
            <label for="nome">Nome Libreria:</label>
            <input type="text" id="nome" name="nome" required>
            
            <label for="tipologia">Tipologia:</label>
            <select id="tipologia" name="tipologia" onchange="showFormOptions()" required>
                <option value="" disabled selected>-- Seleziona --</option>
                <option value="collezione">Collezione</option>
                <option value="lettura">Lettura</option>
            </select>

            <label for="descrizione">Descrizione:</label>
            <textarea id="descrizione" name="descrizione"></textarea>
        </div>

        <div id="selezionaLibreriaForm" style="display: none;">
            <label for="libreria">Seleziona Libreria Esistente:</label>
            <select name="id_libreria_selezionata" id="libreria" required onchange="showFormOptions()">
            <option value="" selected>-- Seleziona una libreria --</option>
                <?php 
                    while ($row = $librerie_utente->fetch_assoc()) {
                        $id = $row['id'];
                        $nome = htmlspecialchars($row['nome']);
                        $tipologia = htmlspecialchars($row['tipologia']); // protezione XSS
                        echo "<option value=\"$id\" name='$nome' data-tipologia=\"$tipologia\">$nome ($tipologia)</option>";
                    }
                ?>
            </select>
        </div>


        <div id="volumiSelect" style="display: none;">
            <label for="volumi">Seleziona Volumi in Collezione:</label>
            <select multiple name="volumi[]" id="volumi" required >
                <?php
                    $max_volumi = intval($manga['volumi_manga']);
                    for ($i = 1; $i <= $max_volumi; $i++) {
                        echo "<option value=\"$i\">Volume $i</option>";
                    }
                ?>
            </select>
        </div>

        <div id="capitoloSelect" style="display: none;">
            <label for="capitolo">Seleziona Capitolo:</label>
            <select name="capitolo" id="capitolo" required >
                <?php
                    $max_capitoli = intval($manga['capitoli_manga']);
                    for ($i = 1; $i <= $max_capitoli; $i++) {
                        echo "<option value=\"$i\">Capitolo $i</option>";
                    }
                ?>
            </select>
        </div>

        <div id="statoSelect" style="display: none;">
            <label for="stato">Seleziona Stato:</label>
            <select name="stato" id="stato" required>
                <option value="in_corso">In Corso</option>
                <option value="completato">Completato</option>
                <option value="abbandonato">Abbandonato</option>
            </select>
        </div>

        <button type="submit">Salva</button>
    </form>
</body>
</html>
