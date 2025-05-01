<?php
require_once("Conn.php");
if (!isset($_SESSION)) {
    session_start();
}

if (isset($_GET["msg"]))
    echo "<h2>" . $_GET["msg"] . "</h2>";

?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>login</title>

</head>
<body>
    <div id="container">
    <h1>login</h1>
    <form action="gestoreLogin.php" method="get">
        <label for="username">username </label><input type="text" name="username" id="username">
        <label for="password">password </label><input type="password" name="password" id="password">

    <input type="submit" value="login">
    </form> <br><br>

    <label>Non hai un account? </label><a href="registrati.php"> Registrati!</a><br><br>
    <label>Consulta l'AI anche senza account!  </label><a href="../ConsiglioAI.php"> Esplora!</a>
</div>
</body>
</html>