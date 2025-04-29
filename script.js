import { fetchFromAniList } from "./queryManga.js"; // Funzione per interagire con AniList
import { getMangaNarrationFromAI } from "./getMangaNarration.js";


// Funzione per recuperare i manga da AniList
async function getMangaByPreferences(genre, minScore) {
    const mangaQuery = `
        query ($genre: String, $minScore: Int) {
            Page(page: 1, perPage: 10) {
                media(
                    type: MANGA
                    genre_in: [$genre]
                    averageScore_greater: $minScore
                    sort: SCORE_DESC
                ) {
                    id
                    title {
                        romaji
                        english
                        native
                    }
                    description
                    averageScore
                    coverImage {
                        large
                    }
                }
            }
        }
    `;

    const variables = { genre, minScore };

    return await fetchFromAniList(mangaQuery, variables);
}

async function getMangaDescriptionViaJS(manga) {
    return await getMangaNarrationFromAI({
        title: manga.title.romaji,
        score: manga.averageScore
    });
}

// Funzione di gestione dell'evento di ricerca
document.getElementById("mangaForm").addEventListener("submit", async (event) => {
    event.preventDefault();

    const genre = document.getElementById("genre").value;
    const minScore = parseInt(document.getElementById("minScore").value) || 0;

    const resultDiv = document.getElementById("result");
    resultDiv.innerHTML = "Caricamento...";

    // Recupera i manga da AniList
    const mangaData = await getMangaByPreferences(genre, minScore);

    if (mangaData && mangaData.Page.media.length > 0) {
        const manga = mangaData.Page.media[0]; // Seleziona il primo manga dalla lista
        console.log(manga);

        // Ottieni la descrizione dall'AI
        const description = await getMangaDescriptionViaJS(manga);

        resultDiv.innerHTML = `
            <h2>${manga.title.romaji} (${manga.title.english || "N/A"})</h2>
            <img src="${manga.coverImage.large}" alt="Cover" width="200">
            <p><strong>Descrizione:</strong> ${description}</p>
            <p><strong>Punteggio:</strong> ${manga.averageScore}</p>
        `;
    } else {
        resultDiv.innerHTML = "Nessun manga trovato con queste preferenze.";
    }
});
