<?php
require_once("../login/conn.php");

if (!isset($_SESSION)) {
    session_start();
}

if (!isset($_SESSION["id_utente"])) {
    die('Utente non autenticato');
}

$id_utente = $_SESSION["id_utente"];

$sql_preferiti = "SELECT p.id_manga, m.immagine FROM preferiti p
                  JOIN manga m ON p.id_manga = m.id
                  WHERE p.id_utente = ?";

$stmt = $conn->prepare($sql_preferiti);
$stmt->bind_param("i", $id_utente);
$stmt->execute();
$result_preferiti = $stmt->get_result();

$preferiti = [];
while ($row = $result_preferiti->fetch_assoc()) {
    $preferiti[] = [
        'id_manga' => $row['id_manga'],
        'immagine' => $row['immagine']
    ];
}

$stmt->close();

// Output HTML per i preferiti
foreach ($preferiti as $manga) {
    echo "<a href='../profilo/manga.php?id=" . $manga['id_manga'] . "'>";
    echo "<img src='" . $manga['immagine'] . "' alt='Manga' style='width: 100px;'>";
    echo "</a>";
}
?>
