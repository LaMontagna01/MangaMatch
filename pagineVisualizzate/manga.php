<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manga</title>
    <script src="../creazioneLibrerie/scriptLibrerie.js"></script>
    <link rel="stylesheet" href="../CSS/styleManga.css">
</head>
<body>
    <?php
    require_once("../login/conn.php");

    if (isset($_GET['id'])) {
        $id_manga = $_GET['id'];

        $sql = "SELECT * FROM manga WHERE id = ?";
        $stmt = $conn->prepare($sql);
        $stmt->bind_param("i", $id_manga);
        $stmt->execute();
        $result = $stmt->get_result();

        if ($result->num_rows > 0) {
            $manga = $result->fetch_assoc();
            ?>

            <div class="container">
                <h1 class="manga-title"><?php echo $manga['nome']; ?></h1>

                <div class="manga-details">
                    <div class="manga-image">
                        <img src="<?php echo $manga['immagine']; ?>" alt="Immagine manga">
                    </div>
                    <div class="manga-description">
                        <p><?php echo $manga['descrizione']; ?></p>
                    </div>
                </div>

                <div class="manga-info">
                    <span><strong>Autore:</strong> <?php echo $manga['autore']; ?></span>
                    <span><strong>Volumi:</strong> <?php echo $manga['volumi']; ?></span>
                    <span><strong>Capitoli:</strong> <?php echo $manga['capitoli']; ?></span>
                    <span><strong>Rating:</strong> <?php echo $manga['rating']; ?></span>
                </div>

                <div class="manga-buttons">
                    <button onclick="aggiungiAiPreferiti(<?php echo $id_manga; ?>)">Aggiungi ai preferiti</button>
                    <button onclick="rimuoviDaiPreferiti(<?php echo $id_manga; ?>)">Rimuovi dai preferiti</button>
                </div>
            </div>

            <?php
        } else {
            echo "<p class='error'>Manga non trovato.</p>";
        }

        $stmt->close();
    } else {
        echo "<p class='error'>ID manga non specificato.</p>";
    }
    ?>
</body>
</html>
