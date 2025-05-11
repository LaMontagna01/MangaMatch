<?php
require_once("../login/conn.php");

if (!isset($_SESSION)) {
    session_start();
}

if (!isset($_SESSION["id_utente"])) {
    echo "Errore: Utente non autenticato.";
    exit;
}

    // Recupera nome libreria, immagine manga, capitolo e stato dalla libreria di lettura
    $sql = "SELECT 
                l.nome AS nome_libreria,
                m.id AS id_manga,
                m.immagine,
                GROUP_CONCAT(st.numero_capitolo ORDER BY st.numero_capitolo) AS capitoli,
                GROUP_CONCAT(st.stato ORDER BY st.numero_capitolo) AS stati
            FROM libreria l
            JOIN libreria_manga lm ON l.id = lm.id_libreria
            JOIN manga m ON lm.id_manga = m.id
            JOIN stato_lettura st ON st.id_libreria_manga = lm.id
            WHERE l.id_utente = ? AND l.tipologia = 'lettura'
            GROUP BY l.nome, m.id, m.immagine
        ";

    $stmt = $conn->prepare($sql);
    $stmt->bind_param("i", $_SESSION["id_utente"]); // Parametro per id_utente
    $stmt->execute();
    $result = $stmt->get_result();

    $letture = [];

    while ($row = $result->fetch_assoc()) {
        $nome = $row['nome_libreria'];
        $letture[$nome][] = [
            'id_manga' => $row['id_manga'],
            'immagine' => $row['immagine'],
            'capitoli' => $row['capitoli'],
            'stati' => $row['stati']
        ];
    }

    foreach ($letture as $nome_libreria => $manga_list) {
        echo "<div class='sotto-collezione'>";
        echo "<h4>$nome_libreria</h4>";
        foreach ($manga_list as $manga) {
            echo "<div class='manga-item'>";
            echo "<a href='../pagineVisualizzate/manga.php?id=" . $manga['id_manga'] . "'>";
            echo "<img src='" . $manga['immagine'] . "' alt='Manga' style='width: 100px;'>";
            echo "</a><br>";
            echo "Capitoli: " . $manga['capitoli'] . "<br>";
            echo "Stato: " . $manga['stati'] . "";
            echo "</div>";
        }
        echo "</div>";
    }

    $stmt->close();
?>