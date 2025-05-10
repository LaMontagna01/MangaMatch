<?php

if (!isset($_SESSION)) {
    session_start();
}

?>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>login</title>

        <link rel="stylesheet" href="../CSS/styleLogin.css">
        <script src="../login/ScriptLogin.js"></script>

    </head>
    <body>
        <div id="container">
            <h1>login</h1>
            <form onsubmit="event.preventDefault(); effettuaLogin(this.username.value, this.password.value);">
                <input type="text" name="username" placeholder="Username" required>
                <input type="password" name="password" placeholder="Password" required>
                <button type="submit">Login</button>
            </form>
            <br><br>

            <label>Non hai un account? </label><a href="registrati.php"> Registrati!</a><br><br>
            <label>Consulta l'AI anche senza account!  </label><a href="../ConsiglioAI.php"> Esplora!</a>
        </div>
    </body>
</html>