<?php
    session_start();
    require_once 'db_connect.php';
    require_once 'biljezenje_lib.php';
    
    $odjel = null;
    $soba = null;
    $eksponat = null;
    $sviOdjeli = null;
    $sveSobe = null;
    
    if ($_SESSION['tip'] < 2) {
        UpisiUDnevnik("Pokušao uređivati sadržaj muzeja");
        header("Location: ../odjeli_sobe.php"); die();
    }
    
    
    if ($_GET['action'] == 'dodaj') {
        if ($_GET['sadrzaj'] == 'soba') {
            $sviOdjeli = DohvatiSveOdjele();
        }
        
        if ($_GET['sadrzaj'] == 'eksponat') {
            $sveSobe = DohvatiSveSobe();
        }
        
        if ($_GET['sadrzaj'] == 'izlozba') {
            $sadrzajIzlozbe = DohvatiSadrzajIzlozbe();
        }
    }
    
    if ($_GET['action'] == 'uredi') {
        if ($_GET['sadrzaj'] == 'odjel') {
            $naredba = "SELECT * FROM odjeli WHERE brojOdjela = {$_GET['brojOdjela']}";
            $rezultat = Upit($naredba);
            $odjel = $rezultat->fetch_assoc();
        }
        
        if ($_GET['sadrzaj'] == 'soba') {
            $naredba = "SELECT * FROM sobe WHERE brojSobe = {$_GET['brojSobe']}";
            $rezultat = Upit($naredba);
            $soba = $rezultat->fetch_assoc();
            
            $sviOdjeli = DohvatiSveOdjele();
        }
        
        if ($_GET['sadrzaj'] == 'eksponat') {
            $naredba = "SELECT * FROM eksponati WHERE idEksponata = {$_GET['idEksponata']}";
            $rezultat = Upit($naredba);
            $eksponat = $rezultat->fetch_assoc();
            
            $sveSobe = DohvatiSveSobe();
        }
        
        if ($_GET['sadrzaj'] == 'izlozba') {
            $naredba = "SELECT * FROM kalendarizlozbi WHERE brojIzlozbe = {$_GET['brojIzlozbe']}";
            $rezultat = Upit($naredba);
            $izlozba = $rezultat->fetch_assoc();
            //mijenjamo format vremena kako bi se on mogao prikazati u html5 <input type="datetime-local">
            $izlozba['vrijemeOtvaranja'] = date("Y-m-d\TH:i", strtotime( $izlozba['vrijemeOtvaranja'] ));
            $izlozba['vrijemeZatvaranja'] = date("Y-m-d\TH:i", strtotime( $izlozba['vrijemeZatvaranja'] ));
            
            $sadrzajIzlozbe = DohvatiSadrzajIzlozbe( $_GET['brojIzlozbe'] );
        }
    }
