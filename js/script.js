//script.js
import { getMangaByPreferences, getAllGenresFromAniList } from "./AniListQueries.js"; // Import delle funzioni
import { getMangaNarrationFromAI } from "./GetApiAi.js";

// Funzione per ottenere la descrizione del manga tramite AI
async function getMangaDescriptionViaJS(manga) {
    return await getMangaNarrationFromAI({
        title: manga.title.romaji,
        score: manga.averageScore
    });
}

// Funzione di gestione dell'evento di ricerca
document.getElementById("mangaForm").addEventListener("submit", async (event) => {
    event.preventDefault();

    const getMultipleValues = (id) =>
        Array.from(document.getElementById(id).selectedOptions).map(opt => opt.value);

    const genres = getMultipleValues("genre");
    const formats = getMultipleValues("format");     // es: MANGA, NOVEL
    const statuses = getMultipleValues("status");    // es: FINISHED, RELEASING
    const minScore = parseInt(document.getElementById("minScore").value) || 0;
    const maxChapters = parseInt(document.getElementById("maxChapters").value) || 10000;  // Solo capitoli massimi

    const resultDiv = document.getElementById("result");
    resultDiv.innerHTML = "Caricamento...";

    const mangaData = await getMangaByPreferences(genres, formats, statuses, minScore, maxChapters);

    if (mangaData && mangaData.Page.media.length > 0) {
        const randomIndex = Math.floor(Math.random() * mangaData.Page.media.length);
        const manga = mangaData.Page.media[randomIndex];

        // Prepara la lista dei generi
        const genresList = manga.genres ? manga.genres.join(", ") : "Nessun genere disponibile";

        const description = await getMangaDescriptionViaJS(manga);

        resultDiv.innerHTML = `
            <form action="../ConsiglioAI/gestoreAzioneConsiglioAi.php" method="post">
                <input type="hidden" name="id_manga" value="${manga.id}">
                <input type="hidden" name="titolo_manga" value="${manga.title.romaji}">
                <input type="hidden" name="autore_manga" value="${manga.staff?.nodes?.[0]?.name?.full || ''}">
                <input type="hidden" name="descrizione_manga" value="${description.replace(/(<([^>]+)>)/gi, "").replace(/"/g, "'")}">
                <input type="hidden" name="volumi_manga" value="${manga.volumes || 1000}">
                <input type="hidden" name="capitoli_manga" value="${manga.chapters || 10000}">
                <input type="hidden" name="rating_manga" value="${manga.averageScore || 0}">
                <input type="hidden" name="immagine_manga" value="${manga.coverImage.large}">

                <h2>${manga.title.romaji} (${manga.title.english || "N/A"})</h2>
                <img src="${manga.coverImage.large}" alt="Cover" width="200">
                <p><strong>Descrizione:</strong> ${description}</p>
                <p><strong>Autore:</strong> ${manga.staff?.nodes?.[0]?.name?.full || "Sconosciuto"}</p>
                <p><strong>Punteggio:</strong> ${manga.averageScore}</p>
                <p><strong>Capitoli:</strong> ${manga.chapters}</p>
                <p><strong>Generi:</strong> ${genresList}</p> 

                <button name="preferiti">Aggiungi ai preferiti</button>
            </form>

            <form action="./Librerie.php" method="post">
                <input type="hidden" name="id_manga" value="${manga.id}">
                <input type="hidden" name="titolo_manga" value="${manga.title.romaji}">
                <input type="hidden" name="autore_manga" value="${manga.staff?.nodes?.[0]?.name?.full || ''}">
                <input type="hidden" name="descrizione_manga" value="${description.replace(/(<([^>]+)>)/gi, "").replace(/"/g, "'")}">
                <input type="hidden" name="volumi_manga" value="${manga.volumes || 1000}">
                <input type="hidden" name="capitoli_manga" value="${manga.chapters || 10000}">
                <input type="hidden" name="rating_manga" value="${manga.averageScore || 0}">
                <input type="hidden" name="immagine_manga" value="${manga.coverImage.large}">

                <button name="Collezione">Aggiungi ad una collezione</button>
            </form>
        `;

    } else {
        resultDiv.innerHTML = "Nessun manga trovato con queste preferenze.";
    }
});


// Popola dinamicamente il <select> con i generi da AniList
window.addEventListener("DOMContentLoaded", async () => {
    const genreSelect = document.getElementById("genre");

    try {
        const genres = await getAllGenresFromAniList();
        console.log("Generi ricevuti:", genres); 

        if (genres && genres.length > 0) {
            genres.forEach(genre => {
                const option = document.createElement("option");
                option.value = genre;
                option.textContent = genre;
                genreSelect.appendChild(option);
            });
        } else {
            const option = document.createElement("option");
            option.textContent = "Nessun genere disponibile";
            genreSelect.appendChild(option);
        }
    } catch (error) {
        console.error("Errore durante il caricamento dei generi:", error);
        const option = document.createElement("option");
        option.textContent = "Errore nel caricamento dei generi";
        genreSelect.appendChild(option);
    }
});
