<?php
require_once("../login/Conn.php");
if (!isset($_SESSION)) {
    session_start();
}


?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>registrati</title>

    <script src="../login/ScriptLogin.js"></script>

</head>
<body>
    <h1>Registrati</h1>

    <div id="error-message"></div>
    
    <form id="formRegistrazione" onsubmit="event.preventDefault(); registrati();">
        <label for="username">Username:</label>
        <input type="text" name="username" required>
        <br>
        <label for="nome">Nome:</label>
        <input type="text" name="nome" required>
        <br>
        <label for="cognome">Cognome:</label>
        <input type="text" name="cognome" required>
        <br>
        <label for="password">Password:</label>
        <input type="password" name="password" required>
        <br>
        <label for="password2">Conferma Password:</label>
        <input type="password" name="password2" required>
        <br>
        <button type="submit">Registrati</button>
    </form>

</body>
</html>