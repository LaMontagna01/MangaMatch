<?php
require_once("Conn.php");

if (!isset($_SESSION)) {
    session_start();
}

$username = $_GET["username"];
$password = $_GET["password"];
$passMD5 = md5($password);

if(!isset($username) || empty($username)|| !isset($password) || empty($password)){
    header("Location: ../index.php?msg=compilare tutti i campi");
    exit;
}

$q="SELECT * FROM utente where username=? AND password=?";
$stmt = $conn->prepare($q);
$stmt->bind_param("ss",$username,$passMD5);
$stmt->execute();
$result = $stmt->get_result();

if($result->num_rows==0){
    header("Location: ../index.php?msg=username o password errati");
    exit;
}
else if($result->num_rows==1){
    $row = $result->fetch_assoc();
    $_SESSION["nome"] = $row["username"];
    $_SESSION["id_utente"] = $row["id_utente"];
    //$_SESSION["ruolo"]=$row["admin"];
    header("Location: Home.php?msg=Benvenuto ".$_SESSION["nome"]);
    exit;
}
?>