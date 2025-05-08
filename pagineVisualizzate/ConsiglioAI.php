<?php
if (!isset($_SESSION)) {
    session_start();
}
?>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ricerca Manga</title>
    <script type="module" src="../js/script.js"></script>
</head>
<body>
    <h1>Trova un Manga</h1>

    <!-- Form di ricerca -->
    <form id="mangaForm">
        <label>Genere:</label>
        <select id="genre" multiple>
            <!-- Dinamico: verranno aggiunti i generi tramite script.js -->
        </select>
        <br>

        <label>Formato:</label>
        <select id="format">
            <option value="MANGA">Manga</option>
            <option value="NOVEL">Light Novel</option>
            <option value="ONE_SHOT">One-shot</option>
        </select>
        <br>

        <label>Status:</label>
        <select id="status">
            <option value="FINISHED">Finito</option>
            <option value="RELEASING">In Corso</option>
            <option value="NOT_YET_RELEASED">In arrivo</option>
        </select>
        <br>

        <label for="maxChapters">Capitoli massimi:</label>
        <input type="number" id="maxChapters" placeholder="Max. Capitoli" />
        <br>

        <label>Punteggio minimo:</label>
        <input type="number" id="minScore" min="0" max="100" value="0" />
        <br>

        <button type="submit">Cerca Manga</button>
    </form>

    <!-- Div per i risultati della ricerca -->
    <div id="result">
        <!-- I risultati saranno popolati tramite JavaScript -->
    </div>
</body>
</html>