?>
<?php
    //ovaj dio se izvršava kada je jedan od obrazaca poslan (kada bazu treba ažurirati dodavanjem sadržaja, aužuriranjem ili brisanjem)
    if ($_POST) {        
        if ($_POST['action'] == 'dodaj') {
            if ($_POST['sadrzaj'] == 'odjel') {
                $naredba = "INSERT INTO odjeli VALUES (DEFAULT, '{$_POST['nazivOdjela']}', '{$_POST['opisOdjela']}', {$_POST['vidljivostOdjela']})";
                Upit($naredba);
                UpisiUDnevnik("Dodao novi odjel: {$_POST['nazivOdjela']}");
            }
            
            if($_POST['sadrzaj'] == 'soba') {
                $naredba = "INSERT INTO sobe VALUES (DEFAULT, '{$_POST['nazivSobe']}', {$_POST['Odjel']}, {$_POST['vidljivostSobe']})";
                Upit($naredba);
                UpisiUDnevnik("Dodao novu sobu: {$_POST['nazivSobe']}");
            }
            
            if($_POST['sadrzaj'] == 'eksponat') {
                //uploadamo novu sliku (koju je korisnik odabrao)
                $imeNoveSlike = UploadSlike();
                
                //ako neka od polja nisu unesena, postavljamo ih na prazan string (kako ne bi bilo grešaka prilikom unosa u bazu)
                $naredba = "INSERT INTO eksponati VALUES (DEFAULT, '{$_POST['naziv']}', '{$_POST['opisEksponata']}', ". (empty($_POST['godinaPorijekla']) ? 'NULL' : $_POST['godinaPorijekla']) .", ". (empty($_POST['prijeKrista']) ? 'DEFAULT' : $_POST['prijeKrista']) .", 0, '$imeNoveSlike', {$_POST['soba']}, ". (empty($_POST['OAutoru']) ? 'NULL' : "'{$_POST['OAutoru']}'") .", ". (empty($_POST['Orazdoblju']) ? 'NULL' : "'{$_POST['Orazdoblju']}'") .", ". (empty($_POST['kljucneRijeci']) ? 'NULL' : "'{$_POST['kljucneRijeci']}'") .", {$_POST['vidljivostEksponata']})";
                Upit($naredba);
                
                UpisiUDnevnik("Dodao novi eksponat: {$_POST['naziv']}");
                
                
                //sada pretplaćenim korisnicima šaljemo mail
                
                //dohvaćamo ID eksponata kako bi mogli napraviti link na novo dodani eksponat. Eksponat kojeg smo dodali ima najveći ID
                $naredba = "SELECT MAX(idEksponata) FROM eksponati";
                $rezultat = Upit($naredba);
                list($idEksponata) = $rezultat->fetch_array();
                
                //ako dodani eksponat nije skriven (vidljivost: privatno), pretplaćenim korisnicima šaljemo mail. Najprije dohvaćamo sve pretplaćene korisnike
                if ( $_POST['vidljivostEksponata'] < 2) {
                    $naredba = "SELECT ime, prezime, email FROM korisnici WHERE mailObavijesti = 1";
                    $rezultat = Upit($naredba);
                    
                    //šaljemo svakom pretplaćenom korisniku mail
                    while ($korisnik = $rezultat->fetch_assoc()) {
                        $to = $korisnik['email'];
                        $subject = "Virtualni muzej - novi eksponat";
                        
                        $body = "<html><head><title>Dobili smo novi eksponat: {$_POST['naziv']}</title></head>";
                        $body .= "<body>Poštovani/a {$korisnik['ime']} {$korisnik['prezime']}, <br><br>";
                        $body .= "obaviještavamo vas da smo u virtualni muzej dodali novi eskponat, <b>{$_POST['naziv']}</b>. <br>";
                        $body .= "Možete ga pregledati klikom na <a href='http://arka.foi.hr/WebDiP/2012_projekti/WebDiP2012_073/php/eksponati.php?eksponat=$idEksponata'>ovaj</a> link. <br><br>";
                        $body .= "Srdačan pozdrav, <br> Vaš virtualni muzej </body></html>";
                        
                        $headers  = 'MIME-Version: 1.0' . "\r\n";
                        $headers .= 'Content-type: text/html; charset=utf-8' . "\r\n";

                        mail($to, $subject, $body, $headers);
                    }
                }
            }
            
            
            if($_POST['sadrzaj'] == 'izlozba') {
                //ako nije odabran niti jedan eksponat, niti soba niti odjel za izložbu, vraćamo pogrešku
                if (count($_POST['eksponati']) == 0 && count($_POST['sobe']) == 0 && count($_POST['odjeli']) == 0) {
                    header("Location: error.php?e=nijeUnesenSadrzajIzlozbe"); die();
                }
                $vrijemeOtvaranja = VrijemeSPomakom( $_POST['vrijemeOtvaranja'] );
                $vrijemeZatvaranja = VrijemeSPomakom( $_POST['vrijemeZatvaranja'] );
                
                $naredba = "INSERT INTO kalendarizlozbi VALUES (DEFAULT, '{$_POST['nazivIzlozbe']}', '$vrijemeOtvaranja', '$vrijemeZatvaranja', {$_POST['cijenaIzlozbe']})";
                Upit($naredba);
                UpisiUDnevnik("Stvorio novu izložbu s nazivom: {$_POST['nazivIzlozbe']}");
                
                //dohvaćamo ID izlozbe kako bi mogli napraviti link na novo dodanu izlozbu. Izlozba koju smo dodali ima najveći ID
                $naredba = "SELECT MAX(brojIzlozbe) FROM kalendarizlozbi";
                $rezultat = Upit($naredba);
                list($brojIzlozbe) = $rezultat->fetch_array();
                
                //ako su odabrani eksponati za izlozbu
                if ( count($_POST['eksponati']) > 0) {
                    $aktivnost = "U izložbu s nazivom \"{$_POST['nazivIzlozbe']}\" dodao eksponate: ";
                    
                    // umećemo nove eksponate koji su odabrani u obrascu
                    foreach ($_POST['eksponati'] as $idEksponata) {
                        $naredba = "INSERT INTO pristupeksponatima VALUES ($idEksponata, $brojIzlozbe)";
                        Upit($naredba);
                        
                        $rezultat = Upit("SELECT naziv FROM eksponati WHERE idEksponata = $idEksponata");
                        list($nazivEksponata) = $rezultat->fetch_array();
                        $aktivnost .= "\"" . $nazivEksponata . "\", ";
                    }
                    UpisiUDnevnik($aktivnost);
                }
                
                
                //ako su odabrane sobe za izložbu
                if ( count($_POST['sobe']) > 0) {
                    $aktivnost = "U izložbu s nazivom \"{$_POST['nazivIzlozbe']}\" dodao sobe: ";
                    
                    //umećemo nove sobe koje su odabrane u obrascu
                    foreach ($_POST['sobe'] as $brojSobe) {
                        $naredba = "INSERT INTO pristupsobama VALUES ($brojSobe, $brojIzlozbe)";
                        Upit($naredba);
                        
                        $rezultat = Upit("SELECT nazivSobe FROM sobe WHERE brojSobe = $brojSobe");
                        list($nazivSobe) = $rezultat->fetch_array();
                        $aktivnost .= "\"" . $nazivSobe . "\", ";
                    }
                    UpisiUDnevnik($aktivnost);
                }
                
                
                //ako su odabrani odjeli za izložbu
                if ( count($_POST['odjeli']) > 0) {
                    $aktivnost = "U izložbu s nazivom \"{$_POST['nazivIzlozbe']}\" dodao odjele: ";
                    
                    // umećemo nove odjele koji su odabrani u obrascu
                    foreach ($_POST['odjeli'] as $brojOdjela) {
                        $naredba = "INSERT INTO pristupodjelima VALUES ($brojOdjela, $brojIzlozbe)";
                        Upit($naredba);
                        
                        $rezultat = Upit("SELECT nazivOdjela FROM odjeli WHERE brojOdjela = $brojOdjela");
                        list($nazivOdjela) = $rezultat->fetch_array();
                        $aktivnost .= "\"" . $nazivOdjela . "\", ";
                    }
                    UpisiUDnevnik($aktivnost);
                }
                
                
                //dohvaćamo pretplaćene korisnike kako bi im mogli poslati mail
                $naredba = "SELECT ime, prezime, email FROM korisnici WHERE mailObavijesti = 1";
                $rezultat = Upit($naredba);

                //šaljemo svakom pretplaćenom korisniku mail
                while ($korisnik = $rezultat->fetch_assoc()) {
                    $to = $korisnik['email'];
                    $subject = "Virtualni muzej - otvorena je nova izložba";

                    $body = "<html><head><title>Otvorena je nova izložba: {$_POST['nazivIzlozbe']}</title></head>";
                    $body .= "<body>Poštovani/a {$korisnik['ime']} {$korisnik['prezime']}, <br><br>";
                    $body .= "obaviještavamo vas da smo u virtualnom muzeju otvorili novu izložbu pod nazivom, <b>{$_POST['nazivIzlozbe']}</b>. <br>";
                    $body .= "Možete kupiti ulaznicu za nju po cijeni od {$_POST['cijenaIzlozbe']} kn, klikom na <a href='http://arka.foi.hr/WebDiP/2012_projekti/WebDiP2012_073/izlozbe.php'>ovaj</a> link. <br><br>";
                    $body .= "Srdačan pozdrav, <br> Vaš virtualni muzej </body></html>";

                    $headers  = 'MIME-Version: 1.0' . "\r\n";
                    $headers .= 'Content-type: text/html; charset=utf-8' . "\r\n";

                    mail($to, $subject, $body, $headers);
                }
            }
        }
        
        if ($_POST['action'] == 'uredi') {
            //ako se radi o obrascu za sobu
            if ($_POST['sadrzaj'] == 'odjel') {
                $naredba = "UPDATE odjeli SET nazivOdjela = '{$_POST['nazivOdjela']}', opisOdjela = '{$_POST['opisOdjela']}', vidljivostOdjela = {$_POST['vidljivostOdjela']} WHERE brojOdjela = {$_POST['brojOdjela']}";
                Upit($naredba);
                UpisiUDnevnik("Uredio postojeći odjel: {$_POST['nazivOdjela']}");
            }

            if ($_POST['sadrzaj'] == 'soba') {
                $naredba = "UPDATE sobe SET nazivSobe = '{$_POST['nazivSobe']}', Odjel = {$_POST['Odjel']}, vidljivostSobe = {$_POST['vidljivostSobe']} WHERE brojSobe = {$_POST['brojSobe']}";
                Upit($naredba);
                UpisiUDnevnik("Uredio postojeću sobu: {$_POST['nazivSobe']}");
            }
            
            if ($_POST['sadrzaj'] == 'eksponat') {
                //ako je korisnik odabrao sliku za upload
                if ( !empty($_FILES['slika']['name']) ) {
                    //uploadamo novu sliku (koju je korisnik odabrao)
                    $imeNoveSlike = UploadSlike();
                    //potom brišemo staru sliku (ako ona postoji) i njezin thumbnail
                    unlink("../slike/{$_POST['staraSlika']}");
                    unlink("../slike/thumbs/{$_POST['staraSlika']}");
                    //i stvaramo upit
                    //ako neka od polja nisu unesena, postavljamo ih na prazan string (kako ne bi bilo grešaka prilikom unosa u bazu)
                    $naredba = "UPDATE eksponati SET naziv = '{$_POST['naziv']}', opisEksponata = '{$_POST['opisEksponata']}', godinaPorijekla = ". (empty($_POST['godinaPorijekla']) ? 'NULL' : $_POST['godinaPorijekla']) .", prijeKrista = ". (empty($_POST['prijeKrista']) ? 'DEFAULT' : $_POST['prijeKrista']) .", slika = '$imeNoveSlike', soba = {$_POST['soba']}, OAutoru = ". (empty($_POST['OAutoru']) ? 'NULL' : "'{$_POST['OAutoru']}'") .", Orazdoblju = ". (empty($_POST['Orazdoblju']) ? 'NULL' : "'{$_POST['Orazdoblju']}'") .", kljucneRijeci = ". (empty($_POST['kljucneRijeci']) ? 'NULL' : "'{$_POST['kljucneRijeci']}'") .", vidljivostEksponata = {$_POST['vidljivostEksponata']} WHERE idEksponata = {$_POST['idEksponata']}";
                    UpisiUDnevnik("Uredio postojeći eksponat: {$_POST['naziv']}");
                }
                //ako korisnik nije odabrao sliku za upload
                else {
                    //samo stvaramo upit koji će ažurirati sve podatke osim slike
                    $naredba = "UPDATE eksponati SET naziv = '{$_POST['naziv']}', opisEksponata = '{$_POST['opisEksponata']}', godinaPorijekla = ". (empty($_POST['godinaPorijekla']) ? 'NULL' : $_POST['godinaPorijekla']) .", prijeKrista = ". (empty($_POST['prijeKrista']) ? 'DEFAULT' : $_POST['prijeKrista']) .", soba = {$_POST['soba']}, OAutoru = ". (empty($_POST['OAutoru']) ? 'NULL' : "'{$_POST['OAutoru']}'") .", Orazdoblju = ". (empty($_POST['Orazdoblju']) ? 'NULL' : "'{$_POST['Orazdoblju']}'") .", kljucneRijeci = ". (empty($_POST['kljucneRijeci']) ? 'NULL' : "'{$_POST['kljucneRijeci']}'") .", vidljivostEksponata = {$_POST['vidljivostEksponata']} WHERE idEksponata = {$_POST['idEksponata']}";
                    UpisiUDnevnik("Uredio postojeći eksponat: {$_POST['naziv']}");
                }
                
                Upit($naredba);
            }
            
            if($_POST['sadrzaj'] == 'izlozba') {
                //ako nije odabran niti jedan eksponat, niti soba niti odjel za izložbu, vraćamo pogrešku
                if (count($_POST['eksponati']) == 0 && count($_POST['sobe']) == 0 && count($_POST['odjeli']) == 0) {
                    header("Location: error.php?e=nijeUnesenSadrzajIzlozbe"); die();
                }
                $vrijemeOtvaranja = VrijemeSPomakom( $_POST['vrijemeOtvaranja'] );
                $vrijemeZatvaranja = VrijemeSPomakom(  $_POST['vrijemeZatvaranja'] );
                
                $naredba = "UPDATE kalendarizlozbi SET nazivIzlozbe = '{$_POST['nazivIzlozbe']}', vrijemeOtvaranja = '$vrijemeOtvaranja', vrijemeZatvaranja = '$vrijemeZatvaranja', cijenaIzlozbe = {$_POST['cijenaIzlozbe']} WHERE brojIzlozbe = {$_POST['brojIzlozbe']}";
                Upit($naredba);
                UpisiUDnevnik("Uredio postojeću izložbu: {$_POST['nazivIzlozbe']}");
                
                
                //najprije brišemo sve postojeće eksponate za tu izložbu
                $naredba = "DELETE FROM pristupeksponatima WHERE izlozba = {$_POST['brojIzlozbe']}";
                Upit($naredba);
                //ako su odabrani eksponati za izlozbu
                if ( count($_POST['eksponati']) > 0) {
                    $aktivnost = "Iz izložbe s nazivom \"{$_POST['nazivIzlozbe']}\" uklonio sve eksponate i dodao: ";
                    
                    //potom umećemo nove eksponate koji su odabrani u obrascu
                    foreach ($_POST['eksponati'] as $idEksponata) {
                        $naredba = "INSERT INTO pristupeksponatima VALUES ($idEksponata, {$_POST['brojIzlozbe']})";
                        Upit($naredba);
                        
                        $rezultat = Upit("SELECT naziv FROM eksponati WHERE idEksponata = $idEksponata");
                        list($nazivEksponata) = $rezultat->fetch_array();
                        $aktivnost .= "\"" . $nazivEksponata . "\", ";
                    }
                    UpisiUDnevnik($aktivnost);
                }
                
                
                //najprije brišemo sve postojeće sobe za tu izložbu
                $naredba = "DELETE FROM pristupsobama WHERE izlozba = {$_POST['brojIzlozbe']}";
                Upit($naredba);
                //ako su odabrane sobe za izložbu
                if ( count($_POST['sobe']) > 0) {
                    $aktivnost = "Iz izložbe s nazivom \"{$_POST['nazivIzlozbe']}\" uklonio sve sobe i dodao: ";
                    
                    //potom umećemo nove sobe koje su odabrani u obrascu
                    foreach ($_POST['sobe'] as $brojSobe) {
                        $naredba = "INSERT INTO pristupsobama VALUES ($brojSobe, {$_POST['brojIzlozbe']})";
                        Upit($naredba);
                        
                        $rezultat = Upit("SELECT nazivSobe FROM sobe WHERE brojSobe = $brojSobe");
                        list($nazivSobe) = $rezultat->fetch_array();
                        $aktivnost .= "\"" . $nazivSobe . "\", ";
                    }
                    UpisiUDnevnik($aktivnost);
                }
                
                //najprije brišemo sve postojeće odjele za tu izložbu
                $naredba = "DELETE FROM pristupodjelima WHERE izlozba = {$_POST['brojIzlozbe']}";
                Upit($naredba);
                //ako su odabrani odjeli za izložbu
                if ( count($_POST['odjeli']) > 0) {
                    $aktivnost = "Iz izložbe s nazivom \"{$_POST['nazivIzlozbe']}\" uklonio sve odjele i dodao: ";
                    
                    //potom umećemo nove odjele koji su odabrani u obrascu
                    foreach ($_POST['odjeli'] as $brojOdjela) {
                        $naredba = "INSERT INTO pristupodjelima VALUES ($brojOdjela, {$_POST['brojIzlozbe']})";
                        Upit($naredba);
                        
                        $rezultat = Upit("SELECT nazivOdjela FROM odjeli WHERE brojOdjela = $brojOdjela");
                        list($nazivOdjela) = $rezultat->fetch_array();
                        $aktivnost .= "\"" . $nazivOdjela . "\", ";
                    }
                    UpisiUDnevnik($aktivnost);
                }
            }
        }
        
        if ($_POST['action'] == 'obrisi') {
            if ($_POST['sadrzaj'] == 'odjel') {
                //najprije dohvaćamo naziv odjela koji se briše kako bi ga mogli zapisati u log
                $rezultat = Upit("SELECT nazivOdjela FROM odjeli WHERE brojOdjela = {$_POST['brojOdjela']}");
                list($nazivOdjela) = $rezultat->fetch_array();
                
                $naredba = "DELETE FROM odjeli WHERE brojOdjela = {$_POST['brojOdjela']}";
                Upit($naredba);
                
                UpisiUDnevnik("Obrisao odjel s nazivom: $nazivOdjela");
            }
            
            if($_POST['sadrzaj'] == 'soba') {
                //najprije dohvaćamo naziv sobe koja se briše kako bi ju mogli zapisati u log
                $rezultat = Upit("SELECT nazivSobe FROM sobe WHERE brojSobe = {$_POST['brojSobe']}");
                list($nazivSobe) = $rezultat->fetch_array();
                
                $naredba = "DELETE FROM sobe WHERE brojSobe = {$_POST['brojSobe']}";
                Upit($naredba);
                
                UpisiUDnevnik("Obrisao sobu s nazivom: $nazivSobe");
            }
            
            if($_POST['sadrzaj'] == 'eksponat') {
                //najprije dohvaćamo naziv eksponata koji se briše kako bi ga mogli zapisati u log
                $rezultat = Upit("SELECT naziv FROM eksponati WHERE idEksponata = {$_POST['idEksponata']}");
                list($nazivEksponata) = $rezultat->fetch_array();
                
                $naredba = "DELETE FROM eksponati WHERE idEksponata = {$_POST['idEksponata']}";
                Upit($naredba);
                
                UpisiUDnevnik("Obrisao eksponat s nazivom: $nazivEksponata");
            }
            
            if($_POST['sadrzaj'] == 'izlozba') {
                //najprije dohvaćamo naziv izložbe koja se briše kako bi ju mogli zapisati u log
                $rezultat = Upit("SELECT nazivIzlozbe FROM kalendarizlozbi WHERE brojIzlozbe = {$_POST['brojIzlozbe']}");
                list($nazivIzlozbe) = $rezultat->fetch_array();
                
                $naredba = "DELETE FROM kalendarizlozbi WHERE brojIzlozbe = {$_POST['brojIzlozbe']}";
                Upit($naredba);
                
                UpisiUDnevnik("Obrisao izložbu s nazivom: $nazivIzlozbe");
            }
        }
        
        if ($_POST['sadrzaj'] == 'izlozba') {
            header("Location: ../izlozbe.php"); die();
        } else {
            header("Location: ../odjeli_sobe.php"); die();
        }
    }
