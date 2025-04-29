<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ricerca Manga</title>
</head>
<body>
    <h1>Trova un Manga</h1>
    <form id="mangaForm">
        <label for="genre">Genere:</label>
        <input type="text" id="genre" placeholder="E.g. Action, Romance">
        <br>

        <label for="minScore">Punteggio minimo:</label>
        <input type="number" id="minScore" placeholder="Punteggio minimo" min="0" max="100">
        <br>

        <button type="submit" id="searchBtn">Cerca Manga</button>
    </form>

    <div id="result">
        <!-- Qui verranno visualizzati i risultati -->
    </div>

    <script type="module" src="script.js"></script>
</body>
</html>
