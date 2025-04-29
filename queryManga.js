export async function fetchFromAniList(query, variables) {
  const url = "https://graphql.anilist.co";

  try {
      const response = await fetch(url, {
          method: "POST",
          headers: {
              "Content-Type": "application/json",
              "Accept": "application/json"
          },
          body: JSON.stringify({ query, variables })
      });

      if (!response.ok) {
          const errorText = await response.text();
          throw new Error(`Errore API AniList: ${errorText}`);
      }

      const data = await response.json();
      return data.data;
  } catch (error) {
      console.error("Errore nella richiesta API:", error);
      return null;
  }
}
