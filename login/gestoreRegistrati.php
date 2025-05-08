<?php
require_once("../login/Conn.php");

if (!isset($_SESSION)) {
    session_start();
}

$ret = [];

// Ricevi i dati inviati via POST
$password = $_POST["password"];
$password2 = $_POST["password2"];
$username = $_POST["username"];
$nome = $_POST["nome"];
$cognome = $_POST["cognome"];

// Verifica se le password coincidono
if ($password != $password2) {
    $ret["status"] = "ERR";
    $ret["msg"] = "Le password non coincidono.";
    echo json_encode($ret);
    exit;
}

// Verifica se tutti i campi sono stati compilati
if (empty($username) || empty($password) || empty($password2) || empty($nome) || empty($cognome)) {
    $ret["status"] = "ERR";
    $ret["msg"] = "Compilare tutti i campi.";
    echo json_encode($ret);
    exit;
}

// Cifra la password con md5()
$pwdCifrata = md5($password);

// Inserisci l'utente nel database
$q = "INSERT INTO utente (username, nome, cognome, password) VALUES (?, ?, ?, ?)";
$stmt = $conn->prepare($q);
$stmt->bind_param("ssss", $username, $nome, $cognome, $pwdCifrata);
$stmt->execute();

// Verifica se ci sono errori nell'inserimento
if ($conn->error) {
    $ret["status"] = "ERR";
    $ret["msg"] = "Errore nella registrazione.";
    echo json_encode($ret);
    exit;
}

// Risposta di successo
$ret["status"] = "OK";
$ret["msg"] = "Registrazione effettuata con successo.";
$ret["redirect"] = "../pagineVisualizzate/index.php"; // URL per il reindirizzamento
echo json_encode($ret);
exit;
?>
