<?php 
    session_start();
    require_once 'biljezenje_lib.php';

    $korisnikOtprijeAktiviran = null;
    $vrijemeIsteklo = null;
    $korisnikNePostoji = null;
    $aktivacijaUspjesna = null;

    function VrijemeIsteklo($vrijeme1, $vrijeme2) {
        $prva = strtotime($vrijeme1);
        $druga = strtotime($vrijeme2);

        $razlika = abs($prva - $druga);
        $sati = $razlika / 3600;

        if ($sati > 24) 
            return 1;   //vrijeme je isteklo. Nemoguće aktivirati
        else 
            return 0;
    }

    require_once 'db_connect.php';

    $naredba = "SELECT aktiviran, datum_registracije FROM korisnici WHERE idKorisnika = " . $_GET["id"];
    $rezultat = Upit($naredba);
    
    if (list($aktiviran, $datumRegistracije) = $rezultat->fetch_array())  //ako je funkcija vratila rezultat
    {
        //dohvaćamo korisničko ime za poslani id kako bi ga mogli unijeti u log
        $rezultat = Upit("SELECT korime FROM korisnici WHERE idKorisnika = {$_GET['id']}");
        $korime = $rezultat->fetch_assoc();
        
        if ($aktiviran == 1) 
        {
            $korisnikOtprijeAktiviran = "Taj korisnik je već aktiviran!";
            UpisiUDnevnik("Pokušao aktivirati korisnički račun koji već postoji (korisničko ime: {$korime['korime']})");
        }

        if (VrijemeIsteklo($datumRegistracije, VrijemeSPomakom() )) 
        {
            $vrijemeIsteklo = "Vrijeme za aktivaciju korisničkog računa je isteklo. Obratite se administratoru.";
            UpisiUDnevnik("Pokušao aktivirati korisnički račun kojem je vrijeme za aktivaciju isteklo (korisničko ime: {$korime['korime']})");
        } else {
            $naredba = "UPDATE korisnici SET aktiviran=1 WHERE idKorisnika = " . $_GET["id"];
            Upit($naredba);
            $aktivacijaUspjesna = "Aktivacija uspješna!";
            UpisiUDnevnik("Aktivirao korisnički račun ({$korime['korime']})");
        }

    } else {
        $korisnikNePostoji = "Taj korisnik nije registriran!";
        UpisiUDnevnik("Pokušao aktivirati korisnički račun korisnika koji ne postoji. Proslijeđeni ID: {$_GET['id']}");
    }
?>

<?php
    require_once '../prilozi/smarty.php';

    if ($korisnikOtprijeAktiviran != null)
        $smarty->assign('korisnikOtprijeAktiviran', $korisnikOtprijeAktiviran);
    elseif ($korisnikNePostoji != null)
        $smarty->assign('korisnikNePostoji', $korisnikNePostoji);
    elseif ($vrijemeIsteklo != null)
        $smarty->assign('vrijemeIsteklo', $vrijemeIsteklo);
    else
        $smarty->assign('aktivacijaUspjesna', $aktivacijaUspjesna);
    
    $smarty->display('php/aktivacija_korisnika.tpl');
?>