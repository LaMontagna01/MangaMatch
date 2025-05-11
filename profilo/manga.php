<?php
    require_once("../login/conn.php");

    if (isset($_GET['id'])) {
        $id_manga = $_GET['id'];

        // Query per ottenere i dettagli del manga
        $sql = "SELECT * FROM manga WHERE id = ?";
        $stmt = $conn->prepare($sql);
        $stmt->bind_param("i", $id_manga);
        $stmt->execute();
        $result = $stmt->get_result();

        if ($result->num_rows > 0) {
            $manga = $result->fetch_assoc();
            // Mostra i dettagli del manga
            echo "<h2>" . $manga['nome'] . "</h2>";
            echo "<img src='" . $manga['immagine'] . "' alt='Immagine manga'>";
            echo "<p>" . $manga['descrizione'] . "</p>";
        } else {
            echo "Manga non trovato.";
        }

        $stmt->close();
    } else {
        echo "ID manga non specificato.";
    }
?>
