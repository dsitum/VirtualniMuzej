<?php
    session_start();
    require_once 'db_connect.php';

    $eksponati = NULL;

    $naredba = "";
    
    if(!$_GET) {
        header("Location: ../odjeli_sobe.php"); die();
    }
    
    if (isset($_GET['soba'])) {
        $naredba = "SELECT idEksponata, naziv, opisEksponata, godinaPorijekla, prijeKrista, brojPregleda, slika, OAutoru, Orazdoblju, kljucneRijeci FROM eksponati JOIN sobe ON eksponati.soba = sobe.brojSobe JOIN odjeli ON sobe.Odjel = odjeli.brojOdjela WHERE brojSobe = {$_GET["soba"]} AND vidljivostEksponata <= {$_SESSION['tip']} AND vidljivostSobe <= {$_SESSION['tip']} AND vidljivostOdjela <= {$_SESSION['tip']}";
    }
    
    if (isset($_GET['odjel']))
        $naredba = "SELECT idEksponata, naziv, opisEksponata, godinaPorijekla, prijeKrista, brojPregleda, slika, OAutoru, Orazdoblju, kljucneRijeci, nazivOdjela FROM eksponati JOIN sobe ON eksponati.soba = sobe.brojSobe JOIN odjeli ON sobe.Odjel = odjeli.brojOdjela WHERE brojOdjela = {$_GET["odjel"]} AND vidljivostEksponata <= {$_SESSION['tip']} AND vidljivostSobe <= {$_SESSION['tip']} AND vidljivostOdjela <= {$_SESSION['tip']}";
        
    if (isset($_GET['eksponat']))
        $naredba = "SELECT idEksponata, naziv, opisEksponata, godinaPorijekla, prijeKrista, brojPregleda, slika, OAutoru, Orazdoblju, kljucneRijeci FROM eksponati JOIN sobe ON eksponati.soba = sobe.brojSobe JOIN odjeli ON sobe.Odjel = odjeli.brojOdjela WHERE idEksponata = {$_GET["eksponat"]} AND vidljivostEksponata <= {$_SESSION['tip']} AND vidljivostSobe <= {$_SESSION['tip']} AND vidljivostOdjela <= {$_SESSION['tip']}";
    
    if (isset($_GET['kljucnaRijec']))
        $naredba = "SELECT idEksponata, naziv, opisEksponata, godinaPorijekla, prijeKrista, brojPregleda, slika, OAutoru, Orazdoblju, kljucneRijeci FROM eksponati JOIN sobe ON eksponati.soba = sobe.brojSobe JOIN odjeli ON sobe.Odjel = odjeli.brojOdjela WHERE kljucneRijeci LIKE '%{$_GET["kljucnaRijec"]}%' AND vidljivostEksponata <= {$_SESSION['tip']} AND vidljivostSobe <= {$_SESSION['tip']} AND vidljivostOdjela <= {$_SESSION['tip']} ORDER BY naziv";
        
    if (isset($_GET['osobnaGalerija']))
        $naredba = "SELECT idEksponata, naziv, opisEksponata, godinaPorijekla, prijeKrista, brojPregleda, slika, OAutoru, Orazdoblju, kljucneRijeci FROM osobnagalerija JOIN eksponati ON osobnagalerija.Eksponat = eksponati.idEksponata JOIN sobe ON eksponati.soba = sobe.brojSobe JOIN odjeli ON sobe.Odjel = odjeli.brojOdjela WHERE osobnagalerija.idKorisnika = {$_GET['osobnaGalerija']} AND vidljivostEksponata <= {$_SESSION['tip']} AND vidljivostSobe <= {$_SESSION['tip']} AND vidljivostOdjela <= {$_SESSION['tip']} ORDER BY naziv";
        
    if (isset($_GET['izlozba'])) {
        //stvaramo 3 upita. Prvi će prikazivati sve eksponate koji su unutar neke izložbe, drugi će prikazivati sve sobe unutar izložbe (tj. eksponate unutar soba koje su obuhvaćene izložbama) i treći će to napraviti isto za odjele (prikazati eksponate)
        $naredba1 = "SELECT idEksponata, naziv, opisEksponata, godinaPorijekla, prijeKrista, brojPregleda, slika, OAutoru, Orazdoblju, kljucneRijeci FROM eksponati JOIN pristupeksponatima ON pristupeksponatima.eksponat = eksponati.idEksponata WHERE pristupeksponatima.izlozba = {$_GET['izlozba']}";
        $naredba2 = "SELECT idEksponata, naziv, opisEksponata, godinaPorijekla, prijeKrista, brojPregleda, slika, OAutoru, Orazdoblju, kljucneRijeci FROM eksponati JOIN sobe ON eksponati.soba = sobe.brojSobe JOIN pristupsobama ON pristupsobama.soba = sobe.brojSobe WHERE pristupsobama.izlozba = {$_GET['izlozba']}";
        $naredba3 = "SELECT idEksponata, naziv, opisEksponata, godinaPorijekla, prijeKrista, brojPregleda, slika, OAutoru, Orazdoblju, kljucneRijeci FROM eksponati JOIN sobe ON eksponati.soba = sobe.brojSobe JOIN odjeli ON sobe.Odjel = odjeli.brojOdjela JOIN pristupodjelima ON pristupodjelima.odjel = odjeli.brojOdjela WHERE pristupodjelima.izlozba = {$_GET['izlozba']}";
        //spajamo sva tri upita i sortiramo prikaz po nazivu pojedinog eksponata
        $naredba = "$naredba1 UNION DISTINCT $naredba2 UNION DISTINCT $naredba3 ORDER BY 2";
    }
        
    $rezultat = Upit($naredba);
    
    while ($eksponat = $rezultat->fetch_array()) {
        //ključne riječi (koje se nalaze u stringu odvojene zarezima, prebacimo u polje
        $kljucneRijeci = explode(',', $eksponat['kljucneRijeci']);
        $eksponati[] = $eksponat;
        //odmah povećavamo broj pregleda (za prikaz) svakog eksponata jer je logično da se broj pregleda za ove eksponate povećava kada se oni prikažu korisniku (a to je sada)
        $eksponati[count($eksponati)-1]['brojPregleda']++;
        //polje s ključnim riječima dodamo u polje eksponata
        $eksponati[count($eksponati)-1]['kljucneRijeci'] = $kljucneRijeci;
    }
?>

<?php
     // također povećava broj pregleda u BAZI PODATAKA za svaki prikazani eksponat
     if (!is_null($eksponati)) {
        foreach ($eksponati as $eksponat) {            
            $naredba = "UPDATE eksponati SET brojPregleda = {$eksponat['brojPregleda']} WHERE idEksponata = {$eksponat['idEksponata']}";
            Upit($naredba);
        }
     }
?>

<?php
    require_once '../prilozi/smarty.php';
    
    $smarty->assign('eksponati', $eksponati);
    if (isset($_GET['odjel'])) {
        if (count($eksponati) > 0) {
            $smarty->assign('naslov', 'Eksponati odjela: ' . $eksponati[0]['nazivOdjela']);
        }
    }
    
    $smarty->display('php/eksponati.tpl');
?>