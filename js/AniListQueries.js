// AniListQueries.js
import { fetchFromAniList } from "./GetApiAniList.js"; // Importa la funzione per fare la richiesta API

// Funzione per ottenere i manga basati sulle preferenze
export async function getMangaByPreferences(genres = [], formats = [], statuses = [], minScore = 0, maxChapters = 10000) {
    const mangaQuery = `
        query ($genres: [String], $formats: [MediaFormat], $statuses: [MediaStatus], $minScore: Int, $maxChapters: Int) {
            Page(page: 1, perPage: 10) {
                media(
                    type: MANGA
                    genre_in: $genres
                    format_in: $formats
                    status_in: $statuses
                    averageScore_greater: $minScore
                    chapters_lesser: $maxChapters
                    sort: SCORE_DESC
                    isAdult: false
                ) {
                    id
                    title {
                        romaji
                        english
                        native
                    }
                    description
                    averageScore
                    chapters
                    genres
                    volumes
                    coverImage {
                        large
                    }
                    siteUrl
                }
            }
        }
    `;

    const variables = {
        genres,
        formats,
        statuses,
        minScore,
        maxChapters
    };

    return await fetchFromAniList(mangaQuery, variables);
}

// Funzione per ottenere i generi disponibili su AniList
export async function getAllGenresFromAniList() {
    const query = `
        query {
            GenreCollection
        }
    `;

    try {
        const data = await fetchFromAniList(query, {}); // Passiamo un oggetto vuoto perché questa query non ha variabili

        // Verifica se ci sono generi restituiti
        if (!data || !data.GenreCollection) {
            throw new Error("Nessun genere trovato.");
        }

        return data.GenreCollection;
    } catch (error) {
        // Log dell'errore per il debug
        console.error("Errore nella richiesta dei generi da AniList:", error);
        return [];
    }
}
