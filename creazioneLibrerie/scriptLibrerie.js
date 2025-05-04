function showFormOptions() {
    var selectType = document.getElementById('tipologia').value;
    var volumiSelect = document.getElementById('volumiSelect');
    var capitoloSelect = document.getElementById('capitoloSelect');
    var statoSelect = document.getElementById('statoSelect');
    var action = document.getElementById('action').value;
    var creaLibreriaForm = document.getElementById('creaLibreriaForm');
    var selezionaLibreriaForm = document.getElementById('selezionaLibreriaForm');
    var libreriaSelect = document.getElementById('libreria');

    // Reset required
    libreriaSelect.required = false;

    document.getElementById('volumi').required = false;
    document.getElementById('capitolo').required = false;
    document.getElementById('stato').required = false;


    volumiSelect.style.display = 'none';
    capitoloSelect.style.display = 'none';
    statoSelect.style.display = 'none';

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

        //cambiare controllo perchè guarda DB e non opzioni html
        const selectedOption = libreriaSelect.options[libreriaSelect.selectedIndex];
        const selectTypeLibreria = selectedOption.getAttribute('data-tipologia');

        document.getElementById('id_libreria_selezionata').value = libreriaSelect.value;

        
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
        else{
            volumiSelect.style.display = 'none';
            capitoloSelect.style.display = 'none';
            statoSelect.style.display = 'none';

            document.getElementById('volumi').required = false;
            document.getElementById('capitolo').required = false;
            document.getElementById('stato').required = false;
        }
    }
}

document.querySelector("form").onsubmit = function() {
    var libreriaValue = document.getElementById("libreria").value;
    if (libreriaValue === "") {
        alert("Devi selezionare una libreria.");
        return false;  // Impedisce l'invio del form se non selezionata una libreria
    }
    return true;  // Procede con l'invio del form
};
