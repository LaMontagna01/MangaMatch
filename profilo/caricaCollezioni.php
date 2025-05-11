<?php
    require_once("../login/conn.php");

    if (!isset($_SESSION)) {
        session_start();
    }

    if (!isset($_SESSION["id_utente"])) {
        echo "Errore: Utente non autenticato.";
        exit;
    }

    // La tua query e logica per ottenere le collezioni
    $sql = "SELECT 
                l.nome AS nome_collezione,
                m.id AS id_manga,
                m.immagine,
                GROUP_CONCAT(cv.numero_volume ORDER BY cv.numero_volume) AS volumi
            FROM libreria l
            JOIN libreria_manga lm ON l.id = lm.id_libreria
            JOIN manga m ON lm.id_manga = m.id
            JOIN collezione_volumi cv ON cv.id_libreria_manga = lm.id
            WHERE l.id_utente = ? AND l.tipologia = 'collezione'
            GROUP BY l.nome, m.id, m.immagine
        ";

    $stmt = $conn->prepare($sql);
    $stmt->bind_param("i", $_SESSION["id_utente"]); // Parametro per id_utente
    $stmt->execute();
    $result = $stmt->get_result();

    $collezioni = [];

    while ($row = $result->fetch_assoc()) {
        $nome = $row['nome_collezione'];
        $collezioni[$nome][] = [
            'id_manga' => $row['id_manga'],
            'immagine' => $row['immagine'],
            'volumi' => $row['volumi']
        ];
    }

    $stmt->close();

    // Debug: verifica se ci sono collezioni
    if (empty($collezioni)) {
        echo "Nessuna collezione trovata.";
    } else {
        // Genera il contenuto HTML per le collezioni
        foreach ($collezioni as $nome_collezione => $manga_list) {
            echo "<div class='sotto-collezione'>";
            echo "<h4>$nome_collezione</h4>";
            foreach ($manga_list as $manga) {
                echo "<div class='manga-item'>";
                echo "<a href='../profilo/manga.php?id=" . $manga['id_manga'] . "'>";
                echo "<img src='" . $manga['immagine'] . "' alt='Manga' style='width: 100px;'>";
                echo "</a><br>";
                echo "<small>Volumi: " . $manga['volumi'] . "</small>";
                echo "</div>";
            }
            echo "</div>";
        }
    }
?>
