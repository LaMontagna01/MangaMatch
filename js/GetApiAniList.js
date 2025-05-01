// GetApiAniList.js
export async function fetchFromAniList(query, variables) {
    const url = "https://graphql.anilist.co";

    try {
        // Invia la richiesta all'API
        const response = await fetch(url, {
            method: "POST",
            headers: {
                "Content-Type": "application/json",
                "Accept": "application/json"
            },
            body: JSON.stringify({ query, variables })
        });

        // Se la risposta non è corretta, lancia un errore
        if (!response.ok) {
            const errorText = await response.text();
            throw new Error(`Errore API AniList: ${errorText}`);
        }

        // Parse della risposta JSON
        const data = await response.json();

        // Se non ci sono dati, lancia un errore
        if (!data || !data.data) {
            throw new Error("Nessun dato restituito dall'API AniList.");
        }

        return data.data;

    } catch (error) {
        // Log dell'errore per il debug
        console.error("Errore nella richiesta API AniList:", error);

        // Restituisce null in caso di errore, per gestire la logica di errore successivamente
        return null;
    }
}
