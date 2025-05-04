    <?php
    require_once("Conn.php");

    if (!isset($_SESSION)) {
        session_start();
    }

    $password = $_GET["password"];
    $password2 = $_GET["password2"];
    $username = $_GET["username"];
    $nome = $_GET["nome"];
    $cognome = $_GET["cognome"];


    if ($password != $password2) {
        header("Location: ../pagineVisualizzate/registrati.php?msg=le password non coincidono");
        exit;
    }

    if (!isset($username) || empty($username) || !isset($password) || empty($password) || !isset($password2) || empty($password2) ||
        !isset($nome) || empty($nome) || !isset($cognome) || empty($cognome))
    {
        header("Location: ../pagineVisualizzate/registrati.php?msg=compilare tutti i campi");
        exit;
    }

    $pwdCifrata = md5($password);

    $q = "INSERT INTO utente (username, nome, cognome, password) VALUES (?, ?, ?, ?)";
    $stmt = $conn->prepare($q);
    $stmt->bind_param("ssss",$username, $nome, $cognome, $pwdCifrata);
    $stmt->execute();
    $result = $stmt->get_result();

    if($conn->error){
        header("Location: ../pagineVisualizzate/registrati.php?msg=errore nella registrazione");
        exit;
    }

    header("Location: ../pagineVisualizzate/index.php?msg=registrazione effettuata");
    exit;

?>