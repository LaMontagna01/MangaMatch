<?php
require_once("Conn.php");

if (!isset($_SESSION)) {
    session_start();
}

$password = $_GET["password"];
$password2 = $_GET["password2"];
$nome = $_GET["nome"];
$cognome = $_GET["cognome"];


if ($password != $password2) {
    header("Location: registrati.php?msg=le password non coincidono");
    exit;
}

if (!isset($password) || empty($password) || !isset($password2) || empty($password2) ||
    !isset($nome) || empty($nome) || !isset($cognome) || empty($cognome))
{
    header("Location: registrati.php?msg=compilare tutti i campi");
    exit;
}

$pwdCifrata = md5($password);

$q = "INSERT INTO utente (nome, cognome, password) VALUES (?, ?, ?)";
$stmt = $conn->prepare($q);
$stmt->bind_param("ss",$username, $cognome, $pwdCifrata);
$stmt->execute();
$result = $stmt->get_result();

if($conn->error){
    header("Location: registrati.php?msg=errore nella registrazione");
    exit;
}

header("Location: login/index.php?msg=registrazione effettuata");
exit;

?>