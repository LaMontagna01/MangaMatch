<?php
    require_once("../login/conn.php");

    if (!isset($_SESSION)) {
        session_start();
    }

    if (!isset($_SESSION["username"])) {
        header("Location: index.php?msg=Effettua la login!");
        exit;
    }

    if (isset($_GET["msg"]))
        echo "<h2>" . $_GET["msg"] . "</h2>";

?>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Profilo</title>

        <link rel="stylesheet" href="../CSS/styleProfilo.css">
        <script src="../profilo/ScriptProfilo.js"></script>

    </head>
    <body>
        <h2>Benvenuto nel tuo Profilo
            <?php
                echo $_SESSION["username"];
            ?>
            !
        </h2>
        <h4>O almeno, nella visualizzazione delle tue librerie</h4>

        <div id="messaggio">
            
        </div>

        <form id="profiloForm">
            <input type="text" name="nome" placeholder="Nome" required><br>
            <input type="text" name="cognome" placeholder="Cognome" required><br>
            <button type="submit">Aggiorna</button>
        </form>

        <a href="ConsiglioAI.php">
            <button>Torna al consiglio</button>
        </a>

        <div class="colonne-container">
        <!-- Colonna per Collezioni -->
            <div class="colonna">
                <h3>Collezioni</h3>
                <div id="collezione-list">
                    
                </div> 
            </div>

            <!-- Colonna per Preferiti -->
            <div class="colonna">
                <h3>Preferiti</h3>
                <div id="preferiti-list">

                </div>
            </div>

            <!-- Colonna per Letture -->
            <div class="colonna">
                <h3>Letture</h3>
                <div id="letture-list">

                </div>
            </div>
        </div>

    </body>
</html>