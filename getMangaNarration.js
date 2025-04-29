const COHERE_API_KEY = "Yrvta4HoPJr3tzDtBEJQChO7iCS632leoNgLiREH"; // crea un account e prendi la tua key

export async function getMangaNarrationFromAI(manga) {
    const prompt = `Parlami del manga "${manga.title}", con una valutazione di ${manga.score}. Descrivimi l'opera in modo appassionante e dettagliato, come se stessi consigliandola a un lettore.`;

    try {
        const response = await fetch("https://api.cohere.ai/v1/chat", {
            method: "POST",
            headers: {
                "Authorization": `Bearer ${COHERE_API_KEY}`,
                "Content-Type": "application/json"
            },
            body: JSON.stringify({
                model: "command-r",
                message: prompt,
                temperature: 0.7
            })
        });

        if (!response.ok) {
            console.error("Errore chiamata Cohere:", response.statusText);
            return "Errore nella descrizione generata.";
        }

        const data = await response.json();
        return data.text ?? "Descrizione non disponibile.";
    } catch (error) {
        console.error("Errore fetch:", error);
        return "Errore nella descrizione generata.";
    }
}
