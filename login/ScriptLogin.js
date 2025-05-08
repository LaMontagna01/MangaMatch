async function effettuaLogin(username, password) {
    const formData = new FormData();
    formData.append("username", username);
    formData.append("password", password);

    let response = await fetch("../login/gestoreLogin.php", {
        method: "POST",
        body: formData
    });

    let txt = await response.text();
    console.log(txt);

    let json = JSON.parse(txt);

    if (json.status === "OK") {
        alert(json.msg);
        window.location.href = "ConsiglioAI.php"; // Redirect manuale se vuoi
    } else {
        alert(json.msg);
    }
}

// Funzione per gestire la registrazione
function registrati() {
    const formData = new FormData(document.querySelector("#formRegistrazione")); // Assicurati di avere il tuo form con id "formRegistrazione"
    
    // Invia la richiesta AJAX con fetch (modificato per POST)
    fetch('../login/gestoreRegistrati.php', {  // Usa il percorso corretto
        method: 'POST', // Usa POST per inviare dati sensibili
        body: formData // Passa i dati del modulo
    })
    .then(response => response.json()) // Ricevi la risposta in formato JSON
    .then(data => {
        if (data.status === "OK") {
            // Se la registrazione è andata a buon fine, reindirizza
            window.location.href = data.redirect; // Reindirizza alla pagina index.php
        } else {
            // Se c'è un errore, mostra il messaggio di errore
            alert(data.msg);
        }
    })
    .catch(error => {
        console.error("Errore nella registrazione:", error);
    });
}