?>
<?php
    function DohvatiSveOdjele($dohvatiSveSobe = false) {
        $naredba = "SELECT brojOdjela, nazivOdjela FROM odjeli ORDER BY 2";
        
        if ($dohvatiSveSobe != false)
            $naredba = $dohvatiSveSobe;
        
        $rezultat = Upit($naredba);
        
        $sviOdjeli = null;
        while ($odjel = $rezultat->fetch_array()) {
            $sviOdjeli[] = $odjel;
        }
        return $sviOdjeli;
    }
    
    
    
    function DohvatiSveSobe() {
        $naredba = "SELECT brojSobe, nazivSobe FROM sobe ORDER BY 2";
        //pozivamo funkciju DohvatiSveOdjele s upitom za dohvat svih soba. To možemo učiniti jer je struktura ove dvije funkcije ISTA
        return DohvatiSveOdjele($naredba);
        
    }
    
    
    //ako argument brojIzlozbe nije proslijeđen, znači da stvaramo novu izložbu, i trebamo samo dohvatit sve postojeće eksponate, sobe i odjele.
    //Ako je argument proslijeđen, znači da izložba već postoji i onda za nju još dohvaćamo i sve one eksponate, odjele i sobe koji se trenutno nalaze u njoj
    function DohvatiSadrzajIzlozbe($brojIzlozbe=null) {
        $sadrzajIzlozbe = null;
        
        //dohvaćamo sve eksponate
        $naredba = "SELECT idEksponata, naziv FROM eksponati ORDER BY 2";
        $rezultat = Upit($naredba);
        
        while ($eksponat = $rezultat->fetch_assoc()) {
            if ($brojIzlozbe != null) {
                //za svaki dohvaćeni eksponat provjeravamo jel se on trenutno nalazi u izložbi
                $naredba = "SELECT eksponat FROM pristupeksponatima WHERE izlozba = $brojIzlozbe AND eksponat = {$eksponat['idEksponata']}";
                $rezultatPodupit = Upit($naredba);

                if ($rezultatPodupit->fetch_array()) {
                    $eksponat['dioIzlozbe'] = TRUE;
                } else {
                    $eksponat['dioIzlozbe'] = FALSE;
                }
            }
            
            $sadrzajIzlozbe['eksponati'][] = $eksponat;
        }
        
        
        
        //dohvaćamo sve sobe
        $naredba = "SELECT brojSobe, nazivSobe FROM sobe ORDER BY 2";
        $rezultat = Upit($naredba);
        
        while ($soba = $rezultat->fetch_assoc()) {
            if ($brojIzlozbe != null) {
                //za svaku dohvaćenu sobu provjeravamo jel se ona trenutno nalazi u izložbi
                $naredba = "SELECT soba FROM pristupsobama WHERE izlozba = $brojIzlozbe AND soba = {$soba['brojSobe']}";
                $rezultatPodupit = Upit($naredba);

                if ($rezultatPodupit->fetch_array()) {
                    $soba['dioIzlozbe'] = TRUE;
                } else {
                    $soba['dioIzlozbe'] = FALSE;
                }
            }
            
            $sadrzajIzlozbe['sobe'][] = $soba;
        }
        
        
        //dohvaćamo sve odjele
        $naredba = "SELECT brojOdjela, nazivOdjela FROM odjeli ORDER BY 2";
        $rezultat = Upit($naredba);
        
        while ($odjel = $rezultat->fetch_assoc()) {
            if ($brojIzlozbe != null) {
                //za svaki dohvaćeni odjel provjeravamo jel se on trenutno nalazi u izložbi
                $naredba = "SELECT odjel FROM pristupodjelima WHERE izlozba = $brojIzlozbe AND odjel = {$odjel['brojOdjela']}";
                $rezultatPodupit = Upit($naredba);

                if ($rezultatPodupit->fetch_array()) {
                    $odjel['dioIzlozbe'] = TRUE;
                } else {
                    $odjel['dioIzlozbe'] = FALSE;
                }
            }
            
            $sadrzajIzlozbe['odjeli'][] = $odjel;
        }
        
        return $sadrzajIzlozbe;
    }
    
    
    
    function UploadSlike() {
        $datoteka = $_FILES["slika"]["tmp_name"];
        $ime = $_FILES["slika"]["name"];
        $tip = $_FILES["slika"]["type"];
        $greska = $_FILES["slika"]["error"];
        
        $je_slika = NULL;
        $nemoguce_premjestiti = NULL;
        $datoteka_uploadana = NULL;
        //na svaku sliku ćemo dodati unix timestamp da se ne bi dogodilo da se dodaju dvije slike s istim imenom
        $prefiks_slike = time();

        if ($greska > 0) {
            switch ($greska) {
                case 1: header("Location: error.php?e=prekoracenaVelicinaDatotekeServer"); die(); break;
                case 2: header("Location: error.php?e=prekoracenaDopustenaVelicinaDatoteke"); die(); break;
                case 3: header("Location: error.php?e=datotekaNijePosveUploadana"); die(); break;
                case 4: header("Location: datotekaNijeUploadana"); die(); break;
            }
        } else {
            $je_slika = preg_match("/^image\/[(jpeg)|(gif)|(png)]/", $tip);
            if ($je_slika) {
                if (!move_uploaded_file($datoteka, "../slike/$prefiks_slike.$ime")) {
                    header("Location: error.php?e=datotekuNemogucePremjestiti");
                    die();
                }

                list($width, $height) = getimagesize("../slike/$prefiks_slike.$ime");
                $newwidth = 200;
                $newheight = round($height / ($width / $newwidth));
                $thumb = imagecreatetruecolor($newwidth, $newheight);

                switch ($tip) {
                    case "image/jpeg": $source = imagecreatefromjpeg("../slike/$prefiks_slike.$ime"); break;
                    case "image/gif": $source = imagecreatefromgif("../slike/$prefiks_slike.$ime"); break;
                    case "image/png": $source = imagecreatefrompng("../slike/$prefiks_slike.$ime"); break;
                }


                imagecopyresized($thumb, $source, 0, 0, 0, 0, $newwidth, $newheight, $width, $height);
                
                switch ($tip) {
                    case "image/jpeg" : imagejpeg($thumb, "../slike/thumbs/$prefiks_slike.$ime"); break;
                    case "image/gif" : imagegif($thumb, "../slike/thumbs/$prefiks_slike.$ime"); break;
                    case "image/png" : imagepng($thumb, "../slike/thumbs/$prefiks_slike.$ime"); break;
                }
            } else {
                header("Location: error.php?e=datotekaNijeSlika");
                die();
            }
        }
        
        return "$prefiks_slike.$ime";
    }
