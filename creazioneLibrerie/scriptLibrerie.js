// Funzione generica per inviare i dati tramite AJAX
function inviaDatiAjax(url, formData, onSuccess, onError) {
    var xhr = new XMLHttpRequest();
    xhr.open('POST', url, true);

    // Gestisce la risposta
    xhr.onload = function () {
        if (xhr.status === 200) {
            var response = JSON.parse(xhr.responseText);
            if (response.success) {
                onSuccess(response);  // Passa la risposta al callback onSuccess
            } else {
                onError(response);  // Passa la risposta al callback onError
            }
        } else {
            onError({ error: "Errore nella richiesta AJAX!" });
        }
    };

    // Gestisce errori di rete
    xhr.onerror = function () {
        onError({ error: "Errore nella richiesta AJAX!" });
    };

    // Invia i dati
    xhr.send(formData);
}

// Funzione per gestire la selezione del tipo di azione (crea nuova libreria o seleziona libreria esistente)
function showFormOptions() {
    var selectType = document.getElementById('tipologia').value;
    var volumiSelect = document.getElementById('volumiSelect');
    var capitoloSelect = document.getElementById('capitoloSelect');
    var statoSelect = document.getElementById('statoSelect');
    var action = document.getElementById('action').value;
    var creaLibreriaForm = document.getElementById('creaLibreriaForm');
    var selezionaLibreriaForm = document.getElementById('selezionaLibreriaForm');
    var libreriaSelect = document.getElementById('libreria');

    // Mostra il form in base all'azione selezionata
    volumiSelect.style.display = 'none';
    capitoloSelect.style.display = 'none';
    statoSelect.style.display = 'none';
    document.getElementById('volumi').required = false;
    document.getElementById('capitolo').required = false;
    document.getElementById('stato').required = false;
    
    if(action === "crea"){
        document.getElementById('nome').required = true;
        creaLibreriaForm.style.display = 'block';  
        selezionaLibreriaForm.style.display = 'none'; 

        if(selectType === "collezione"){
            volumiSelect.style.display = 'block';
            document.getElementById('volumi').required = true;
            capitoloSelect.style.display = 'none';
            statoSelect.style.display = 'none';
        }
        else if(selectType === "lettura"){
            capitoloSelect.style.display = 'block';
            statoSelect.style.display = 'block';
            volumiSelect.style.display = 'none';
            document.getElementById('capitolo').required = true;
            document.getElementById('stato').required = true;
        }
    }
    else if(action === "seleziona"){
        document.getElementById('nome').required = false;
        document.getElementById('tipologia').required = false;
        creaLibreriaForm.style.display = 'none';
        selezionaLibreriaForm.style.display = 'block';
        libreriaSelect.required = true;

        if(selectTypeLibreria === "Collezione"){
            volumiSelect.style.display = 'block';
            capitoloSelect.style.display = 'none';
            statoSelect.style.display = 'none';
            document.getElementById('volumi').required = true;
            document.getElementById('capitolo').required = false;
            document.getElementById('stato').required = false;
        }
        else if(selectTypeLibreria === "Lettura"){
            capitoloSelect.style.display = 'block';
            statoSelect.style.display = 'block';
            volumiSelect.style.display = 'none';
            document.getElementById('volumi').required = false;
            document.getElementById('capitolo').required = true;
            document.getElementById('stato').required = true;
        }
    }

}

// Funzione per inviare i dati della libreria tramite AJAX
function inviaDatiLibreria() {
    var formData = new FormData(document.querySelector('form'));  // Preleva tutti i dati del form

    inviaDatiAjax(
        '../actions/gestoreLibrerie.php', 
        formData, 
        function(response) {
            console.log(response);  // Log per il successo
            alert(response.success || 'Operazione completata!');
        }, 
        function(response) {
            console.log(response);  // Log per l'errore
            alert(response.error || 'Errore nel salvataggio dei dati!');
        }
    );
}

// Funzione per aggiungere un manga ai preferiti tramite AJAX
async function aggiungiAiPreferiti(mangaId) {
    const formData = new FormData();
    formData.append("id_manga", mangaId);

    try {
        // Invio della richiesta AJAX con i dati
        const response = await fetch("../creazioneLibrerie/aggiungiAiPreferiti.php", {
            method: "POST",
            body: formData
        });
        const data = await response.json();

        if (data.success) {
            alert(data.success); // Mostra messaggio di successo
        } else {
            alert(data.error); // Mostra messaggio di errore
        }
    } catch (error) {
        console.error("Errore durante l'aggiunta ai preferiti:", error);
        alert("Errore durante l'aggiunta ai preferiti!");
    }
}

// Funzione per aggiungere un manga tramite AJAX
function aggiungiManga(idManga, titolo, autore, descrizione, volumi, capitoli, rating, immagine) {
    var formData = new FormData();
    formData.append("id_manga", idManga);
    formData.append("titolo_manga", titolo);
    formData.append("autore_manga", autore);
    formData.append("descrizione_manga", descrizione);
    formData.append("volumi_manga", volumi);
    formData.append("capitoli_manga", capitoli);
    formData.append("rating_manga", rating);
    formData.append("immagine_manga", immagine);

    inviaDatiAjax(
        '../actions/aggiungiManga.php',
        formData,
        function(response) {
            alert(response.success);  // Mostra un messaggio di successo
        },
        function(response) {
            alert(response.error);  // Mostra un messaggio di errore
        }
    );
}

// Aggiungi un listener per il bottone di aggiunta ai preferiti
document.getElementById("aggiungiPreferitoButton").addEventListener("click", function() {
    var idManga = this.getAttribute("data-id-manga");
    aggiungiAiPreferiti(idManga);  // Chiama la funzione AJAX per aggiungere ai preferiti
});

// Intercetta l'invio di qualsiasi form
document.addEventListener("submit", function(e) {
    // Verifica se il form contiene un pulsante con nome 'preferiti'
    const form = e.target;
    if (form.querySelector("button[name='preferiti']")) {
        inviaPreferiti(e, form);  // Chiama la funzione per inviare i dati
    }
});
