<?php
    session_start();
    require_once 'db_connect.php';
    require_once 'biljezenje_lib.php'; 
    
    if (!isset($_SESSION['tip']))
        $_SESSION['tip'] = 0;
    
    
    if ($_GET) {
        if (isset($_GET['action'])) {
            switch ($_GET['action']) {
                case 'KorisnikovaOcjenaEksponata': KorisnikovaOcjenaEksponata( $_GET['eksponat'] ); break;
                case 'ProsjecnaOcjenaEksponata': ProsjecnaOcjenaEksponata( $_GET['eksponat'] );  break;
                case 'BrojKomentaraEksponata': BrojKomentaraEksponata( $_GET['eksponat'] ); break;
                case 'DohvatiKomentareEksponata': DohvatiKomentareEksponata ( $_GET['eksponat'] ); break;
                case 'UnosKomentaraEksponataUBazu': UnosKomentaraEksponataUBazu ( $_GET['eksponat'], $_GET['NaslovKomentara'], $_GET['TekstKomentara'] ); break;
                case 'JeLiEksponatUOsobnojGaleriji': JeLiEksponatUOsobnojGaleriji ( $_GET['eksponat'] ); break;
                case 'DodajUkloniIzOsobneGalerije': DodajUkloniIzOsobneGalerije ( $_GET['eksponat'], $_GET['dodajUkloni'] ); break;
                case 'DohvatiNajpopularnijeEksponatePoPosjecenosti': DohvatiNajpopularnijeEksponatePoPosjecenosti(); break;
                case 'DohvatiNajpopularnijeEksponatePoOcjeni': DohvatiNajpopularnijeEksponatePoOcjeni(); break;
                case 'DohvatiNajpopularnijeSobe': DohvatiNajpopularnijeSobe( $_GET['sort'] ); break;
                case 'DohvatiNajpopularnijeOdjele': DohvatiNajpopularnijeOdjele( $_GET['sort'] ); break;
                case 'DohvatiSuvenire': DohvatiSuvenire( $_GET['eksponat'] ); break;
                case 'DodajSuvenirUSesiju': DodajSuvenirUSesiju( $_GET['idSuvenira'], $_GET['nazivSuvenira'], $_GET['cijenaSuvenira'], $_GET['novaUkupnaCijena'], $_GET['noviBrojStavki'] ); break;
                case 'AzurirajSuvenirUSesiji': AzurirajSuvenirUSesiji( $_GET['idSuvenira'], $_GET['kolicinaSuvenira'], $_GET['novaUkupnaCijena'], $_GET['noviBrojStavki'] ); break;
                case 'UkloniSuvenirIzSesije': UkloniSuvenirIzSesije( $_GET['idSuvenira'], $_GET['novaUkupnaCijena'], $_GET['noviBrojStavki'] ); break;
                case 'DohvatiLozinku': DohvatiLozinku(); break;
                case 'IzbrisiKosaricuIzSesije': IzbrisiKosaricuIzSesije(); break;
                case 'DohvatiEksponateIzSobe': DohvatiEksponateIzSobe( $_GET['brojSobe'] ); break;
                case 'DohvatiEksponateIzOdjela': DohvatiEksponateIzOdjela( $_GET['brojOdjela'] ); break;
                case 'DohvatiTipKorisnika': DohvatiTipKorisnika(); break;
                case 'KupiUlaznicu': KupiUlaznicu( $_GET['izlozba'] ); break;
                case 'DohvatiZapiseDnevnika' : DohvatiZapiseDnevnika(); break;
                case 'DohvatiPopisKorisnika' : DohvatiPopisKorisnika(); break;
            }
        }
    }
?>

