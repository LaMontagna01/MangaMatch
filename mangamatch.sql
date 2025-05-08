-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Creato il: Mag 09, 2025 alle 01:03
-- Versione del server: 10.4.32-MariaDB
-- Versione PHP: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `mangamatch`
--

-- --------------------------------------------------------

--
-- Struttura della tabella `collezione_volumi`
--

CREATE TABLE `collezione_volumi` (
  `id` int(11) NOT NULL,
  `id_libreria_manga` int(11) DEFAULT NULL,
  `numero_volume` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `collezione_volumi`
--

INSERT INTO `collezione_volumi` (`id`, `id_libreria_manga`, `numero_volume`) VALUES
(110, 25, 1),
(111, 25, 2),
(112, 25, 3),
(113, 26, 1),
(114, 27, 2),
(115, 27, 4),
(116, 39, 1),
(117, 39, 3),
(118, 40, 1),
(119, 40, 2),
(120, 41, 3),
(121, 41, 4);

-- --------------------------------------------------------

--
-- Struttura della tabella `libreria`
--

CREATE TABLE `libreria` (
  `id` int(11) NOT NULL,
  `id_utente` int(11) NOT NULL,
  `nome` varchar(30) NOT NULL,
  `tipologia` enum('Collezione','Lettura','','') NOT NULL,
  `descrizione` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `libreria`
--

INSERT INTO `libreria` (`id`, `id_utente`, `nome`, `tipologia`, `descrizione`) VALUES
(10, 1, 'Prova', 'Collezione', '<zasas'),
(13, 1, 'sdsedrtg', 'Lettura', 'assdf'),
(14, 2, 'froci', 'Lettura', 'very good'),
(15, 1, 'palle', 'Collezione', 'pelose'),
(16, 2, 'ciaooooooo', 'Collezione', 'tetetatsugasas'),
(17, 3, 'Prova', 'Collezione', 'prova'),
(18, 3, 'prova 2', 'Lettura', 'prova 2');

-- --------------------------------------------------------

--
-- Struttura della tabella `libreria_manga`
--

CREATE TABLE `libreria_manga` (
  `id` int(11) NOT NULL,
  `id_libreria` int(11) DEFAULT NULL,
  `id_manga` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `libreria_manga`
--

INSERT INTO `libreria_manga` (`id`, `id_libreria`, `id_manga`) VALUES
(25, 15, 41054),
(26, 15, 85464),
(27, 10, 114998),
(36, 13, 33572),
(37, 13, 37375),
(38, 14, 30429),
(39, 16, 97553),
(40, 17, 30651),
(41, 17, 30081),
(42, 18, 31706),
(43, 18, 85189);

-- --------------------------------------------------------

--
-- Struttura della tabella `manga`
--

CREATE TABLE `manga` (
  `id` int(11) NOT NULL,
  `nome` varchar(40) DEFAULT NULL,
  `autore` varchar(40) DEFAULT NULL,
  `descrizione` text DEFAULT NULL,
  `volumi` int(11) DEFAULT NULL,
  `capitoli` int(11) DEFAULT NULL,
  `rating` int(11) DEFAULT NULL,
  `immagine` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `manga`
--

INSERT INTO `manga` (`id`, `nome`, `autore`, `descrizione`, `volumi`, `capitoli`, `rating`, `immagine`) VALUES
(30003, '20 Seiki Shounen', 'Naoki Urasawa', '\'20 Seiki Shounen\' è un manga eccezionale che ti trascinerà in un viaggio nel tempo fino agli anni \'20 del Novecento, in un\'epoca di grandi cambiamenti e scoppiettanti rivoluzioni. Con un punteggio di 88 su 100, questo gioiello narrativo ti lascerà senza fiato! La storia segue le vicende di un giovane di nome Mikami, che si ritrova improvvisamente catapultato nell\'era Taisho, precisamente nel 1921. Smarrito in un\'epoca così lontana dalla sua, Mikami cerca di orientarsi in questo nuovo mondo che gli si apre davanti, scoprendo la ricca cultura e le tradizioni del Giappone dei primi anni del XX secolo. Ma non è tutto: il nostro protagonista scoprirà ben presto di avere un legame speciale con questo periodo storico e la sua missione è quella di proteggere la democrazia nascente e guidare la gente verso un futuro migliore.\r\n\r\nIl manga è una vera e propria celebrazione della storia giapponese, con i suoi eventi e i suoi personaggi storici che prendono vita nelle mani abili dell\'autore. Attraverso gli occhi di Mikami, noi lettori sperimentiamo le stesse sensazioni di smarrimento, meraviglia e scoperta in questo viaggio a ritroso nel tempo. Ogni capitolo è una nuova avventura, un nuovo mistero da svelare, un pezzo del puzzle che compone la complessa trama storica. La narrazione è avvincente e coinvolgente, capace di tenere il lettore incollato alle pagine con un mix perfetto di azione, suspense e riflessione.\r\n\r\nI disegni sono un vero spettacolo per gli occhi. I dettagli accurati e le ambientazioni curate rendono ogni scena viva e realistica, come se fossimo noi stessi nella Tokyo degli anni \'20. I personaggi sono disegnati con altrettanta precisione, caratterizzati da un design unico e facilmente riconoscibile. Lo stile grafico è una vera opera d\'arte, che cattura l\'essenza dell\'epoca con un tocco moderno che rende il manga accessibile e godibile a ogni tipo di lettore.\r\n\r\nMa \'20 Seiki Shounen\' non è solo un viaggio nel tempo: è un inno alla speranza e al coraggio, un invito a credere nel potere dell\'individuo di fare la differenza. Mikami, con la sua determinazione e la sua curiosità, diventa un simbolo di resistenza e cambiamento, un\'ispirazione per chiunque si trovi di fronte a sfide apparentemente insormontabili. Attraverso le sue vicende, l\'opera ricorda l\'importanza di lottare per i propri ideali e di non arrendersi mai.\r\n\r\nSe sei alla ricerca di un\'avventura emozionante, ricca di storia e di significato, \'20 Seiki Shounen\' è il manga che fa per te. Lasciati travolgere dalla passione e dallo stupore di questo straordinario viaggio nel tempo, e scopri le meraviglie di un\'epoca passata insieme a un protagonista indimenticabile. Non rimarrai deluso!', 22, 249, 88, 'https://s4.anilist.co/file/anilistcdn/media/manga/cover/medium/bx30003-E84fwIh22LAQ.jpg'),
(30008, 'Full Moon wo Sagashite', 'Arina Tanemura', '\'Full Moon wo Sagashite\' è un manga shoujo che ti catturerà con la sua storia emozionante e unica. Con un punteggio di 76, questo gioiello creato da Arina Tanemura segue le vicende di Mitsuki, una ragazza dal cuore spezzato che nasconde un segreto: ha un tumore alle corde vocali che le impedisce di realizzare il suo sogno di diventare una cantante. Ma la sua vita cambia quando incontra due affascinanti shinigami, che le propongono un patto che potrebbe cambiare per sempre il suo destino. \r\n\r\nParliamo di un\'opera magica e romantica, che unisce il tema della musica a quello del viaggio nel tempo, con un tocco di mitologia giapponese. La protagonista, Mitsuki, è una ragazza coraggiosa e determinata, che lotta per realizzare il suo sogno nonostante le difficoltà. Il suo desiderio di cantare è così forte che la porterà a stringere un accordo con le divine entità della morte, che le concederanno un\'opportunità unica.\r\n\r\nI disegni sono meravigliosi e ricchi di dettagli, con uno stile caratteristico che rende ogni personaggio memorabile. La trama si sviluppa in modo coinvolgente, bilanciando perfettamente momenti commoventi, divertenti e adrenalinici. Le tematiche affrontate sono profonde e attuali, e toccano il cuore dei lettori di tutte le età. La storia d\'amore, il coraggio di seguire i propri sogni e il valore dell\'amicizia sono solo alcuni degli aspetti che rendono questa opera così speciale. \r\n\r\nCon un mix perfetto di fantasy, romanticismo e musica, \'Full Moon wo Sagashite\' è una lettura imperdibile per gli appassionati di manga che cercano una storia emozionante, fresca e originale. La passione per la musica, il mistero dei viaggi nel tempo e l\'amore puro renderanno ogni pagina indimenticabile. Un\'opera che lascerà il segno nel tuo cuore, con un messaggio potente e positivo. Da leggere assolutamente!', 7, 42, 76, 'https://s4.anilist.co/file/anilistcdn/media/manga/cover/medium/bx30008-gETc2OY1tby1.jpg'),
(30025, 'Hagane no Renkinjutsushi', 'Hiromu Arakawa', '\'Hagane no Renkinjutsushi\' è un manga straordinario che ti trascinerà in un mondo di alchimia e avventura! Con un punteggio di 89, questo gioiello del fumetto giapponese merita sicuramente un posto nella tua lista di letture. La storia segue le vicende di Edward e Alphonse Elric, due fratelli che hanno subito una terribile tragedia nella loro infanzia. Determinati a riportare in vita la loro madre defunta, i due ragazzi si avventurano nel mondo dell\'alchimia, un campo mistico e pericoloso che consente loro di manipolare la materia di base per creare oggetti e esseri viventi. Ma quando il loro primo tentativo di resurrezione finisce in un disastro, Edward perde una gamba e Alphonse il suo intero corpo! Per salvarli, Edward sacrifica il suo braccio destro per sigillare l\'anima del fratello in una corazza. \r\n\r\nDa questo momento in poi, i due fratelli sono legati l\'uno all\'altro in un modo unico e indissolubile. Edward, ora noto come \'Fullmetal Alchemist\', si impegna in un viaggio epico per trovare il leggendario \'Svero della Pietra Filosofale\', l\'unico oggetto in grado di riportare i loro corpi alla normalità. La loro ricerca li porta in un viaggio attraverso un paese dilaniato dalla guerra, dove incontrano una varietà di personaggi affascinanti e bizzarri, tra cui un\'enigmatica alchimista di nome Roy Mustang, il cui potere di manipolare il fuoco lo rende temuto e rispettato. Insieme ai loro nuovi alleati, Edward e Alphonse scoprono presto che c\'è molto di più nella ricerca della Pietra Filosofale di quanto avessero immaginato, e i segreti che svelano hanno il potenziale per cambiare il destino del loro mondo. \r\n\r\nIl manga è una vera e propria montagna russa di emozioni, con momenti di intensa azione, commoventi scene di riflessione e momenti divertenti che ti faranno ridere a crepapelle. I personaggi sono profondi e ben sviluppati, con le loro motivazioni e conflitti interiori che li rendono incredibilmente realistici e accattivanti. L\'autore, Arakawa Hiromu, ha un talento incredibile nel creare un mondo così ricco di dettagli e di personaggi unici, che ti lascerà a desiderare di esplorare ogni angolo di questo affascinante universo. Il disegno è stupendo, con un\'attenzione ai dettagli e una progettazione dei personaggi che rende ogni tavola una vera opera d\'arte. Le battaglie epiche e le scene di combattimento sono coreografate in modo spettacolare, ensuring che ogni pagina sia un piacere per gli occhi. \r\n\r\nCon una trama intricata e piena di colpi di scena, \'Hagane no Renkinjutsushi\' ti terrà incollato alle pagine, desideroso di scoprire cosa accadrà ai fratelli Elric nel loro periloso viaggio. La storia tocca temi profondi come la famiglia, il sacrificio e la natura della guerra, senza mai essere pesante o noiosa. L\'equilibrio perfetto tra azione, commedia e riflessione rende questo manga adatto a chiunque, indipendentemente dai gusti. Preparati a farti rapire da questo mondo di alchimia e avventura, e non vedrai l\'ora di immergerti nella prossima avventura di Edward e Alphonse!', 27, 116, 89, 'https://s4.anilist.co/file/anilistcdn/media/manga/cover/medium/bx30025-mpPVpCKFTowt.png'),
(30081, 'ARIA', 'Kozue Amano', '\'ARIA\' è un manga che ti trascinerà in un viaggio incantevole e ipnotico nel futuro distopico di Marte, che ora è stato trasformato in un pianeta idilliaco grazie agli sforzi dell\'umanità. Con un punteggio di 86 su MyAnimeList, questo gioiello del genere slice of life ti porterà in un mondo dove la bellezza della natura e la pace interiore sono i veri protagonisti.\r\n\r\nLa storia si concentra su Akari, una ragazza che si trasferisce sulla superficie marziana per realizzare il suo sogno di diventare una \'undine\', una guida turistica che naviga sulle acque serene del pianeta rosso. Insieme alle sue amiche Aika e Alice, Akari esplora il misterioso e affascinante mondo di Neo-Venezia, una città che ricorda la leggendaria Venezia sulla Terra.\r\n\r\nIl manga è una serie di momenti intensi e toccanti, mentre seguiamo Akari mentre impara il difficile ma gratificante lavoro di undine. Ogni capitolo è una nuova avventura, un nuovo incontro, una nuova lezione di vita che Akari scopre con occhi pieni di meraviglia. La sua gioia e il suo entusiasmo per il mondo che la circonda sono contagiosi, e non potrai fare a meno di farti trascinare nella sua avventura.\r\n\r\nI disegni di Kozue Amano sono semplicemente stupendi. Le pagine di \'ARIA\' si animano con paesaggi mozzafiato di Marte, ora un pianeta ricoperto di verde e blu, con cieli che ti lasciano senza fiato. Le scene serene dell\'acqua che scorre e dei canali di Neo-Venezia sono ipnotizzanti, e le espressioni e le emozioni dei personaggi sono rese con una delicatezza e una profondità che ti faranno venire i brividi.\r\n\r\nLa trama si sviluppa in modo lento e delizioso, permettendoti di assaporare ogni momento e di affezionarti ai personaggi mentre crescono e si evolvono. La narrazione è arricchita da un cast secondario altrettanto affascinante, come le simpatiche e stravaganti proprietarie del negozio di gatti o i misteriosi e saggi \'Ex-Machina\'. Ogni personaggio porta con sé una storia unica e affascinante che si intreccia con quella di Akari e delle sue amiche.\r\n\r\nMa \'ARIA\' non è solo un manga su una ragazza e il suo sogno in un mondo fantastico. È una celebrazione della bellezza della natura, dell\'amicizia e della pace interiore che si può trovare in momenti di quiete. Ogni capitolo è una pausa rilassante dalla frenesia della vita quotidiana, un invito a rallentare e apprezzare la bellezza che ci circonda.\r\n\r\nSe sei alla ricerca di una lettura che ti porti via in un viaggio incantevole, che ti lasci a bocca aperta con i suoi disegni stupendi e che ti tocchi il cuore con le sue storie emozionanti, \'ARIA\' è la scelta perfetta. Lasciati incantare da questo gioiello e scopri perché questo manga è così altamente stimato da chiunque lo legga!', 12, 67, 86, 'https://s4.anilist.co/file/anilistcdn/media/manga/cover/medium/bx30081-oCRaPkTGq4vP.jpg'),
(30429, 'Sugar Sugar Rune', 'Moyoco Anno', '\'Sugar Sugar Rune\' è un manga magico e incantevole che ti trascinerà in un mondo di sogno e fantasia! Con un punteggio di 76, questo fumetto è una perla rara che non puoi assolutamente perderti. La storia segue le avventure di due streghe, Chocolate e Vanilla, che provengono dal Regno della Magia e sono in competizione per il titolo di Regina della Magia. Con i loro dolci incantesimi e le loro abilità uniche, queste due ragazze ci mostrano un mondo dove la magia è reale e il destino del loro regno è nelle loro mani.  Il manga è una mix perfetto di fantasy, commedia e avventura, con un tocco di romanticismo che renderà il tuo cuore più leggero. I disegni sono stupendi e ricchi di dettagli, con uno stile che ricorda i sogni d\'infanzia più dolci. I personaggi sono accattivanti e ben sviluppati, con le loro personalità uniche e le loro storie che ti terranno incollato alle pagine.  Ma \'Sugar Sugar Rune\' non è solo un\'avventura magica, è anche un viaggio di scoperta di sé e dell\'amicizia. Chocolate e Vanilla impareranno che il vero potere della magia sta nella collaborazione e nel sostegno reciproco. Insieme, affrontano le sfide più difficili e scoprono il vero significato dell\'essere regine.  Questo manga è una lettura divertente e appassionante, che lascerà un sorriso sul tuo viso e ti farà desiderare di avere anche tu dei poteri magici! La sua trama coinvolgente e il suo mondo incantevole ti terranno incollato fino all\'ultima pagina, e non vedrai l\'ora di tuffarti di nuovo in questo viaggio magico. Se sei alla ricerca di un\'avventura fantasy dolcissima e avvincente, \'Sugar Sugar Rune\' è la scelta perfetta!', 8, 46, 76, 'https://s4.anilist.co/file/anilistcdn/media/manga/cover/medium/bx30429-ZlNyuIqu5750.png'),
(30651, 'Kaze no Tani no Nausicaä', 'Hayao Miyazaki', '\'Kaze no Tani no Nausicaä\' è un manga straordinario e affascinante che ti catapulterà in un mondo di avventura, mistero e meraviglie ambientato in un futuro distopico. Con un incredibile punteggio di 85, questo manga è una perla rara che non puoi assolutamente farti sfuggire! La storia è ambientata in un pianeta Terra post-apocalittico, dove la civiltà è stata distrutta da una guerra che ha lasciato il terreno inquinato e avvelenato. Nonostante questo, la protagonista Nausicaä, una coraggiosa principessa guerriera, è determinata a proteggere il suo regno e il suo popolo da ogni minaccia. Armati del suo fedele spadone e della sua incredibile abilità nel pilotare il suo aereo, Nausicaä si avventura in un viaggio pericoloso attraverso le terre sconosciute, scoprendo segreti e affrontando pericoli inimmaginabili. Ma non è sola! Ad accompagnarla ci sono i suoi fedeli compagni, ognuno con la propria storia e il proprio passato, che la aiuteranno nella sua missione.\r\n\r\nI disegni di questo manga sono semplicemente mozzafiato. I paesaggi post-apocalittici sono resa in modo stupefacente, con un\'attenzione ai dettagli che ti lascerà a bocca aperta. Le tavole ricche di azione sono dinamiche e piene di vita, mentre i personaggi sono caratterizzati da un design unico e accattivante che li rende facilmente riconoscibili e memorabili. La storia è una combinazione perfetta di azione ad alta tensione, approfondite riflessioni filosofiche e momenti di commovente umanità. Attraverso le avventure di Nausicaä, l\'autore invita i lettori a riflettere sui temi profondi della guerra, dell\'ecologia e dell\'importanza di proteggere il nostro pianeta. Ma non solo! \'Kaze no Tani no Nausicaä\' è anche una storia emozionante e coinvolgente, che ti terrà incollato alle pagine con la sua trama intricata e piena di colpi di scena.\r\n\r\nSe sei alla ricerca di un\'opera che unisca azione, avventura e riflessione, \'Kaze no Tani no Nausicaä\' è la scelta perfetta per te! La sua protagonista forte e determinata, i personaggi secondari incredibilmente ben caratterizzati e un mondo post-apocalittico ricco di sfumature e misteri ti terranno incollato alle pagine, pagina dopo pagina. Preparati ad essere affascinato da questa opera d\'arte grafica e ad unirti a Nausicaä in un viaggio che non dimenticherai mai! Con la sua valutazione di 85, questo manga è una lettura obbligata per tutti gli appassionati del genere e per chi cerca una storia appassionante, ben disegnata e che lascerà il segno!', 7, 59, 85, 'https://s4.anilist.co/file/anilistcdn/media/manga/cover/medium/bx30651-xLufeLnDPqpn.jpg'),
(30664, 'AKIRA', 'Katsuhiro Ootomo', '\'AKIRA\' è un manga leggendario e rivoluzionario, una pietra miliare del genere sci-fi che ha lasciato il segno non solo nel mondo del fumetto, ma nell\'intera cultura popolare. Pubblicato tra il 1982 e il 1990, questo capolavoro di Katsuhiro Otomo ha ridefinito i canoni del fumetto giapponese e ha incantato generazioni di lettori con la sua storia intricata e visionaria. Con un punteggio di 84, questo è sicuramente un must-read per chiunque sia appassionato di fumetti e di fantascienza.\r\n\r\nLa trama di \'AKIRA\' è ambientata in un futuro distopico, nel 2019, in una Neo-Tokyo dagli inquietanti scenari cyberpunk. La città è stata ricostruita dopo essere stata distrutta da un\'esplosione termonucleare, ma le tensioni sociali e politiche sono ancora forti. Il governo cerca di nascondere un segreto orribile, mentre i giovani si ribellano e danno vita a un movimento di resistenza. Il protagonista, Tetsuo Shima, si ritrova involontariamente al centro di questo conflitto, dopo essere stato coinvolto in un incidente che gli fa scoprire i segreti di un ragazzo con incredibili poteri psichici di nome Akira.\r\n\r\nLa storia è un incredibile viaggio nel tempo e nello spazio, che esplora i temi della guerra, della politica, della gioventù e dell\'identità. I disegni sono semplicemente mozzafiato, con un livello di dettaglio e di precisione che lascerà a bocca aperta i lettori. Le scene d\'azione sono dinamiche e piene di energia, mentre i personaggi sono iconici e indimenticabili. Ogni pagina è una testimonianza della straordinaria abilità artistica di Otomo, con i suoi scenari affollati, i dettagli futuristici e le incredibili sequenze di azione che sembrano prendere vita davanti ai vostri occhi.\r\n\r\nMa \'AKIRA\' non è solo un fumetto d\'azione: è una riflessione profonda sulla natura umana, sulla società e sul potere. La trama si dipana come un mistero, svelandosi piano piano e tenendo i lettori incollati alle pagine. La narrazione è magistrale, con momenti di pura tensione psicologica e momenti di epica grandeur. Ogni personaggio ha una propria storia e motivazioni profonde, che rendono la storia ancora più coinvolgente.\r\n\r\nIl manga ha avuto un impatto culturale enorme, ispirando generazioni di artisti e autori di fumetti in tutto il mondo. La sua influenza si può vedere in molte opere moderne, ma nulla può preparare i lettori alla potenza dell\'opera originale. \'AKIRA\' è un\'esperienza indimenticabile, un viaggio nel futuro che lascerà il segno nel vostro animo. Se amate la fantascienza, l\'arte e le storie profonde e intricate, questo è un titolo che non potete assolutamente perdervi. Preparatevi ad essere affascinati e travolti da questa opera leggendaria, perché \'AKIRA\' è e resterà per sempre un caposaldo della storia del fumetto.', 6, 120, 84, 'https://s4.anilist.co/file/anilistcdn/media/manga/cover/medium/bx30664-JJq9tosQvlpW.jpg'),
(30698, 'Shin Seiki Evangelion', 'Yoshiyuki Sadamoto', '\'Shin Seiki Evangelion\' è un manga incredibile che ti trascinerà in un mondo di azione mozzafiato e profonde riflessioni filosofiche. Con un punteggio di 84, questo capolavoro di Yoshiyuki Sadamoto è una vera e propria perla per gli appassionati del genere e non solo! La storia è ambientata in un futuro distopico, in cui l\'umanità è minacciata da misteriosi esseri noti come Angeli. L\'unica speranza per la sopravvivenza del genere umano risiede nei potentissimi Evangelion, robot che vengono pilotati da giovani ragazzi dotati di una volontà ferrea.\r\n\r\nIl protagonista, Shinji Ikari, si ritrova catapultato in un mondo di segreti e mistero quando viene reclutato dall\'agenzia speciale NERV. Qui gli viene affidato il compito di pilotare l\'Evangelion Unit 1, diventando così un elemento fondamentale nella battaglia contro gli Angeli. Ma le cose si complicano quando emergono segreti sconvolgenti sul vero scopo della NERV e sull\'origine degli Angeli stessi.\r\n\r\nIl manga affascina sin dalle prime pagine con i suoi disegni mozzafiato, che ritraggono battaglie epiche tra gli Evangelion e gli Angeli. Ogni quadro è una vera e propria opera d\'arte, con dettagli curatissimi e un\'attenzione maniacale per le armature dei robot e per i paesaggi futuristici. Ma \'Shin Seiki Evangelion\' è anche un viaggio nei meandri della psiche umana, esplorando temi profondi come l\'identità, l\'angoscia esistenziale e i traumi dell\'adolescenza. I personaggi, ben caratterizzati e realistici, affrontano le loro paure e le loro sfide interiori mentre combattono per il destino dell\'umanità.\r\n\r\nLa trama ti terrà incollato alle pagine con la sua suspense e i suoi colpi di scena, mentre ti domanderai cosa accadrà ai nostri eroi nell\'epico conflitto contro il destino. Ma \'Shin Seiki Evangelion\' è anche un\'opera che invita alla riflessione, che stimola la mente con le sue intricate teorie filosofiche e le sue interpretazioni psicologiche. La narrazione sapientemente costruita ti lascerà a bocca aperta, con i suoi momenti intensi e commoventi che ti faranno vivere le emozioni dei personaggi in prima persona.\r\n\r\nIn conclusione, \'Shin Seiki Evangelion\' è un manga imperdibile, un\'opera che unisce azione adrenalinica e profonde riflessioni in un mix esplosivo. Se sei alla ricerca di un\'avventura robotica fuori dal comune, che ti faccia anche riflettere e sognare ad occhi aperti, allora questo è sicuramente il manga che fa per te! Preparati ad essere affascinato da questo incredibile viaggio nel futuro, tra battaglie epiche e segreti inattesi, in un\'opera che lascerà il segno nella tua collezione e nel tuo cuore!', 14, 97, 84, 'https://s4.anilist.co/file/anilistcdn/media/manga/cover/medium/bx30698-0niTa3yn2rNK.png'),
(31133, 'Dorohedoro', 'Q Hayashida', '\'Dorohedoro\' è un manga di azione e avventura che ti catapulterà in un mondo di magia oscura e misteri non risolti. Con un punteggio di 86, questo fumetto è una lettura imperdibile per chiunque ami le storie che uniscono il fantasy al mistero in un modo del tutto innovativo. La trama si svolge in un mondo brutale e crudele, dove la magia è reale e viene praticata da un gruppo di stregoni che abitano in una terra misteriosa chiamata \'Hole\'. Il protagonista, Dorohedoro, è un uomo dal passato misterioso, la cui testa è stata trasformata in una lucertola a causa di un incantesimo. Insieme al suo amico Caiman, che ha un\'insaziabile voglia di scoprire la verità dietro la sua maledizione, si avventura in un viaggio pericoloso per svelare i segreti di questo mondo magico.\r\n\r\nMan mano che la storia procede, i due protagonisti scoprono sempre più indizi su chi o cosa ha causato la loro condizione e si trovano coinvolti in una lotta epica contro i potenti stregoni che governano il mondo di Hole. Il manga è una lettura appassionante, con un ritmo serrato e una trama intricate che ti terrà incollato alle pagine. I disegni sono incredibili, con uno stile unico che cattura alla perfezione l\'atmosfera cupa e brutale del mondo di Dorohedoro. Le creature e i personaggi sono incredibilmente dettagliati e vari, con un design innovativo che rende ogni pagina una delizia visiva.\r\n\r\nMa \'Dorohedoro\' non è solo azione e combattimenti epici. Questo manga ha anche un profondo sottinteso filosofico, che invita i lettori a riflettere sulla natura della magia, sul prezzo della conoscenza e sull\'effimera linea di demarcazione tra bene e male. I personaggi sono sfaccettati e ben sviluppati, con storie personali che ti spezzano il cuore e ti lasciano a riflettere sulla condizione umana. La storia è piena di momenti commoventi, divertenti e sorprendenti, che ti terranno in suspense fino all\'ultima pagina. Se sei alla ricerca di un\'avventura fantasy mozzafiato, con personaggi indimenticabili e una trama che ti lascerà a bocca aperta, \'Dorohedoro\' è il manga che fa per te. Preparati a farti coinvolgere in un viaggio indimenticabile, perché una volta iniziato a leggere, non potrai più smettere!', 23, 191, 86, 'https://s4.anilist.co/file/anilistcdn/media/manga/cover/medium/bx31133-Jx6map3Oidz1.png'),
(31706, 'JoJo no Kimyou na Bouken: Steel Ball Run', 'Hirohiko Araki', '\'JoJo no Kimyou na Bouken: Steel Ball Run\' è un manga eccezionale, un\'epica avventura che ti trascinerà in un viaggio incredibile attraverso gli Stati Uniti del diciannovesimo secolo. Con un punteggio di 92, questo manga è una lettura imperdibile per tutti gli appassionati del genere e non solo!\r\n\r\nSteel Ball Run è un\'emozionante corsa a ostacoli che attraversa il continente americano, dove i concorrenti si sfidano in una gara all\'ultimo sangue. Il premio in palio è un incredibile bottino di un miliardo di dollari, che ha attirato un\'ampia gamma di partecipanti, ciascuno con le proprie motivazioni e abilità uniche. Al centro di questa storia incontriamo il misterioso e affascinante Johnny Joestar, un ex cavaliere di rodeo determinato a vincere la gara a ogni costo. Ma quello che segue non è solo una semplice corsa, perché i concorrenti si troveranno ad affrontare pericoli inimmaginabili e sfide che metteranno alla prova il loro coraggio e la loro forza di volontà.\r\n\r\nMan mano che la gara procede, i segreti del passato di Johnny vengono alla luce, svelando una complessa trama di mistero e vendetta. Si intrecciano storie di amicizia e tradimento, leali compagni di corsa che diventano temibili avversari. I disegni sono mozzafiato, con paesaggi grandiosi che rendono omaggio alla vastità dell\'America e scene d\'azione che ti lasceranno senza fiato. Ogni personaggio è curato nei minimi dettagli, con un design unico e riconoscibile che li rende indimenticabili.\r\n\r\nMa Steel Ball Run non è solo un\'avventura emozionante, è anche un viaggio di scoperta di sé stessi. I personaggi affrontano le loro paure e le loro debolezze, combattono per i loro sogni e scoprono il vero significato dell\'amicizia e del coraggio. La profondità dei personaggi e lo sviluppo della trama ti terranno incollato alle pagine, desideroso di scoprire cosa riserva il destino a questi coraggiosi concorrenti.\r\n\r\nCon un mix perfetto di azione, avventura e profondità emotiva, \'JoJo no Kimyou na Bouken: Steel Ball Run\' è un manga che ti lascerà senza fiato. Se sei alla ricerca di un\'epica storia di crescita personale e avventurosa, non cercare oltre, questo è il manga che fa per te! Una volta iniziato a leggerlo, non potrai più smettere fino alla fine, e anche allora continuerai a pensarci, perché le sue storie e i suoi personaggi rimarranno impressi nel tuo cuore.', 24, 95, 92, 'https://s4.anilist.co/file/anilistcdn/media/manga/cover/medium/bx31706-lRncu9VbcBB7.png'),
(33572, 'Tobaku Mokushiroku Kaiji', 'Nobuyuki Fukumoto', 'Se sei alla ricerca di un manga che ti tenga sul filo del rasoio e ti faccia vivere emozioni intense, allora \'Tobaku Mokushiroku Kaiji\' è la scelta perfetta per te! Con un punteggio di 83, questo straordinario manga è una vera e propria perla del genere psicologico e d\'azione che ti terrà incollato alle pagine fin dall\'inizio.\r\n\r\nLa storia segue le vicende di Kaiji Ito, un giovane uomo dalla vita apparentemente normale, ma che si ritrova intrappolato in una spirale di debiti a causa della sua spesa sconsiderata. La sua esistenza cambia radicalmente quando riceve un\'offerta inaspettata da un losco individuo di nome Endou: un\'opportunità per cancellare i suoi debiti partecipando a una serie di giochi mortali, dove il rischio e l\'adrenalina la fanno da padroni.\r\n\r\nI giochi a cui Kaiji dovrà sottoporsi sono progettati per mettere alla prova il suo coraggio, la sua astuzia e la sua capacità di prendere decisioni rapide. Ogni sfida è una battaglia mentale contro avversari spietati, che lo porteranno spesso al limite della sopportazione fisica e psicologica. Ma Kaiji è un combattente nato, e grazie al suo ingegno e alla sua determinazione riuscirà a superare ogni ostacolo, in un susseguirsi di colpi di scena mozzafiato.\r\n\r\nIl manga è un vero e proprio viaggio ai confini dell\'adrenalina, con momenti di tensione che ti terranno con il fiato sospeso. Ma non si tratta solo di giochi e rischi: la narrazione approfondisce anche i temi profondi della psicologia umana, esplorando le paure e le motivazioni più profonde che spingono i personaggi ad affrontare queste sfide estreme. La trama è un mix perfetto di suspense, strategia e riflessioni filosofiche, che ti faranno riflettere sul significato della vita e su quanto si è disposti a rischiare per raggiungere i propri obiettivi.\r\n\r\nI disegni sono un altro punto di forza di questo manga: i personaggi hanno un design unico e riconoscibile, e le scene d\'azione sono rese con uno stile dinamico e coinvolgente, che ti farà vivere ogni sfida come se fossi tu stesso sul campo di battaglia. Le espressioni facciali dei protagonisti comunicano emozioni intense, rendendo ogni momento ancora più coinvolgente.\r\n\r\nCon un mix perfetto di azione, psicologia e personaggi carismatici, \'Tobaku Mokushiroku Kaiji\' è un\'opera che ti terrà incollato alle pagine, desideroso di scoprire cosa riserva il destino a questi coraggiosi giocatori. Una storia che ti lascerà con il cuore in gola ad ogni pagina, e che ti farà amare il genere dei giochi ad alto rischio! Se sei alla ricerca di un\'avventura mozzafiato e stimolante, questo manga è sicuramente quello che fa per te!', 13, 158, 83, 'https://s4.anilist.co/file/anilistcdn/media/manga/cover/medium/bx33572-3M5IvzI17oEm.png'),
(37375, 'Kokou no Hito', 'Shinichi Sakamoto', '\'Kokou no Hito\' è un manga che ti trascinerà in un viaggio emozionante e profondo nel mondo dell\'arrampicata su roccia. Con un punteggio impressionante di 87, questo manga è una lettura imperdibile per chiunque cerchi una storia appassionante e stimolante. Seguiamo le vicende di Yoshitaka Yamashi, un giovane arrampicatore talentuoso ma tormentato, che è ossessionato dalla montagna che gli ha portato via il suo amico d\'infanzia. Determinato a sfidare la vetta che gli ha rubato il suo compagno, Yamashi si lancia in un viaggio di crescita personale e scoperta di sé attraverso l\'arrampicata.\r\n\r\nI disegni mozzafiato ti lasceranno a bocca aperta, con le loro rappresentazioni realistiche delle arrampicate più pericolose e mozzafiato. Il tratto preciso e dettagliato ti farà sentire come se fossi lì con Yamashi, a lottare su ogni presa e a godere della vista mozzafiato delle vette. Ma \'Kokou no Hito\' non è solo un manga sullo sport, è un viaggio di scoperta di sé, un viaggio che esplora i confini del coraggio e della determinazione umana. Ogni personaggio che incontrerai lungo questo percorso è complesso e sfaccettato, con le sue motivazioni e sfide personali. La loro evoluzione e crescita ti terrà incollato alle pagine.\r\n\r\nLa storia è intensa e coinvolgente, con momenti di grande tensione alternati a momenti di riflessione più calma e approfondita. Ti troverai a fare il tifo per Yamashi e per i suoi compagni di avventura, a gioire delle loro vittorie e a soffrire delle loro sconfitte. La passione per l\'arrampicata e per la natura selvaggia traspirerà da ogni pagina, ispirandoti a intraprendere la tua stessa avventura. Ma oltre all\'avventura, \'Kokou no Hito\' esplora anche i legami umani e l\'importanza dell\'amicizia, con momenti toccanti e commoventi che ti faranno riflettere sulla vera essenza della vita.\r\n\r\nIn conclusione, \'Kokou no Hito\' è un manga imperdibile, un\'opera che unisce azione, sport, crescita personale e approfondimenti psicologici, il tutto con uno stile grafico spettacolare. Se sei alla ricerca di una lettura appassionante e stimolante, che ti porti in un viaggio emozionante tra le vette più alte, allora \'Kokou no Hito\' è quello che fa per te! Non vedrai l\'ora di immergerti in questo mondo mozzafiato e di lasciarti ispirare dalla determinazione e dal coraggio dei suoi personaggi.', 17, 170, 87, 'https://s4.anilist.co/file/anilistcdn/media/manga/cover/medium/bx37375-wkgev4kXhamw.png'),
(41054, 'Billy Bat', 'Naoki Urasawa', '\'Billy Bat\' è un manga affascinante e coinvolgente che ti trascinerà in un viaggio mozzafiato attraverso il tempo e lo spazio, tenendoti incollato alle pagine fin dall\'inizio! Con un punteggio di 85, questo gioiello del maestro Naoki Urasawa, autore di capolavori come \'Monster\' e \'20th Century Boys\', ti lascerà a bocca aperta per la complessità della trama e la raffinatezza del disegno.\r\n\r\nLa storia segue le vicende di Kevin Yamagata, un artista di manga che vive a New York e che sta lavorando a una nuova serie dal titolo \'Billy Bat\'. Ma c\'è un mistero dietro questo personaggio: Billy Bat sembra avere il potere di prevedere il futuro e la sua origine è avvolta nel mistero. Mentre Kevin cerca di scoprire le radici di questo personaggio, si trova coinvolto in una trama che va ben oltre la semplice creazione di un fumetto, una trama che tocca temi di spionaggio internazionale e viaggi nel tempo!\r\n\r\nI disegni di Urasawa sono semplicemente stupendi, con un livello di dettaglio che ti lascerà a bocca aperta. Le sue abilità nel raccontare una storia complessa e intricata, con una narrazione che salta tra presente e passato, ti terranno incollato alle pagine, desideroso di scoprire il segreto dietro Billy Bat.\r\n\r\nLa bellezza di questo manga sta anche nella sua capacità di mescolare generi apparentemente lontani tra loro. Mistero, spionaggio, viaggi nel tempo e il mondo dei manga si fondono alla perfezione, creando un mix esplosivo che ti terrà in suspense fino all\'ultima pagina. E mentre ti addentri sempre più profondamente nella trama, scoprirai che nulla è davvero come sembra, e ogni rivelazione ti lascerà sbalordito, desideroso di saperne di più.\r\n\r\nSe sei un amante del genere thriller, dei misteri che tengono incollati alle pagine e dei disegni di altissima qualità, \'Billy Bat\' è il manga che fa per te! Una volta iniziato a leggerlo, non potrai più smettere fino alla fine, e la sua storia ti rimarrà impressa a lungo nella memoria. Un vero e proprio capolavoro che non puoi assolutamente perderti, un must-read per tutti gli appassionati di manga!', 20, 165, 85, 'https://s4.anilist.co/file/anilistcdn/media/manga/cover/medium/bx41054-Uje20Y9Q0Rmc.jpg'),
(43245, 'Chihayafuru', 'Yuki Suetsugu', '\'Chihayafuru\' è un manga che ogni amante dei fumetti non può assolutamente perdersi! Con un punteggio di 86 su 100, questo gioiello narrativo ti catapulterà in un mondo di passione, amicizia e crescita personale attraverso lo sport. La trama segue la vita di Chihaya Ayase, una ragazza del tutto ordinaria che ha una visione chiara del suo futuro: vuole diventare la migliore giocatrice di Karuta al mondo! Per chi non lo sapesse, il Karuta è un gioco di carte tradizionale giapponese che richiede una memoria di ferro e una concentrazione totale.\r\n\r\nLa storia inizia quando Chihaya è ancora alle scuole medie e presenta anche gli altri due personaggi principali: i suoi migliori amici d\'infanzia Taichi e Arata. Mentre crescono e passano alle superiori, Chihaya decide di formare un club di Karuta nella sua scuola per riunire i giocatori più forti e vincere i tornei nazionali. Il suo sogno, però, non è affatto facile da realizzare, e la strada verso il successo è lastricata di sfide e ostacoli.\r\n\r\nLa passione e la determinazione di Chihaya sono contagiosi, e la sua ostinazione nel perseguire i propri obiettivi è davvero ispirante. Attraverso le sue avventure, i lettori possono sperimentare l\'emozione del gioco del Karuta e comprendere l\'importanza dell\'amicizia e del lavoro di squadra. I disegni sono meravigliosi e pieni di vita, con un\'attenzione particolare ai dettagli che rendono ogni scena dinamica ed emozionante. Lo stile artistico è in grado di catturare la bellezza e l\'intensità delle partite, rendendo ogni pagina un vero e proprio spettacolo visivo.\r\n\r\nMa \'Chihayafuru\' non è solo un manga sullo sport. È una storia che parla di crescita personale, di sfida di sé stessi e di come i sogni e le passioni possano unire le persone. I personaggi secondari sono altrettanto affascinanti e ben sviluppati, con le loro proprie storie e motivazioni che arricchiscono la trama principale. La profondità dei loro caratteri e le relazioni che si creano all\'interno del gruppo rendono l\'opera ancora più coinvolgente e realistica.\r\n\r\nI messaggi di perseveranza e amicizia risuonano profondamente nel lettore, che sarà spinto a riflettere sulla propria vita e sulle proprie passioni. La bellezza di \'Chihayafuru\' sta nel fatto che ti ispirerà a trovare la tua strada, a lottare per i tuoi sogni e a non arrenderti mai. L\'opera tocca il cuore di chiunque, appassionato di sport o meno, grazie alla sua storia toccante e ai personaggi indimenticabili.\r\n\r\nIn conclusione, se sei alla ricerca di una storia emozionante, appassionante e visivamente stupenda, \'Chihayafuru\' è il manga che fa per te! Ti terrà incollato alle pagine, pagina dopo pagina, e lascerà un posto speciale nel tuo cuore per la determinazione e la bellezza dello spirito umano. Non perderti questa opera d\'arte, scopri il magico mondo di Chihaya e dei suoi amici, ne varrà sicuramente la pena!', 50, 248, 86, 'https://s4.anilist.co/file/anilistcdn/media/manga/cover/medium/nx43245-Ied8R99LH3u6.jpg'),
(53900, 'Umineko no Naku Koro ni Chiru Episode 7:', 'Ryukishi07', '\'Umineko no Naku Koro ni Chiru Episode 7: Requiem of the Golden Witch\' è un capitolo affascinante e mozzafiato della serie manga \'Umineko no Naku Koro ni\', che ti trascinerà in un mondo di mistero, magia e intrighi. Con un punteggio di 87, questo episodio supera le aspettative e offre un\'esperienza di lettura incredibile.\r\n\r\nIn questo episodio, la trama raggiunge il suo clou mentre i segreti dell\'enigmatica Golden Witch vengono finalmente rivelati. La storia si concentra sulla famiglia Ushiromiya, riunita nella loro magione sull\'isola di Rokkenjima per il lettura del testamento del capofamiglia Kinzo. Ma mentre gli eventi si svolgono, le linee tra realtà e sovrannaturale si sfumano, e i membri della famiglia si trovano coinvolti in una lotta per la sopravvivenza.\r\n\r\nRequiem of the Golden Witch è un thriller psicologico che vi terrà con il fiato sospeso per tutto il tempo. La trama intricate e piena di twist inaspettati vi porterà in un viaggio mozzafiato attraverso il passato e il presente, svelando gradualmente i misteri che circondano la strega d\'oro e la vera natura dei poteri che deteneva. Con ogni pagina, verrai immerto in un mondo di magia oscura e segreti ancestrali, mentre i personaggi combattono per la loro stessa esistenza.\r\n\r\nI disegni sono assolutamente mozzafiato, con un\'attenzione ai dettagli e alle espressioni dei personaggi che rende ogni scena viva e vibrante. I momenti di tensione sono magistralmente ritratti, e le battaglie epiche tra i personaggi e le forze sovrannaturali lasceranno senza fiato. Il finale è un colpo di scena che lascerà soddisfatti anche i lettori più esigenti, chiudendo il cerchio in modo brillante e leaving you wanting more.\r\n\r\nSe sei un amante del mistero, del soprannaturale e delle trame intricate, \'Umineko no Naku Koro ni Chiru Episode 7: Requiem of the Golden Witch\' è un must-read. Questa opera lascerà un segno indelebile in te, e una volta finita vorrai subito rivivere l\'esperienza dall\'inizio! Un manga eccezionale che non deluderà le tue aspettative e che ti terrà incollato alle pagine fino alla fine!', 9, 48, 87, 'https://s4.anilist.co/file/anilistcdn/media/manga/cover/medium/nx53900-aDalkx2qmugI.png'),
(54457, 'Mahou Shoujo Madoka☆Magica', 'Magica Quartet', '\'Mahou Shoujo Madoka☆Magica\' è un manga affascinante e innovativo che rivoluziona il genere delle magie girl, offrendo una prospettiva oscura e stimolante sull\'apparente vita da sogno di una strega. Con un punteggio di 78, questo gioiello del fumetto giapponese merita sicuramente un posto nella collezione di ogni appassionato.\r\n\r\nLa trama segue le vicende di Madoka Kaname, una studentessa delle scuole medie che conduce una vita apparentemente normale, fino a quando non incontra una misteriosa ragazza chiamata Homura Akemi. Homura, che si rivela essere una strega, cerca disperatamente di proteggere Madoka da un destino terribile. Madoka, infatti, ha il potenziale per diventare una strega molto potente, ma a un costo molto alto.\r\n\r\nMan mano che la storia si sviluppa, Madoka scopre l\'esistenza di un mondo nascosto, abitato da creature malvagie note come \'streghe\', che si nutrono delle emozioni negative degli esseri umani. Le magie girl combattono queste streghe per proteggere l\'umanità, ma a un prezzo altissimo. Ogni volta che una magia girl combatte, il suo destino è già scritto: sarà condannata a trasformarsi in una strega a sua volta.\r\n\r\nLe grafiche sono stupende, con un character design accattivante e un\'attenzione ai dettagli mozzafiato. I lettori saranno affascinati dagli eleganti abiti da strega e dagli splendidi scenari surreali, che creano un\'atmosfera unica e inquietante. I disegni sono così belli che rimarrai a bocca aperta per la loro bellezza, soprattutto nelle scene di battaglia, che sono coreografiche e piene d\'azione.\r\n\r\nI personaggi sono ben sviluppati e affascinanti. Madoka è una protagonista forte e determinata, mentre Homura è avvolta in un mistero che ti terrà incollato alle pagine per scoprirne di più. Il resto del cast aggiunge profondità alla storia, con relazioni complesse e personaggi secondari ben delineati.\r\n\r\nLa storia è una magistrale miscela di magia, azione e dramma psicologico. Con ogni capitolo, gli autori riescono a sorprendere il lettore con nuovi colpi di scena e rivelazioni che ti lasceranno senza fiato. È un viaggio emozionante che esplora i temi della speranza, del destino e del prezzo della magia.\r\n\r\nIn conclusione, \'Mahou Shoujo Madoka☆Magica\' è un manga imperdibile, che incanterà i lettori con la sua bellezza e li affascinerà con la sua trama intricata e coinvolgente. Se sei alla ricerca di un\'avventura magica fuori dall\'ordinario, questo è sicuramente il titolo che fa per te!', 3, 12, 78, 'https://s4.anilist.co/file/anilistcdn/media/manga/cover/medium/bx54457-qnru2gBhb202.jpg'),
(65243, 'Haikyuu!!', 'Haruichi Furudate', '\'Haikyuu!!\' è un manga straordinario che ti trascinerà nel mondo emozionante della pallavolo a livello scolastico! Con un punteggio di 88, questo fumetto è una lettura indispensabile per chiunque cerchi una storia appassionante, divertente e stimolante.\r\n\r\nLa trama segue le vicende di Hinata, un ragazzo che vuole diventare un giocatore di pallavolo nonostante la sua bassa statura. La sua passione per questo sport nasce dopo aver visto una partita della squadra locale, e da quel momento decide che diventerà un giorno il re del court. Hinata si iscrive alla Karasuno High School, la cui squadra di pallavolo è famosa per i suoi giocatori talentuosi, tra cui il leggendario \'Piccolo Gigante\'. Qui conosce il talentuoso setter Kageyama, con cui forma una coppia dinamica e inseparabile. Insieme, i due affrontano le sfide del campionato scolastico, affrontando avversari sempre più forti e abili.\r\n\r\nQuello che rende \'Haikyuu!!\' così speciale è la sua capacità di catturare la vera essenza dello sport e la passione che lo anima. Le partite sono piene di tensione e adrenalina, mentre i nostri protagonisti devono affrontare non solo avversari forti, ma anche i loro stessi dubbi e paure. La grafica è stupenda, con un\'attenzione ai dettagli che rende ogni scena di gioco incredibilmente emozionante e realistica. I personaggi sono approfonditi e ben sviluppati, con le loro personalità e storia che si intrecciano perfettamente con l\'azione. La crescita individuale e di squadra che vivono i protagonisti è una delle parti più affascinanti della storia.\r\n\r\nInoltre, \'Haikyuu!!\' è anche una celebrazione dell\'amicizia e del lavoro di squadra. I membri della squadra imparano a fidarsi l\'uno dell\'altro e a unire le loro forze per raggiungere l\'obiettivo comune. Le loro interazioni fuori dal campo di gioco sono altrettanto divertenti e toccanti, aggiungendo profondità e carattere a questa straordinaria serie.\r\n\r\nSe sei un appassionato di sport o semplicemente ami le storie piene di passione, umorismo e azione, \'Haikyuu!!\' è il manga perfetto per te. Ti terrà incollato alle pagine con la sua trama coinvolgente e i personaggi indimenticabili, e ti farà venire voglia di tuffarti sul primo campo di pallavolo che trovi! Non perderti questa opera meravigliosa, che saprà sicuramente conquistar ti fin dalle prime pagine!', 45, 404, 88, 'https://s4.anilist.co/file/anilistcdn/media/manga/cover/medium/bx65243-mR4MnJFmfaOF.png'),
(85189, 'Mob Psycho 100', 'ONE', '\'Mob Psycho 100\' è un manga d\'azione e avventura che ti trascinerà in un mondo di poteri psichici e lotte epiche! Con un punteggio di 85, questo gioiello della narrativa è destinato a farti restare incollato alle pagine fin dall\'inizio. La storia segue le vicende di Mob, un ragazzo timido e riservato che sembra del tutto ordinario, ma nasconde un incredibile potere psichico. Con un\'abilità di questo genere a sua disposizione, Mob potrebbe essere una star, ma preferisce vivere una vita tranquilla e passare inosservato. Tuttavia, gli eventi lo porteranno su un percorso di crescita e scoperta di sé, mentre affronterà sfide sempre più pericolose e affascinanti.  I disegni mozzafiato ti lasceranno a bocca aperta, con scene d\'azione dinamiche e piene di energia che faranno accelerare il tuo cuore ad ogni pagina. La caratterizzazione dei personaggi è eccezionale, con Mob che passa da un umile ed eroico giovane a un potente ed enigmatico eroe, mentre i suoi amici e nemici lo accompagnano in un viaggio incredibile. La trama ti terrà incollato alle pagine, con un mix perfetto di azione, commedia e momenti toccanti che esplorano le profondità dell\'amicizia, del coraggio e del potere della mente.  Ma \'Mob Psycho 100\' non è solo un\'avventura emozionante, è anche una profonda riflessione sui poteri psichici e su come questi influenzano la vita di chi li possiede. La storia esplora i lati positivi e negativi di questi doni, presentando una gamma completa di personaggi con abilità uniche e sfaccettate. Le loro lotte e le loro sfide ti terranno in sospeso, mentre ti domandi cosa riserva il destino a questi incredibili personaggi.  Questo manga è una lettura essenziale per tutti gli appassionati di azione e avventura, con un tocco soprannaturale che lo rende ancora più affascinante. La sua trama coinvolgente, i personaggi indimenticabili e i disegni spettacolari lo rendono un vero e proprio gioiello della letteratura a fumetti. Se sei alla ricerca di una storia emozionante, divertente e profondamente toccante, \'Mob Psycho 100\' è la scelta perfetta! Ti assicuro che non ne rimarrai deluso.', 16, 113, 85, 'https://s4.anilist.co/file/anilistcdn/media/manga/cover/medium/nx85189-06aXUBq5jwce.jpg'),
(85412, 'Shoujo Shuumatsu Ryokou', 'Tsukumizu', '\'Shoujo Shuumatsu Ryokou\' è un manga eccezionale che ti trascinerà in un viaggio emozionante e profondo attraverso un mondo post-apocalittico, con un tocco di fantasy e una storia che ti rapirà fin dalle prime pagine. Con un punteggio di 86, questo manga è una perla che non puoi assolutamente farti sfuggire!\r\n\r\nLa trama segue le vicende di due ragazze, Chito e Yuuri, che vivono in un mondo devastato da una catastrofe che ha portato alla quasi totale distruzione dell\'umanità. Le due protagoniste, a bordo del loro carro trainato da una coppia di mucche, intraprendono un viaggio senza meta attraverso questo mondo desolato, alla scoperta di nuovi luoghi e di sé stesse.\r\n\r\nIl disegno è semplicemente stupendo: i paesaggi post-apocalittici sono ritratti con una bellezza crudele, che trasmette un senso di solitudine e malinconia, mentre i personaggi sono caratterizzati da un design delicato e accattivante, che rende subito simpatico il lettore verso di loro. Ogni tavola è un\'opera d\'arte, con un\'attenzione ai dettagli e una cura del tratto che vi lascerà a bocca aperta.\r\n\r\nLa storia è una miscela perfetta di avventura, fantasy e riflessione filosofica. Il viaggio di Chito e Yuuri è un pellegrinaggio verso la verità, mentre affrontano i misteri di questo mondo e scoprono i segreti del loro passato. Il tutto accompagnato da un\'atmosfera coinvolgente e da momenti di pura poesia visiva.\r\n\r\nI personaggi sono ben sviluppati e profondi, con le loro debolezze, speranze e sogni. La relazione tra Chito e Yuuri è il vero cuore del manga, la loro amicizia indissolubile e il loro sostegno reciproco sono una storia di speranza e coraggio in un mondo senza speranza.\r\n\r\nCon un mix perfetto di azione, mistero e momenti di quiete, \'Shoujo Shuumatsu Ryokou\' è un\'opera che ti terrà incollato alle pagine, desideroso di scoprire cosa riserva il destino a queste due coraggiose ragazze. La sua capacità di coniugare azione e riflessione lo rende adatto sia agli amanti dell\'avventura sia a quelli delle storie più profonde.\r\n\r\nSe sei alla ricerca di un manga affascinante, emozionante e visivamente stupendo, \'Shoujo Shuumatsu Ryokou\' è la scelta perfetta! Ti garantisco che rimarrai affascinato da questo viaggio post-apocalittico e che la sua storia ti rimarrà nel cuore a lungo dopo averlo concluso. Un vero e proprio gioiello del mondo del manga, da non perdere!', 6, 47, 86, 'https://s4.anilist.co/file/anilistcdn/media/manga/cover/medium/bx85412-wzZ2QFwbZJED.jpg');
INSERT INTO `manga` (`id`, `nome`, `autore`, `descrizione`, `volumi`, `capitoli`, `rating`, `immagine`) VALUES
(85464, 'Gekijouban Mahou Shoujo Madoka★Magica: S', 'Gen Urobuchi', 'Se sei un amante del genere fantasy e dei racconti magici, preparati ad immergerti in un\'avventura mozzafiato con \'Gekijouban Mahou Shoujo Madoka★Magica: Shinpen - Hangyaku no Monogatari\'! Questo straordinario manga è una perla che ti trascinerà in un mondo incantato, dove la linea tra il bene e il male è destinata a sfumare. La storia segue le vicende di Madoka Kaname, una ragazza delle medie che sembra vivere una vita normale, fino a quando un incontro sconvolgente con una misteriosa strega e la sua amica streghetta la catapulta in un universo parallelo di magia e mistero.\r\n\r\nIn questo nuovo mondo, Madoka scopre di avere il potere di trasformarsi in una ragazza magica, con la capacità di combattere le streghe e proteggere l\'umanità dal male. Ma c\'è un prezzo da pagare: ogni volta che utilizza i suoi poteri, Madoka si avvicina sempre di più al lato oscuro, diventando lei stessa una strega! Mentre si addentra sempre più in questo pericoloso e affascinante mondo, Madoka deve fare i conti con le conseguenze delle sue azioni e domandarsi se la lotta contro le streghe valga davvero il sacrificio.\r\n\r\nCon un trama intricata e piena di colpi di scena, questo manga ti terrà incollato alle pagine con la sua narrativa avvincente e i suoi personaggi complessi e carismatici. I disegni sontuosi e dettagliati ti lasceranno a bocca aperta, con le loro atmosfere cupe e sognanti al contempo, che creano un contrasto mozzafiato. Ogni pannello è una vera opera d\'arte, che ti lascerà incantato.\r\n\r\nMa \'Gekijouban Mahou Shoujo Madoka★Magica: Shinpen - Hangyaku no Monogatari\' non è solo un\'avventura magica: è una riflessione profonda sul destino, sulla natura del bene e del male e su quanto sia labile il confine tra loro. Le tematiche maturi e gli approfondimenti psicologici dei personaggi ti terranno in tensione fino all\'ultima pagina, lasciandoti con un senso di soddisfazione e una nuova prospettiva sul potere della magia.\r\n\r\nCon una valutazione di 78, questo manga è una lettura imperdibile per gli appassionati di fantasy e non solo. Preparati ad essere affascinato e travolto da questa storia magica e dark, che ti lascerà senza fiato! Se non l\'hai ancora fatto, devi assolutamente immergerti in questo straordinario mondo di magia e segreti, ne varrà sicuramente la pena!', 3, 9, 78, 'https://s4.anilist.co/file/anilistcdn/media/manga/cover/medium/bx85464-eXfpCFGhkhoC.jpg'),
(86082, 'Dungeon Meshi', 'Ryouko Kui', '\'Dungeon Meshi\' è un manga che ogni amante dei fumetti non può assolutamente perdersi! Con un punteggio di 87, questo gioiello del mondo della letteratura grafica ti catapulterà in un universo fantasy incredibilmente ricco di dettagli e pieno di avventura. Segui le vicende di un gruppo di avventurieri che si addentrano in un dungeon misterioso e pericoloso, alla ricerca di tesori nascosti e segreti da scoprire. Il tutto accompagnato da un elemento che rende questa storia ancora più gustosa: il cibo! \r\n\r\nI nostri eroi, infatti, non si limitano a combattere mostri e risolvere enigmi, ma trovano anche il tempo di preparare deliziosi piatti con gli ingredienti più disparati che il dungeon ha da offrire. La cucina diventa così un\'arma fondamentale per la loro sopravvivenza, un modo per ricaricare le energie e affrontare le sfide sempre più ardue che li attendono. La trama ti terrà incollato alle pagine con la sua suspense, mentre i personaggi saranno in grado di rubare il tuo cuore con le loro personalità uniche e accattivanti. La protagonista, una cuoca provetta, saprà affascinarti con la sua determinazione e la sua creatività in cucina, mentre il resto della banda ti farà ridere e piangere con le loro vicende avventurose. \r\n\r\nIl disegno è stupendo, con un\'attenzione ai dettagli che rende ogni pagina un vero spettacolo per gli occhi. I mostri sono orribili e terrificanti, i paesaggi mozzafiato e i personaggi così reali che sembrerai quasi di sentire l\'odore dei piatti che vengono cucinati. Ogni capitolo di questa opera è una delizia per gli appassionati di fantasy, cucina e avventura. Se sei alla ricerca di una storia emozionante, divertente e al contempo raffinata, \'Dungeon Meshi\' è la scelta perfetta! Una volta iniziato a leggere, non ne potrai più fare a meno!', 14, 111, 87, 'https://s4.anilist.co/file/anilistcdn/media/manga/cover/medium/bx86082-MXizJxzbijdd.jpg'),
(86569, 'Diamond no Ace Act II', 'Yuuji Terajima', '\'Diamond no Ace Act II\' è la seconda parte di un manga sportivo che segue le vicende di un giovane lanciatore di baseball di nome Eijun Sawamura, che sogna di diventare il miglior giocatore della sua scuola e di portare la sua squadra alla vittoria del campionato nazionale. Con un voto di 86, questa serie è un vero e proprio gioiello per gli appassionati di sport e non solo!\r\n\r\nLa storia inizia con Sawamura che, dopo aver perfezionato le sue abilità nella prima serie, è ora pronto ad affrontare le sfide del campionato estivo con la sua squadra del liceo Seido. La loro strada verso la vittoria però non sarà facile, poiché dovranno affrontare avversari sempre più forti e talentuosi. Sawamura, con la sua determinazione e il suo incredibile spirito combattivo, guida la sua squadra in partite mozzafiato, dove ogni punto contende è una battaglia epica.\r\n\r\nMa \'Diamond no Ace Act II\' non è solo sport: la crescita dei personaggi e le loro relazioni sono ugualmente importanti. Vediamo Eijun crescere non solo come giocatore, ma anche come persona, mentre affronta le difficoltà dell\'adolescenza, trova la propria identità e impara l\'importanza dell\'amicizia e del lavoro di squadra. I personaggi secondari, ognuno con la propria storia e personalità uniche, aggiungono profondità e varietà all\'opera, rendendo i lettori totalmente assorbiti in questo mondo di baseball.\r\n\r\nIl disegno è stupendo, con un\'attenzione ai dettagli che rende ogni partita un vero spettacolo visivo. I movimenti fluidi dei giocatori, le espressioni intense dei personaggi e gli sfondi dettagliati trasmettono perfettamente l\'eccitazione e la tensione delle partite, lasciando i lettori sul bordo delle loro sedie. E quando i nostri eroi riescono a realizzare una giocata incredibile, è un\'autentica montagna russa di emozioni!\r\n\r\nCon una trama avvincente, personaggi memorabili e un\'atmosfera elettrica, \'Diamond no Ace Act II\' è un manga che ti terrà incollato alle pagine, desideroso di scoprire cosa accadrà nella partita successiva. È una lettura essenziale per chi ama lo sport, ma anche per chi cerca una storia emozionante e coinvolgente sulla crescita personale e il potere dell\'amicizia. Preparati a farti travolgere dalla febbre del baseball e a becoming un vero tifoso della squadra della Seido!', 34, 308, 86, 'https://s4.anilist.co/file/anilistcdn/media/manga/cover/medium/bx86569-KC2nXAGtv0Cx.jpg'),
(86635, 'Kaguya-sama wa Kokurasetai: Tensaitachi ', 'Aka Akasaka', '\'Kaguya-sama wa Kokurasetai: Tensaitachi no Renai Zunousen\' è un manga che ogni amante dei fumetti non può assolutamente perdersi! Con un punteggio di 88 su 100, questo è sicuramente uno dei migliori titoli degli ultimi anni. La storia segue le vicende di Kaguya Shinomiya, una studentessa delle superiori bellissima, intelligente e ricca di famiglia, che sembra avere tutto ciò che si possa desiderare. Ma c\'è un problema: l\'orgoglio. Kaguya, infatti, fatica a confessare i propri sentimenti al ragazzo di cui è innamorata, Miyuki Shirogane, il presidente del consiglio studentesco. Entrambi sono troppo orgogliosi per fare la prima mossa, e così inizia un divertentissimo gioco del gatto e del topo, in cui cadauno cerca di fare in modo che l\'altro faccia la prima mossa.\r\n\r\nI disegni di questo manga sono davvero stupendi, con un carattere ben definito che rende ogni personaggio unico e facilmente riconoscibile. Lo stile artistico è raffinato e curato, con particolare attenzione ai dettagli e alle espressioni facciali, che rendono ogni scena davvero viva e piena di emozioni. I dialoghi sono brillanti e pieni di battute divertenti, che terranno il lettore incollato alle pagine. Ma non si tratta solo di commedia: c\'è anche un profondo sviluppo dei personaggi, che crescono e cambiano nel corso della storia, affrontando le proprie paure e debolezze. La relazione tra Kaguya e Miyuki è il filo conduttore dell\'opera, ma non l\'unico focus, infatti anche gli altri membri del consiglio studentesco hanno le loro trame e le loro storie d\'amore, che si intrecciano e si sviluppano di capitolo in capitolo.\r\n\r\nLa storia è piena di momenti emozionanti, romantici e anche commoventi, che terranno il lettore col fiato sospeso. Inoltre, la trama principale si arricchisce di arcs secondari altrettanto affascinanti, che aggiungono profondità e varietà all\'opera. \'Kaguya-sama wa Kokurasetai\' è un manga che parla d\'amore, ma non solo: parla anche di amicizia, crescita personale e scoperta di sé. Un mix perfetto di commedia, romanticismo e approfondimento psicologico dei personaggi, che lascerà il lettore con il sorriso sulle labbra e il desiderio di continuare a leggere sempre più capitoli. La trama è coinvolgente e mai scontata, con colpi di scena in grado di sorprendere anche i lettori più smaliziati.\r\n\r\nIn conclusione, se sei alla ricerca di un manga divertente, romantico e ben disegnato, \'Kaguya-sama wa Kokurasetai: Tensaitachi no Renai Zunousen\' è la scelta perfetta! Una volta iniziato a leggere, non potrai più smettere, e anche il lettore più esigente resterà affascinato da questa storia unica e coinvolgente. Lasciati conquistare dall\'amore e dall\'umorismo di Kaguya e Miyuki, e scopri perché questo manga ha conquistato il cuore di così tante persone!', 28, 281, 88, 'https://s4.anilist.co/file/anilistcdn/media/manga/cover/medium/bx86635-EdaLQmsn86Fy.png'),
(97553, 'Jumyou wo Kaitotte Moratta. Ichinen ni T', 'Sugaru Miaki', '\'Jumyou wo Kaitotte Moratta. Ichinen ni Tsuki, Ichimanen de.\' è un manga davvero affascinante e unico nel suo genere, che saprà sicuramente catturare il tuo cuore! Con un punteggio di 86 su 100, questo manga è una perla rara che non puoi assolutamente farti sfuggire.\r\n\r\nLa trama segue le vicende di un ragazzo di nome Kimiyasu, uno studente delle superiori che vive una vita piuttosto ordinaria. Un giorno, però, riceve una strana email sul suo smartphone, che gli offre la possibilità di ottenere il nome magico di una persona in cambio di un milione di yen. Kimiyasu, curioso e tentato dalla proposta, decide di accettare l\'offerta, senza immaginare le incredibili conseguenze che questa scelta comporterà.\r\n\r\nMan mano che la storia procede, Kimiyasu scopre che i nomi hanno un potere incredibile, in grado di controllare e influenzare ogni aspetto della realtà. Ma questo segreto è conosciuto anche da altre persone, che sono disposte a tutto pur di ottenere questi potenti nomi magici. Kimiyasu si ritrova così coinvolto in un pericoloso gioco del gatto con il topo, dove deve fare affidamento sulle sue capacità e sulla sua astuzia per rimanere vivo e proteggere le persone a cui tiene.\r\n\r\nIl manga ti terrà incollato alle pagine con la sua narrativa serrata e piena di suspense. La trama è ricca di colpi di scena e rivelazioni sorprendenti, che ti terranno in costante apprensione. Inoltre, i personaggi sono profondi e ben sviluppati, con le loro motivazioni e sfide personali che li rendono incredibilmente realistici e accattivanti.\r\n\r\nMa \'Jumyou wo Kaitotte Moratta. Ichinen ni Tsuki, Ichimanen de.\' non è solo azione e mistero. Il manga esplora anche le relazioni umane e i temi profondi della vita, come il valore dell\'amicizia, il significato dell\'identità e la forza della determinazione. La profondità dei suoi contenuti ti lascerà a riflettere a lungo sulle sue tematiche anche dopo aver terminato la lettura.\r\n\r\nL\'arte e lo stile grafico sono altrettanto eccezionali. I disegni sono dettagliati e accattivanti, con un uso sapiente delle ombre e dei dettagli che rendono ogni scena viva e vibrante. I personaggi sono disegnati in modo espressivo, permettendoti di cogliere ogni emozione e sentimento che provano.\r\n\r\nQuesto manga è una perla rara, un mix perfetto di azione, mistero e profondità narrativa. Se sei alla ricerca di un\'avventura mozzafiato che ti tenga incollato alle pagine e che al contempo stimoli la tua mente con temi stimolanti, \'Jumyou wo Kaitotte Moratta. Ichinen ni Tsuki, Ichimanen de.\' è la scelta perfetta per te! Non perderti questa opera meravigliosa, ne varrà sicuramente la pena!', 3, 18, 86, 'https://s4.anilist.co/file/anilistcdn/media/manga/cover/medium/bx97553-vqJj5DFS8v2p.jpg'),
(99560, 'Nogi Wakaba wa Yuusha de Aru', 'Takahiro', '\'Nogi Wakaba wa Yuusha de Aru\' è un manga affascinante e avvincente che ti trascinerà in un mondo di avventura, fantasia e coraggio! Con un punteggio di 76, questo gioiello della letteratura è una lettura imperdibile per tutti gli appassionati di fantasy e non solo! La storia segue le vicende di Wakaba Nogi, una ragazza coraggiosa e determinata che vive in un mondo dove l\'umanità è costantemente minacciata da mostri e creature misteriose. Wakaba sogna di diventare un giorno un eroe come suo padre, che ha sacrificato la vita per proteggere il suo villaggio da un attacco mostri.\r\n\r\nUn giorno, Wakaba incontra uno strano e misterioso ragazzo di nome Kuro, che le propone un patto: se accetterà di diventare la sua padrona e firmare un contratto con lui, le donerà un incredibile potere magico. La ragazza, mossa dal desiderio di diventare un eroe e di proteggere gli altri, accetta senza esitare. Così inizia la sua avventura, accompagnata da Kuro, un essere misterioso e enigmatico, ma dal cuore d\'oro. Insieme, affrontano pericoli e sfide, combattendo mostri e scoprendo segreti nascosti.\r\n\r\nMan mano che la storia procede, Wakaba impara a controllare i suoi nuovi poteri e a conoscere meglio se stessa e il mondo che la circonda. Il suo coraggio e la sua determinazione saranno messi alla prova in battaglie epiche, dove dovrá affrontare i suoi timori e le sue debolezze, ma anche fare importanti scoperte sulla propria identità e sul proprio destino. Il manga è un mix perfetto di azione e avventura, con un tocco di magia e mistero che rende la trama ancora più intrigante. I disegni sono spettacolari, con un\'attenzione ai dettagli e un\'arte raffinata che ritraggono alla perfezione le epiche battaglie e i paesaggi mozzafiato.\r\n\r\nI personaggi sono tutti ben caratterizzati e approfonditi, con le loro debolezze, ambizioni e segreti che li rendono reali e accattivanti. Wakaba è una protagonista forte e ispiratrice, il cui coraggio e determinazione saranno una fonte di ispirazione per i lettori. E Kuro, il suo misterioso compagno, nasconde un passato affascinante che verrà svelato piano piano, tenendo il lettore incollato alle pagine. \'Nogi Wakaba wa Yuusha de Aru\' è un manga che ti terrà incollato alla sedia, con la sua trama avvincente e i suoi personaggi indimenticabili. La storia ti trascinerà in un viaggio emozionante, dove il coraggio e l\'amicizia saranno i veri protagonisti. Se sei alla ricerca di un\'avventura magica e coinvolgente, questo manga è sicuramente la scelta perfetta per te! Non perderti questa opera meravigliosa, che ti lascerà senza fiato e con il desiderio di leggere sempre più capitoli!', 4, 20, 76, 'https://s4.anilist.co/file/anilistcdn/media/manga/cover/medium/bx99560-FbJ7thqF1rq6.png'),
(114998, 'Bungou Stray Dogs BEAST', 'Kafka Asagiri', '\'Bungou Stray Dogs BEAST\' è un manga straordinario e avvincente che ti trascinerà in un mondo di mistero, azione e fantasia pur mantenendo un piede nella realtà storica! Con un punteggio di 85, questo manga è una lettura obbligata per gli appassionati di avventure mozzafiato e personaggi unici e carismatici.\r\n\r\nLa storia è ambientata in un mondo in cui i poteri sovrannaturali esistono davvero e sono possessione comune tra la gente. Il nostro protagonista, Atsushi Nakajima, è un ragazzo che sembra essere l\'unico senza abilità particolari, il che lo rende un po\' un\'anatra fuori dall\'acqua. Tuttavia, la sua vita cambia drasticamente quando incontra un cane parlante di nome Rampo, che lo introduce a un gruppo di persone dotate di poteri straordinari noto come \'Agencia Armstrong\'.\r\n\r\nQuesto gruppo misterioso è composto da personaggi ispirati ai grandi autori della letteratura giapponese, come ad esempio il già citato Rampo, che prende il nome dallo scrittore Rampo Edogawa, e il carismatico e intelligente Dazai Osamu, che deve il suo nome a Osamu Dazai. Ogni membro dell\'agenzia possiede un potere unico e incredibile, che usano per risolvere casi misteriosi e combattere il crimine.\r\n\r\nAtsushi, che si scopre essere in grado di trasformarsi in un tigre, si unisce all\'Agencia Armstrong nella loro missione di proteggere la città da minacce sovrannaturali e mantenere l\'ordine. Insieme, questo gruppo eterogeneo di personaggi si imbarca in una serie di avventure pazzesche, combattendo contro nemici potenti e svelando una cospirazione che va oltre l\'immaginazione.\r\n\r\nI disegni di \'Bungou Stray Dogs BEAST\' sono davvero mozzafiato, con un\'attenzione ai dettagli e uno stile accattivante che rende ogni scena vivida e coinvolgente. I personaggi sono disegnati con un\'espressione e una caratterizzazione eccezionale, ensuring che il lettore si affezioni a loro istantaneamente. Le scene d\'azione sono dinamiche e piene di suspense, mentre i momenti di quiete mostrano lo sviluppo dei personaggi e la crescita dei legami tra di loro.\r\n\r\nLa trama è ben orchestrata, con un mix perfetto di mistero, commedia e momenti commoventi che terranno il lettore incollato alle pagine. Inoltre, se apprezzi la letteratura giapponese, ti divertirai a scoprire come gli autori hanno incorporato gli elementi e le tematiche delle opere dei loro omologhi letterari nella storia.\r\n\r\nIn sintesi, \'Bungou Stray Dogs BEAST\' è un manga imperdibile, che combina abilmente elementi di diversi generi per creare una storia unica e affascinante. Con personaggi memorabili, disegni stupendi e una trama coinvolgente, questo manga ti terrà incollato alle pagine fino alla fine, e lascerà il desiderio di leggere il prossimo volume non appena ne avrai finito uno! Non perderti questa avventura straordinaria, ti assicuro che ne varrà la pena!', 4, 22, 85, 'https://s4.anilist.co/file/anilistcdn/media/manga/cover/medium/bx114998-JTCzDczl8eBD.jpg');

-- --------------------------------------------------------

--
-- Struttura della tabella `preferiti`
--

CREATE TABLE `preferiti` (
  `id_utente` int(11) NOT NULL,
  `id_manga` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `preferiti`
--

INSERT INTO `preferiti` (`id_utente`, `id_manga`) VALUES
(1, 30025),
(3, 30003),
(3, 30698),
(4, 30008),
(4, 30664),
(4, 37375),
(4, 65243),
(4, 86569);

-- --------------------------------------------------------

--
-- Struttura della tabella `stato_lettura`
--

CREATE TABLE `stato_lettura` (
  `id` int(11) NOT NULL,
  `id_libreria_manga` int(11) NOT NULL,
  `numero_capitolo` int(11) NOT NULL,
  `stato` enum('in_corso','completato','abbandonato') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `stato_lettura`
--

INSERT INTO `stato_lettura` (`id`, `id_libreria_manga`, `numero_capitolo`, `stato`) VALUES
(3, 36, 158, 'completato'),
(4, 37, 62, 'in_corso'),
(5, 38, 6, 'in_corso'),
(6, 42, 11, 'in_corso'),
(7, 43, 55, 'abbandonato');

-- --------------------------------------------------------

--
-- Struttura della tabella `suggerimento_ai`
--

CREATE TABLE `suggerimento_ai` (
  `id` int(11) NOT NULL,
  `id_utente` int(11) DEFAULT NULL,
  `id_manga` int(11) DEFAULT NULL,
  `filtro_usato` varchar(255) DEFAULT NULL,
  `data` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struttura della tabella `utente`
--

CREATE TABLE `utente` (
  `id_utente` int(11) NOT NULL,
  `username` varchar(30) NOT NULL,
  `password` char(32) NOT NULL,
  `nome` varchar(20) NOT NULL,
  `cognome` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `utente`
--

INSERT INTO `utente` (`id_utente`, `username`, `password`, `nome`, `cognome`) VALUES
(1, 'admin', 'e64b78fc3bc91bcbc7dc232ba8ec59e0', 'Gioele', 'Montagna'),
(2, 'kurapika slut', '9ab0c7c5d23d8b833da4039638e9bbbf', 'yuri', 'jabami'),
(3, 'prova', '189bbbb00c5f1fb7fba9ad9285f193d1', 'Prova', 'prova'),
(4, 'BananananananananananaMan', '041ef4d92b5e87e2e12461b54991ec3c', 'Bananananananananana', 'Bananananananananana');

--
-- Indici per le tabelle scaricate
--

--
-- Indici per le tabelle `collezione_volumi`
--
ALTER TABLE `collezione_volumi`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_libreria_manga` (`id_libreria_manga`);

--
-- Indici per le tabelle `libreria`
--
ALTER TABLE `libreria`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_utente` (`id_utente`);

--
-- Indici per le tabelle `libreria_manga`
--
ALTER TABLE `libreria_manga`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_libreria` (`id_libreria`),
  ADD KEY `id_manga` (`id_manga`);

--
-- Indici per le tabelle `manga`
--
ALTER TABLE `manga`
  ADD PRIMARY KEY (`id`);

--
-- Indici per le tabelle `preferiti`
--
ALTER TABLE `preferiti`
  ADD PRIMARY KEY (`id_utente`,`id_manga`),
  ADD KEY `id_manga` (`id_manga`);

--
-- Indici per le tabelle `stato_lettura`
--
ALTER TABLE `stato_lettura`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_libreria_manga` (`id_libreria_manga`);

--
-- Indici per le tabelle `suggerimento_ai`
--
ALTER TABLE `suggerimento_ai`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_utente` (`id_utente`),
  ADD KEY `id_manga` (`id_manga`);

--
-- Indici per le tabelle `utente`
--
ALTER TABLE `utente`
  ADD PRIMARY KEY (`id_utente`),
  ADD UNIQUE KEY `username` (`username`);

--
-- AUTO_INCREMENT per le tabelle scaricate
--

--
-- AUTO_INCREMENT per la tabella `collezione_volumi`
--
ALTER TABLE `collezione_volumi`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=122;

--
-- AUTO_INCREMENT per la tabella `libreria`
--
ALTER TABLE `libreria`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT per la tabella `libreria_manga`
--
ALTER TABLE `libreria_manga`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=44;

--
-- AUTO_INCREMENT per la tabella `stato_lettura`
--
ALTER TABLE `stato_lettura`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT per la tabella `suggerimento_ai`
--
ALTER TABLE `suggerimento_ai`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT per la tabella `utente`
--
ALTER TABLE `utente`
  MODIFY `id_utente` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Limiti per le tabelle scaricate
--

--
-- Limiti per la tabella `collezione_volumi`
--
ALTER TABLE `collezione_volumi`
  ADD CONSTRAINT `collezione_volumi_ibfk_1` FOREIGN KEY (`id_libreria_manga`) REFERENCES `libreria_manga` (`id`) ON DELETE CASCADE;

--
-- Limiti per la tabella `libreria`
--
ALTER TABLE `libreria`
  ADD CONSTRAINT `libreria_ibfk_1` FOREIGN KEY (`id_utente`) REFERENCES `utente` (`id_utente`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limiti per la tabella `libreria_manga`
--
ALTER TABLE `libreria_manga`
  ADD CONSTRAINT `libreria_manga_ibfk_1` FOREIGN KEY (`id_libreria`) REFERENCES `libreria` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `libreria_manga_ibfk_2` FOREIGN KEY (`id_manga`) REFERENCES `manga` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limiti per la tabella `preferiti`
--
ALTER TABLE `preferiti`
  ADD CONSTRAINT `preferiti_ibfk_1` FOREIGN KEY (`id_utente`) REFERENCES `utente` (`id_utente`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `preferiti_ibfk_2` FOREIGN KEY (`id_manga`) REFERENCES `manga` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limiti per la tabella `stato_lettura`
--
ALTER TABLE `stato_lettura`
  ADD CONSTRAINT `stato_lettura_ibfk_1` FOREIGN KEY (`id_libreria_manga`) REFERENCES `libreria_manga` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limiti per la tabella `suggerimento_ai`
--
ALTER TABLE `suggerimento_ai`
  ADD CONSTRAINT `suggerimento_ai_ibfk_1` FOREIGN KEY (`id_utente`) REFERENCES `utente` (`id_utente`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `suggerimento_ai_ibfk_2` FOREIGN KEY (`id_manga`) REFERENCES `manga` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
