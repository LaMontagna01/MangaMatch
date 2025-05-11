document.addEventListener('DOMContentLoaded', () => {
    // Aggiorna profilo nome/cognome
    const form = document.getElementById('profiloForm');
    if (form) {
        form.addEventListener('submit', function(e) {
            e.preventDefault();

            const formData = new FormData(this);

            fetch('../profilo/aggiornaProfilo.php', {
                method: 'POST',
                body: formData
            })

            .then(response => response.text())
            .then(data => {
                document.getElementById('messaggio').innerText = data;

                if (data.trim() !== "") {
                    document.getElementById('messaggio').style.display = 'block';
                } else {
                    document.getElementById('messaggio').style.display = 'none';
                }            
            })
            .catch(error => {
                console.error('Errore:', error);
                document.getElementById('messaggio').innerText = "Errore di rete";
            });
        });
    }

    // Carica collezioni
    fetch('../profilo/caricaCollezioni.php')
        .then(response => response.text())
        .then(data => {
            document.getElementById('collezione-list').innerHTML = data;
        })
        .catch(error => {
            console.error('Errore nel caricamento collezioni:', error);
        });

    // Carica preferiti
    fetch('../profilo/caricaPreferiti.php')
        .then(response => response.text())
        .then(data => {
            document.getElementById('preferiti-list').innerHTML = data;
        })
        .catch(error => {
            console.error('Errore nel caricamento preferiti:', error);
        });

    // Carica letture
    fetch('../profilo/caricaLetture.php')
        .then(response => response.text())
        .then(data => {
            document.getElementById('letture-list').innerHTML = data;
        })
        .catch(error => {
            console.error('Errore nel caricamento letture:', error);
        });
});
