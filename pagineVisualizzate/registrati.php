<?php
require_once("../login/Conn.php");
if (!isset($_SESSION)) {
    session_start();
}

if (isset($_GET["msg"]))
    echo "<h1>" . $_GET["msg"] . "</h1>";

?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>registrati</title>


</head>
<body>
    <h1>Registrati</h1>
    <form action="../login/gestoreRegistrati.php" method="get">
        <label for="username">username: </label><input type="text" name="username" id="username">

        <label for="nome">nome: </label><input type="text" name="nome" id="nome">
        <label for="cognome">cognome: </label><input type="text" name="cognome" id="cognome">

        <label for="password">password: </label><input type="text" name="password" id="password">
        <label for="password2">conferma password: </label><input type="text" name="password2" id="password2">

        <input type="submit" value="registrati">
    </form>
</body>
</html>