<?php
    function KorisnikovaOcjenaEksponata($eksponat) {
        $naredba = "SELECT ocjena FROM ocjene WHERE korisnik = {$_SESSION['idKorisnika']} AND eksponat = $eksponat";
        $rezultat = Upit($naredba);

        echo '<?xml version="1.0"?>';
        echo '<ocjena>';
        
        if (mysqli_num_rows($rezultat) == 1) {
            $ocjena = mysqli_fetch_array($rezultat);
            //postavljamo rezultat na 2 decimale i množimo ga sa 100, zato jer se ova funkcija koristi za jRating plugin u kojem smo postavili da je maksimalna ocjena 500 (imamo 500 odsječaka na zvjezdicama)
            $ocjena = number_format($ocjena[0], 2) * 100;
            echo "<KorisnikovaOcjenaEksponata>$ocjena</KorisnikovaOcjenaEksponata>";
        } else {
            echo "<KorisnikovaOcjenaEksponata>0</KorisnikovaOcjenaEksponata>";
        }
        echo '</ocjena>';
    }
    
    
    function ProsjecnaOcjenaEksponata($eksponat) {
        $naredba = "SELECT AVG(ocjena) FROM ocjene WHERE eksponat = $eksponat";
        $rezultat = Upit($naredba);
        $ocjena = $rezultat->fetch_array();
        //postavljamo rezultat na 2 decimale i množimo ga sa 100, zato jer se ova funkcija koristi za jRating plugin u kojem smo postavili da je maksimalna ocjena 500 (imamo 500 odsječaka na zvjezdicama)
        $ocjena = number_format($ocjena[0], 2) * 100;
        
        echo '<?xml version="1.0"?>';
        echo '<ocjena>';
        echo "<ProsjecnaOcjenaEksponata>$ocjena</ProsjecnaOcjenaEksponata>";
        echo '</ocjena>';
    }
    
    
    function BrojKomentaraEksponata($eksponat) {
        $naredba = "SELECT COUNT(*) FROM komentari WHERE eksponat = $eksponat";
        $rezultat = Upit($naredba);
        $brojKomentara = $rezultat->fetch_array();
        
        echo '<?xml version="1.0"?>';
        echo '<komentari>';
        echo '<BrojKomentaraEksponata>'.$brojKomentara[0].'</BrojKomentaraEksponata>';
        echo '</komentari>';
    }
    
    
    function DohvatiKomentareEksponata($eksponat) {
        $naredba = "SELECT nazivKomentara, tekstKomentara, datumKomentiranja, korime FROM komentari JOIN korisnici ON komentari.komentator = korisnici.idKorisnika WHERE komentari.eksponat = $eksponat";
        $rezultat = Upit($naredba);
        
        $komentari = NULL;
        
        while ($komentar = $rezultat->fetch_array()) {
            $datum = date('d.m.Y H:i:s',strtotime($komentar['datumKomentiranja']));
            $komentar['datumKomentiranja'] = $datum;
            $komentari[] = $komentar;
        }
        
        
        echo '<?xml version="1.0"?>';
        echo '<komentari>';
        
        foreach ($komentari as $komentar) {
            echo '<komentar>';
                echo '<nazivKomentara>' . $komentar['nazivKomentara'] . '</nazivKomentara>';
                echo '<tekstKomentara>' . $komentar['tekstKomentara'] . '</tekstKomentara>';
                echo '<datumKomentiranja>' . $komentar['datumKomentiranja'] . '</datumKomentiranja>';
                echo '<korime>' . $komentar['korime'] . '</korime>';
            echo '</komentar>';
        }
        
        echo '</komentari>';
    }
    
    
    function UnosKomentaraEksponataUBazu ($eksponat, $naslov, $tekst) {
        $naredba = "INSERT INTO komentari VALUES (DEFAULT, '$naslov', '$tekst', '". VrijemeSPomakom() ."', $eksponat, {$_SESSION['idKorisnika']})";
        Upit($naredba);
        
        //dohvaćamo naziv eksponata iz ID-a kako bi ga mogli unijeti u dnevnik
        $rezultatPodupit = Upit("SELECT naziv FROM eksponati WHERE idEksponata = $eksponat");
        $nazivEksponata = $rezultatPodupit->fetch_assoc();
        UpisiUDnevnik("Dodao komentar na eksponat \"{$nazivEksponata['naziv']}\". Tekst komentara: \"$tekst\"");
    }
    
    
    function JeLiEksponatUOsobnojGaleriji ($eksponat) {
        $naredba = "SELECT * FROM osobnagalerija WHERE Eksponat = $eksponat AND idKorisnika = {$_SESSION['idKorisnika']}";
        $rezultat = Upit($naredba);
        
        $uGaleriji = 0;
        //ako je eksponat već u korisnikovoj osobnoj galeriji
        if (mysqli_num_rows($rezultat) == 1)
            $uGaleriji = 1;
        
        echo '<?xml version="1.0"?>';
        echo '<eksponati><eksponat>'.$uGaleriji.'</eksponat></eksponati>';
    }
    
    function DodajUkloniIzOsobneGalerije ($eksponat, $dodajUkloni) {
        //dohvaćamo naziv eksponata iz ID-a kako bi ga mogli unijeti u dnevnik
        $rezultatPodupit = Upit("SELECT naziv FROM eksponati WHERE idEksponata = $eksponat");
        $nazivEksponata = $rezultatPodupit->fetch_assoc();
        
        //ako je parametar 'data-id' bio 'ukloni', uklanjamo eksponat iz baze
        if ($dodajUkloni == 'ukloni') {
            $naredba = "DELETE FROM osobnagalerija WHERE Eksponat = $eksponat AND idKorisnika = {$_SESSION['idKorisnika']}";
            UpisiUDnevnik("Uklonio eksponat \"{$nazivEksponata['naziv']}\" iz osobne galerije");
        }
        elseif ($dodajUkloni == 'dodaj') {
            $naredba = "INSERT INTO osobnagalerija (Eksponat, idKorisnika) VALUES ($eksponat, {$_SESSION['idKorisnika']})";
            UpisiUDnevnik("Dodao eksponat \"{$nazivEksponata['naziv']}\" u osobnu galeriju");
        }
        
        Upit($naredba);
    }
    
    
    //Argument "promijenjenaNaredba" označava da funkcija "DohvatiNajpopularnijeEksponatePoOcjeni" poziva ovu. Budući da je njihova struktura ista, a razlikuju se samo u naredbi, koristimo navedeni argument
    function DohvatiNajpopularnijeEksponatePoPosjecenosti($promijenjenaNaredba=false) {
        $naredba = "SELECT idEksponata, naziv, opisEksponata, godinaPorijekla, prijeKrista, brojPregleda, slika, OAutoru, Orazdoblju, kljucneRijeci, vidljivostEksponata, vidljivostSobe, vidljivostOdjela FROM eksponati JOIN sobe ON eksponati.soba = sobe.brojSobe JOIN odjeli ON sobe.Odjel = odjeli.brojOdjela ORDER BY brojPregleda DESC";
        
        if ($promijenjenaNaredba != false) {
            $naredba = $promijenjenaNaredba;
        }
        
        $rezultat = Upit($naredba);
        
        $eksponati = NULL;
        
        while ($eksponat = $rezultat->fetch_array()) {
            /*
             * Da bi se eksponat prikazao on mora zadovoljiti tri uvjeta 
             * s obzirom na korisnika koji ga želi pregledati, 
             * a oni su: vidiljivost sobe eksponata, 
             * vidljivost odjela eksponata i vidljivost samog eksponata
             */
            if ($_SESSION['tip'] >= 2 && $eksponat['vidljivostSobe'] <= 2        ||      $_SESSION['tip'] == 1 && $eksponat['vidljivostSobe'] <= 1       ||      $eksponat['vidljivostSobe']==0) {
                if ($_SESSION['tip'] >= 2 && $eksponat['vidljivostOdjela'] <= 2      ||      $_SESSION['tip'] == 1 && $eksponat['vidljivostOdjela'] <= 1        || $eksponat['vidljivostOdjela'] == 0) {
                    if ($_SESSION['tip'] >= 2 && $eksponat['vidljivostEksponata'] <= 2      ||      $_SESSION['tip'] == 1 && $eksponat['vidljivostEksponata'] <= 1      ||      $eksponat['vidljivostEksponata'] == 0) {
                        //ključne riječi (koje se nalaze u stringu odvojene zarezima, prebacimo u polje
                        $kljucneRijeci = explode(',', $eksponat['kljucneRijeci']);
                        $eksponati[] = $eksponat;
                        //odmah povećavamo broj pregleda (za prikaz) svakog eksponata jer je logično da se broj pregleda za ove eksponate povećava kada se oni prikažu korisniku (a to je sada)
                        $eksponati[count($eksponati)-1]['brojPregleda']++;
                        //polje s ključnim riječima dodamo u polje eksponata
                        $eksponati[count($eksponati)-1]['kljucneRijeci'] = $kljucneRijeci;
                    }
                }
            }
        }
        
        // također povećavamo broj pregleda u BAZI PODATAKA za svaki prikazani eksponat
        foreach ($eksponati as $eksponat) {            
            $naredba = "UPDATE eksponati SET brojPregleda = {$eksponat['brojPregleda']} WHERE idEksponata = {$eksponat['idEksponata']}";
            Upit($naredba);
        }
        
        echo '<?xml version="1.0"?>';
        echo '<eksponati>';
        
        foreach ($eksponati as $eksponat) {
            echo '<eksponat>';
                echo '<idEksponata>'.$eksponat['idEksponata'].'</idEksponata>';
                echo '<naziv>'.$eksponat['naziv'].'</naziv>';
                echo '<opisEksponata>'.$eksponat['opisEksponata'].'</opisEksponata>';
                echo '<godinaPorijekla>'.$eksponat['godinaPorijekla'].'</godinaPorijekla>';
                echo '<prijeKrista>'.$eksponat['prijeKrista'].'</prijeKrista>';
                echo '<slika>'.$eksponat['slika'].'</slika>';
                echo '<OAutoru>'.$eksponat['OAutoru'].'</OAutoru>';
                echo '<Orazdoblju>'.$eksponat['Orazdoblju'].'</Orazdoblju>';
                echo '<kljucneRijeci>';
                    foreach ($eksponat['kljucneRijeci'] as $kljucnaRijec) {
                        echo "<kljucnaRijec>$kljucnaRijec</kljucnaRijec>";
                    }
                echo '</kljucneRijeci>'; 
                echo '<brojPregleda>'.$eksponat['brojPregleda'].'</brojPregleda>';
            echo '</eksponat>';
        }
        
        echo '</eksponati>';
    }
    
    
    
    function DohvatiNajpopularnijeEksponatePoOcjeni() {
        $naredba = "SELECT idEksponata, naziv, opisEksponata, godinaPorijekla, prijeKrista, brojPregleda, slika, OAutoru, Orazdoblju, kljucneRijeci, AVG(ocjena) as prosjecnaOcjena, vidljivostEksponata, vidljivostSobe, vidljivostOdjela FROM ocjene RIGHT JOIN eksponati on ocjene.eksponat = eksponati.idEksponata JOIN sobe ON eksponati.soba = sobe.brojSobe JOIN odjeli ON sobe.Odjel = odjeli.brojOdjela GROUP BY idEksponata ORDER BY prosjecnaOcjena DESC";
        DohvatiNajpopularnijeEksponatePoPosjecenosti($naredba);
    }
    
    
    
    //Argument "promijenjenaNaredba" označava da funkcija "DohvatiNajpopularnijeEksponatePoOcjeni" poziva ovu. Budući da je njihova struktura ista, a razlikuju se samo u naredbi, koristimo navedeni argument
    function DohvatiNajpopularnijeSobe($sort) {
        if (!isset($_SESSION['tip']))
            $_SESSION['tip'] = 0;
        
        //za svaki podupit moramo podesiti da broji postavke samo za one eksponate kojima korisnik ima pristup (koji su mu vidljivi)
        $podupitPosjecenost = "SELECT AVG(brojPregleda) FROM eksponati JOIN sobe ON eksponati.soba = sobe.brojSobe JOIN odjeli ON sobe.Odjel = odjeli.brojOdjela WHERE soba = sobeGlavniUpit.brojSobe AND vidljivostEksponata <= {$_SESSION['tip']} AND vidljivostSobe <= {$_SESSION['tip']} AND vidljivostOdjela <= {$_SESSION['tip']}";
        $poduitOcjena = "SELECT AVG(ocjena) FROM odjeli JOIN sobe ON odjeli.brojOdjela = sobe.Odjel JOIN eksponati on sobe.brojSobe = eksponati.soba JOIN ocjene on eksponati.idEksponata = ocjene.eksponat WHERE eksponati.soba = sobeGlavniUpit.brojSobe AND vidljivostEksponata <= {$_SESSION['tip']} AND vidljivostSobe <= {$_SESSION['tip']} AND vidljivostOdjela <= {$_SESSION['tip']}";
        $podupitBrojEksponata = "SELECT COUNT(*) FROM eksponati JOIN sobe ON eksponati.soba = sobe.brojSobe JOIN odjeli ON sobe.Odjel = odjeli.brojOdjela WHERE soba = sobeGlavniUpit.brojSobe AND vidljivostEksponata <= {$_SESSION['tip']} AND vidljivostSobe <= {$_SESSION['tip']} AND vidljivostOdjela <= {$_SESSION['tip']}";
        
        //prikazujemo ponovno samo eksponate kojima korisnik ima pristup
        $naredba = "SELECT DISTINCT brojSobe, nazivSobe, nazivOdjela, ($podupitBrojEksponata) as brojEksponata, ($podupitPosjecenost) as posjecenost, ($poduitOcjena) as ocjena FROM odjeli JOIN sobe sobeGlavniUpit ON odjeli.brojOdjela = sobeGlavniUpit.Odjel JOIN eksponati on sobeGlavniUpit.brojSobe = eksponati.soba WHERE vidljivostEksponata <= {$_SESSION['tip']} AND vidljivostSobe <= {$_SESSION['tip']} AND vidljivostOdjela <= {$_SESSION['tip']} ORDER BY $sort desc";
        
        $rezultat = Upit($naredba);
        
        $sobe = NULL;
        
        
        /*
        * Da bi se eksponat prikazao on mora zadovoljiti tri uvjeta 
        * s obzirom na korisnika koji ga želi pregledati, 
        * a oni su: vidiljivost sobe eksponata, 
        * i vidljivost odjela eksponata
        */
        while ($soba = $rezultat->fetch_array()) {
            $sobe[] = $soba;
        }
        
        
        echo '<?xml version="1.0"?>';
        echo '<sobe>';
        
        foreach ($sobe as $soba) {
            echo '<soba>';
                echo '<brojSobe>'.$soba['brojSobe'].'</brojSobe>';          //id sobe
                echo '<nazivSobe>'.$soba['nazivSobe'].'</nazivSobe>';       //naziv sobe
                echo '<nazivOdjela>'.$soba['nazivOdjela'].'</nazivOdjela>'; //odjel kojem soba pripada
                echo '<brojEksponata>'.$soba['brojEksponata'].'</brojEksponata>';          //ukupni broj korisniku vidljivih eksponata u sobi
                echo '<posjecenost>'. round($soba['posjecenost']) .'</posjecenost>'; //prosječno posjeta po eksponatu u sobi
                echo '<ocjena>'. number_format($soba['ocjena'], 2) .'</ocjena>';    //prosječna ocjena po eskponatu u sobi na 2 decimale (0-5)
            echo '</soba>';
        }

        
        echo '</sobe>';
    }
    
    
    
    //Argument "promijenjenaNaredba" označava da funkcija "DohvatiNajpopularnijeEksponatePoOcjeni" poziva ovu. Budući da je njihova struktura ista, a razlikuju se samo u naredbi, koristimo navedeni argument
    function DohvatiNajpopularnijeOdjele($sort) {
        if (!isset($_SESSION['tip']))
            $_SESSION['tip'] = 0;
        
        //za svaki podupit moramo podesiti da broji postavke samo za one eksponate kojima korisnik ima pristup (koji su mu vidljivi)
        $podupitPosjecenost = "SELECT AVG(brojPregleda) FROM eksponati JOIN sobe ON eksponati.soba = sobe.brojSobe JOIN odjeli ON odjeli.brojOdjela = sobe.Odjel WHERE sobe.Odjel = odjeliGlavniUpit.brojOdjela AND vidljivostEksponata <= {$_SESSION['tip']} AND vidljivostSobe <= {$_SESSION['tip']} AND vidljivostOdjela <= {$_SESSION['tip']}";
        $poduitOcjena = "SELECT AVG(ocjena) FROM odjeli JOIN sobe ON odjeli.brojOdjela = sobe.Odjel JOIN eksponati ON sobe.brojSobe = eksponati.soba JOIN ocjene ON eksponati.idEksponata = ocjene.eksponat WHERE sobe.Odjel = odjeliGlavniUpit.brojOdjela AND vidljivostEksponata <= {$_SESSION['tip']} AND vidljivostSobe <= {$_SESSION['tip']} AND vidljivostOdjela <= {$_SESSION['tip']}";
        $podupitBrojEksponata = "SELECT COUNT(*) FROM eksponati JOIN sobe ON eksponati.soba = sobe.brojSobe JOIN odjeli ON odjeli.brojOdjela = sobe.Odjel WHERE sobe.Odjel = odjeliGlavniUpit.brojOdjela AND vidljivostEksponata <= {$_SESSION['tip']} AND vidljivostSobe <= {$_SESSION['tip']} AND vidljivostOdjela <= {$_SESSION['tip']}";
        
        //prikazujemo ponovno samo eksponate kojima korisnik ima pristup
        //$naredba = "SELECT DISTINCT brojOdjela, nazivOdjela, opisOdjela, ($podupitBrojEksponata) as brojEksponata, ($podupitPosjecenost) as posjecenost, ($poduitOcjena) as ocjena FROM odjeli odjeliGlavniUpit JOIN sobe sobeGlavniUpit ON odjeli.brojOdjela = sobeGlavniUpit.Odjel JOIN eksponati ON sobeGlavniUpit.brojSobe = eksponati.soba WHERE vidljivostEksponata <= {$_SESSION['tip']} ORDER BY posjecenost desc";
        $naredba = "SELECT DISTINCT brojOdjela, nazivOdjela, opisOdjela, ($podupitBrojEksponata) as brojEksponata, ($podupitPosjecenost) as posjecenost, ($poduitOcjena) as ocjena FROM odjeli odjeliGlavniUpit JOIN sobe ON odjeliGlavniUpit.brojOdjela = sobe.Odjel JOIN eksponati ON sobe.brojSobe = eksponati.soba WHERE vidljivostEksponata <= {$_SESSION['tip']} AND vidljivostSobe <= {$_SESSION['tip']} AND vidljivostOdjela <= {$_SESSION['tip']} ORDER BY $sort DESC";
        
        $rezultat = Upit($naredba);
        
        $odjeli = NULL;
        
        
        /*
        * Da bi se eksponat prikazao on mora zadovoljiti tri uvjeta 
        * s obzirom na korisnika koji ga želi pregledati, 
        * a oni su: vidiljivost sobe eksponata, 
        * i vidljivost odjela eksponata
        */
        while ($odjel = $rezultat->fetch_array()) {
            $odjeli[] = $odjel;
        }
        
        
        echo '<?xml version="1.0"?>';
        echo '<odjeli>';
        
        foreach ($odjeli as $odjel) {
            echo '<odjel>';
                echo '<brojOdjela>'.$odjel['brojOdjela'].'</brojOdjela>';          //id sobe
                echo '<nazivOdjela>'.$odjel['nazivOdjela'].'</nazivOdjela>';       //naziv odjela
                echo '<opisOdjela>'.$odjel['opisOdjela'].'</opisOdjela>';          //opis odjela
                echo '<brojEksponata>'.$odjel['brojEksponata'].'</brojEksponata>';          //ukupni broj korisniku vidljivih eksponata u sobi
                echo '<posjecenost>'. round($odjel['posjecenost']) .'</posjecenost>'; //prosječno posjeta po eksponatu u sobi
                echo '<ocjena>'. number_format($odjel['ocjena'], 2) .'</ocjena>';    //prosječna ocjena po eskponatu u sobi na 2 decimale (0-5)
            echo '</odjel>';
        }
        
        echo '</odjeli>';
    }
    
    
    
    function DohvatiSuvenire( $eksponat ) {
        $naredba = "SELECT idSuvenira, naziv, opis, cijena FROM suveniri WHERE eksponat = $eksponat";
        $rezultat = Upit($naredba);
        
        $suveniri = NULL;
        
        while($suvenir = $rezultat->fetch_array()) {
            $suveniri[] = $suvenir;
        }
        
        echo '<?xml version="1.0"?>';
        echo '<suveniri>';
        
        if (count($suveniri) > 0) {
            foreach ($suveniri as $suvenir) {
                echo '<suvenir>';
                    echo '<idSuvenira>'.$suvenir['idSuvenira'].'</idSuvenira>';
                    echo '<naziv>'.$suvenir['naziv'].'</naziv>';
                    echo '<opis>'.$suvenir['opis'].'</opis>';
                    echo '<cijena>'.$suvenir['cijena'].'</cijena>';
                echo '</suvenir>';
            }
        }
        
        echo '</suveniri>';
    }
    
    
    
    function DodajSuvenirUSesiju($idSuvenira, $nazivSuvenira, $cijenaSuvenira, $novaUkupnaCijena, $noviBrojStavki) {
        //kada dodajemo suvenir, njegova inicijalna količina je uvijek 1
        $kolicinaSuvenira = 1;
        $_SESSION['kosarica']['stavke'][] = array('idSuvenira' => $idSuvenira, 'nazivSuvenira' => $nazivSuvenira, 'cijenaSuvenira' => $cijenaSuvenira, 'kolicinaSuvenira' => $kolicinaSuvenira);
        
        $_SESSION['kosarica']['ukupnaCijena'] = $novaUkupnaCijena;
        $_SESSION['kosarica']['brojStavki'] = $noviBrojStavki;
    }
    
    
    function AzurirajSuvenirUSesiji($idSuvenira, $kolicinaSuvenira, $novaUkupnaCijena, $noviBrojStavki) {
        $i = 0;
        foreach($_SESSION['kosarica']['stavke'] as $suvenir) {
            if ($suvenir['idSuvenira'] == $idSuvenira) {
                $_SESSION['kosarica']['stavke'][$i]['kolicinaSuvenira'] = $kolicinaSuvenira;
            }
            $i++;
        }
        $_SESSION['kosarica']['ukupnaCijena'] = $novaUkupnaCijena;
        $_SESSION['kosarica']['brojStavki'] = $noviBrojStavki;
    }
    
    
    function UkloniSuvenirIzSesije($idSuvenira, $novaUkupnaCijena, $noviBrojStavki) {
        $i = 0;
        foreach($_SESSION['kosarica']['stavke'] as $suvenir) {
            if ($suvenir['idSuvenira'] == $idSuvenira) {
                unset($_SESSION['kosarica']['stavke'][$i]);
            }
            $i++;
        }
        $_SESSION['kosarica']['ukupnaCijena'] = $novaUkupnaCijena;
        $_SESSION['kosarica']['brojStavki'] = $noviBrojStavki;
    }
    
    
    function DohvatiLozinku() {
        $naredba = "SELECT lozinka FROM korisnici WHERE idKorisnika = {$_SESSION['idKorisnika']}";
        $rezultat = Upit($naredba);
        
        $lozinka = $rezultat->fetch_array();
        
        echo '<?xml version="1.0"?>';
        echo '<lozinke>';
        echo '<lozinka>'. $lozinka[0] .'</lozinka>';
        echo '</lozinke>';
    }
    
    
    function IzbrisiKosaricuIzSesije() {        
        //svaki kupljeni suvenir bilježimo u log
        $aktivnost = "Kupio suvenire: ";
        foreach ($_SESSION['kosarica']['stavke'] as $stavka) {
            $aktivnost .= $stavka['nazivSuvenira'] . " (" . $stavka['kolicinaSuvenira'] . " kom), ";
        }
        UpisiUDnevnik($aktivnost);
        
        unset($_SESSION['kosarica']);
    }
    
    
    function DohvatiEksponateIzSobe($brojSobe) {
        //prikazujemo samo one eksponate kojima korisnik ima pristup (i čijim sobama i odjelima ima pristup)
        $naredba = "SELECT idEksponata, naziv FROM eksponati JOIN sobe ON eksponati.soba = sobe.brojSobe JOIN odjeli ON sobe.Odjel = odjeli.brojOdjela WHERE soba = $brojSobe AND vidljivostEksponata <= {$_SESSION['tip']} AND vidljivostSobe <= {$_SESSION['tip']} AND vidljivostOdjela <= {$_SESSION['tip']} ORDER BY naziv";
        $rezultat = Upit($naredba);
        
        $eksponati = NULL;
        
        while($eksponat = $rezultat->fetch_array()) {
            $eksponati[] = $eksponat;
        }
        
        echo '<?xml version="1.0"?>';
        echo '<eksponati>';
        
        foreach ($eksponati as $eksponat) {
            echo '<eksponat>';
                echo '<idEksponata>'. $eksponat['idEksponata']. '</idEksponata>';
                echo '<naziv>'. $eksponat['naziv']. '</naziv>';
            echo '</eksponat>';
        }
        
        echo '</eksponati>';
    }
    
    
    function DohvatiEksponateIzOdjela($brojOdjela) {
        //prikazujemo samo one eksponate kojima korisnik ima pristup (i čijim sobama i odjelima ima pristup)
        $naredba = "SELECT idEksponata, naziv FROM eksponati JOIN sobe ON eksponati.soba = sobe.brojSobe JOIN odjeli ON sobe.Odjel = odjeli.brojOdjela WHERE sobe.Odjel = $brojOdjela AND vidljivostEksponata <= {$_SESSION['tip']} AND vidljivostSobe <= {$_SESSION['tip']} AND vidljivostOdjela <= {$_SESSION['tip']} ORDER BY naziv";
        $rezultat = Upit($naredba);
        
        $eksponati = NULL;
        
        while($eksponat = $rezultat->fetch_array()) {
            $eksponati[] = $eksponat;
        }
        
        echo '<?xml version="1.0"?>';
        echo '<eksponati>';
        
        foreach ($eksponati as $eksponat) {
            echo '<eksponat>';
                echo '<idEksponata>'. $eksponat['idEksponata']. '</idEksponata>';
                echo '<naziv>'. $eksponat['naziv']. '</naziv>';
            echo '</eksponat>';
        }
        
        echo '</eksponati>';
    }
    
    
    function DohvatiTipKorisnika() {
        echo '<?xml version="1.0"?>';
        echo '<korisnik><tipKorisnika>'. $_SESSION['tip'] .'</tipKorisnika></korisnik>';
    }
    
    
    function KupiUlaznicu( $izlozba ) {
        $naredba = "INSERT INTO ulaznice VALUES ({$_SESSION['idKorisnika']}, $izlozba)";
        Upit($naredba);
        
        //dohvaćamo ime izložbe kako bi ga mogli upisati u dnevnik
        $naredba = "SELECT nazivIzlozbe FROM kalendarizlozbi WHERE brojIzlozbe = $izlozba";
        $rezultat = Upit($naredba);
        $nazivIzlozbe = $rezultat->fetch_assoc();
        
        UpisiUDnevnik("Kupio ulaznicu za izložbu \"{$nazivIzlozbe['nazivIzlozbe']}\"");
    }
    
    
    function DohvatiZapiseDnevnika() {
        $logZapisi = null;
        
        $naredba = "SELECT korisnici.korime as korisnik, aktivnost, vrijeme, ipAdresa, preglednik FROM log JOIN korisnici ON log.korisnik = korisnici.idKorisnika";
        $rezultat = Upit($naredba);
        
        while ($zapis = $rezultat->fetch_assoc()) {
            //pretvaramo vrijeme u oblik za prikaz
            $zapis['vrijeme'] = date("d-m-Y H:i:s", $zapis['vrijeme']);
            $logZapisi[] = $zapis;
        }
        
        echo '<?xml version="1.0"?>';
        echo '<zapisi>';
        
        if (count($logZapisi) > 0) {
            foreach ($logZapisi as $zapis) {
                echo '<zapis>';
                    echo '<korisnik>'. $zapis['korisnik'] .'</korisnik>';
                    echo '<aktivnost>'. $zapis['aktivnost'] .'</aktivnost>';
                    echo '<vrijeme>'. $zapis['vrijeme'] .'</vrijeme>';
                    echo '<ipAdresa>'. $zapis['ipAdresa'] .'</ipAdresa>';
                    echo '<preglednik>'. $zapis['preglednik'] .'</preglednik>';
                echo '</zapis>';
            }
        }
        
        echo '</zapisi>';
    }
    
    
    function DohvatiPopisKorisnika() {
        $korisnici = null;
        
        $naredba = "SELECT idKorisnika, korime, ime, prezime, email, brojPrijava, zakljucan, aktiviran FROM korisnici";
        $rezultat = Upit($naredba);
        
        while ($korisnik = $rezultat->fetch_array()) {
            if ($korisnik['zakljucan'] == 1)
                $korisnik['zakljucan'] = 'Da';
            else
                $korisnik['zakljucan'] = 'Ne';
            
            if ($korisnik['aktiviran'] == 1)
                $korisnik['aktiviran'] = 'Da';
            else
                $korisnik['aktiviran'] = 'Ne';
            
            $korisnici[] = $korisnik;
        }
        
        
        echo '<?xml version="1.0"?>';
        echo '<korisnici>';
        
        if (count($korisnici) > 0) {
            foreach ($korisnici as $korisnik) {
                echo '<korisnik>';
                    echo '<idKorisnika>'. $korisnik['idKorisnika'] .'</idKorisnika>';
                    echo '<korime>'. $korisnik['korime'] .'</korime>';
                    echo '<brojPrijava>'. $korisnik['brojPrijava'] .'</brojPrijava>';
                    echo '<zakljucan>'. $korisnik['zakljucan'] .'</zakljucan>';
                    echo '<aktiviran>'. $korisnik['aktiviran'] .'</aktiviran>';
                echo '</korisnik>';
            }
        }
        
        echo '</korisnici>';
    }
?>