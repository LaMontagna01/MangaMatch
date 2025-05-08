<?php
// gestoreRicercaManga.php

header('Content-Type: application/json');

// Controlla che i parametri siano stati ricevuti correttamente
if (
    isset($_POST['genres']) &&
    isset($_POST['formats']) &&
    isset($_POST['statuses']) &&
    isset($_POST['minScore']) &&
    isset($_POST['maxChapters'])
) {
    $genres = explode(",", $_POST['genres']);
    $formats = explode(",", $_POST['formats']);
    $statuses = explode(",", $_POST['statuses']);
    $minScore = intval($_POST['minScore']);
    $maxChapters = intval($_POST['maxChapters']);

    // Restituisci i parametri come JSON per il client
    echo json_encode([
        'status' => 'OK',
        'genres' => $genres,
        'formats' => $formats,
        'statuses' => $statuses,
        'minScore' => $minScore,
        'maxChapters' => $maxChapters
    ]);
} else {
    echo json_encode([
        'status' => 'INVALID',
        'message' => 'Parametri mancanti.'
    ]);
}
?>
