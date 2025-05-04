//GetApiAI.js
const COHERE_API_KEY = "Yrvta4HoPJr3tzDtBEJQChO7iCS632leoNgLiREH"; // Crea un account e prendi la tua key

export async function getMangaNarrationFromAI(manga) {
    const prompt = `Parlami del manga "${manga.title}", con una valutazione di ${manga.score}. Descrivimi l'opera in modo appassionante e dettagliato, come se stessi consigliandola a un lettore senza annoiarlo con ripetizioni e mostrando solo parole chiavi.`;

    try {
        // Invio della richiesta all'API Cohere
        const response = await fetch("https://api.cohere.ai/v1/chat", {
            method: "POST",
            headers: {
                "Authorization": `Bearer ${COHERE_API_KEY}`,
                "Content-Type": "application/json"
            },
            body: JSON.stringify({
                model: "command-r", // Assicurati di avere accesso al modello corretto
                message: prompt,
                temperature: 0.7
            })
        });

        // Gestione della risposta
        if (!response.ok) {
            const errorText = await response.text();
            throw new Error(`Errore nella chiamata a Cohere: ${errorText}`);
        }

        // Parsing della risposta JSON
        const data = await response.json();

        // Controllo della presenza della chiave text nella risposta
        if (!data || !data.text) {
            throw new Error("Descrizione non disponibile o formato errato nella risposta.");
        }

        return data.text;  // Restituisce la descrizione generata

    } catch (error) {
        // Log dell'errore per il debug
        console.error("Errore nella richiesta a Cohere:", error);

        // Restituisce un messaggio di errore generico
        return "Errore nella descrizione generata.";
    }
}

