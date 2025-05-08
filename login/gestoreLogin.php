<?php
session_start();
header("Content-Type: application/json");
require_once("Conn.php");

$ret = [];

// Validazione parametri POST
if (!isset($_POST["username"]) || !isset($_POST["password"])) {
    $ret["status"] = "ERR";
    $ret["msg"] = "Username e password sono obbligatori.";
    echo json_encode($ret);
    die();
}

$username = $_POST["username"];
$pasword = $_POST["password"];
$password = md5($pasword);  // Usa md5() per l'hash della password

$stmt = $conn->prepare("SELECT id_utente, username, password FROM utente WHERE username = ?");
if (!$stmt) {
    $ret["status"] = "ERR";
    $ret["msg"] = "Errore nella preparazione della query.";
    echo json_encode($ret);
    die();
}

$stmt->bind_param("s", $username);
$stmt->execute();
$result = $stmt->get_result();

if ($result->num_rows === 1) {
    $row = $result->fetch_assoc();

    // Confronta l'hash della password con quello memorizzato nel database
    if ($password === $row["password"]) {
        $_SESSION["username"] = $row["username"];
        $_SESSION["id_utente"] = $row["id_utente"];

        $ret["status"] = "OK";
        $ret["msg"] = "Login effettuato con successo.";
        echo json_encode($ret);
        die();
    } else {
        $ret["status"] = "ERR";
        $ret["msg"] = "Password non corretta.";
        echo json_encode($ret);
        die();
    }
} else {
    $ret["status"] = "ERR";
    $ret["msg"] = "Utente non trovato.";
    echo json_encode($ret);
    die();
}
?>