?>
<?php
    require_once '../prilozi/smarty.php';
    
    if ($_GET['action'] == 'uredi') {
        if ($_GET['sadrzaj'] == 'odjel') {
            $smarty->assign('odjel', $odjel);
        }
        
        if ($_GET['sadrzaj'] == 'soba') {
            $smarty->assign('soba', $soba);
            $smarty->assign('odjeli', $sviOdjeli);
        }
        
        if ($_GET['sadrzaj'] == 'eksponat') {
            $smarty->assign('eksponat', $eksponat);
            $smarty->assign('sobe', $sveSobe);
        }
        
        if ($_GET['sadrzaj'] == 'izlozba') {
            $smarty->assign('izlozba', $izlozba);
            $smarty->assign('sadrzajIzlozbe', $sadrzajIzlozbe);
        }
        
        
    }
    
    
    if ($_GET['action'] == 'dodaj') {
        if ($_GET['sadrzaj'] == 'soba') {
            $smarty->assign('odjeli', $sviOdjeli);
        }
        
        if ($_GET['sadrzaj'] == 'eksponat') {
            $smarty->assign('sobe', $sveSobe);
        }
        
        if ($_GET['sadrzaj'] == 'izlozba') {
            $smarty->assign('sadrzajIzlozbe', $sadrzajIzlozbe);
        }
    }
    
    $smarty->display('php/uredi_sadrzaj.tpl');
?>