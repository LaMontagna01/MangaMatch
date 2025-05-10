document.addEventListener("DOMContentLoaded", function () {
    document.getElementById("action").addEventListener("change", showFormOptions);
    document.getElementById("tipologia").addEventListener("change", showFormOptions);
    document.getElementById("libreria").addEventListener("change", showFormOptions);
});

// Gestisce la visualizzazione dinamica dei campi in base alla scelta dell'utente
function showFormOptions() {
    const selectType = document.getElementById('tipologia').value;
    const volumiSelect = document.getElementById('volumiSelect');
    const capitoloSelect = document.getElementById('capitoloSelect');
    const statoSelect = document.getElementById('statoSelect');
    const action = document.getElementById('action').value;
    const creaLibreriaForm = document.getElementById('creaLibreriaForm');
    const selezionaLibreriaForm = document.getElementById('selezionaLibreriaForm');
    const libreriaSelect = document.getElementById('libreria');
    const idLibreriaSelect = document.getElementById('id_libreria_selezionata'); // Campo da gestire

    // Nasconde tutti i campi dinamici e resetta i required
    volumiSelect.style.display = 'none';
    capitoloSelect.style.display = 'none';
    statoSelect.style.display = 'none';
    document.getElementById('volumi').required = false;
    document.getElementById('capitolo').required = false;
    document.getElementById('stato').required = false;

    // Gestione dei campi per creare una nuova libreria
    if (action === "crea") {
    document.getElementById('nome').required = true;
    creaLibreriaForm.style.display = 'block';
    selezionaLibreriaForm.style.display = 'none';

    selezionaLibreriaForm.required = false;
    selezionaLibreriaForm.disabled = true;

    idLibreriaSelect.required = false;
    idLibreriaSelect.disabled = true; // ✅ disabilita il campo nascosto

    if (selectType === "Collezione") {
        volumiSelect.style.display = 'block';
        document.getElementById('volumi').required = true;
    } else if (selectType === "Lettura") {
        capitoloSelect.style.display = 'block';
        statoSelect.style.display = 'block';
        document.getElementById('capitolo').required = true;
        document.getElementById('stato').required = true;
    }
}
else if (action === "seleziona") {
    document.getElementById('nome').required = false;
    document.getElementById('tipologia').required = false;
    creaLibreriaForm.style.display = 'none';
    selezionaLibreriaForm.style.display = 'block';

    selezionaLibreriaForm.required = true;
    selezionaLibreriaForm.disabled = false;

    idLibreriaSelect.required = true;
    idLibreriaSelect.disabled = false; // ✅ riabilita il campo solo se serve

    const selectedOption = libreriaSelect.options[libreriaSelect.selectedIndex];
    const selectTypeLibreria = selectedOption.getAttribute("data-tipologia");

    if (selectTypeLibreria === "Collezione") {
        volumiSelect.style.display = 'block';
        document.getElementById('volumi').required = true;
    } else if (selectTypeLibreria === "Lettura") {
        capitoloSelect.style.display = 'block';
        statoSelect.style.display = 'block';
        document.getElementById('capitolo').required = true;
        document.getElementById('stato').required = true;
    }
}

}


// Aggiunge un manga ai preferiti senza AJAX (submit tradizionale)
function aggiungiAiPreferiti(mangaId) {
    const form = document.createElement("form");
    form.method = "POST";
    form.action = "../creazioneLibrerie/aggiungiAiPreferiti.php";

    const input = document.createElement("input");
    input.type = "hidden";
    input.name = "id_manga";
    input.value = mangaId;
    form.appendChild(input);

    document.body.appendChild(form);
    form.submit();
}
