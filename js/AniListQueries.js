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
                staff(perPage: 1, sort: [RELEVANCE, ROLE]) {
                    nodes {
                        name {
                            full
                        }
                    }
                }
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

export async function getAniListGenres() {
    const query = `
        query {
            GenreCollection
        }
    `;

    try {
        const response = await fetch("https://graphql.anilist.co", {
            method: "POST",
            headers: {
                "Content-Type": "application/json",
            },
            body: JSON.stringify({ query }),
        });

        const data = await response.json();
        return data.data.GenreCollection;
    } catch (error) {
        console.error("Errore nel recupero dei generi:", error);
        return [];
    }
}


// Funzione per chiamare PHP e ottenere i parametri di ricerca
export function searchMangaFromPHP() {
    const genres = ["action", "adventure"];
    const formats = ["manga", "novel"];
    const statuses = ["ongoing", "completed"];
    const minScore = 60;
    const maxChapters = 200;

    // Fai una richiesta AJAX al PHP per ottenere i parametri
    fetch('gestoreRicercaManga.php', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({
            genres: genres.join(","),
            formats: formats.join(","),
            statuses: statuses.join(","),
            minScore: minScore,
            maxChapters: maxChapters
        })
    })
    .then(response => response.json())
    .then(data => {
        if (data.status === "OK") {
            // Ora possiamo passare i parametri alla funzione di ricerca dei manga
            getMangaByPreferences(data.genres, data.formats, data.statuses, data.minScore, data.maxChapters)
                .then(mangaList => {
                    if (mangaList.length > 0) {
                        console.log("Manga trovato:", mangaList);
                    } else {
                        console.log("Nessun manga trovato.");
                    }
                })
                .catch(error => {
                    console.error("Errore durante la ricerca dei manga:", error);
                });
        } else {
            console.log("Errore nei parametri:", data.message);
        }
    })
    .catch(error => {
        console.error("Errore nella richiesta AJAX:", error);
    });
}
