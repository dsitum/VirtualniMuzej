<?php
    session_start();
    require_once '../php/db_connect.php';    

    function IspisiTablicu() {
        $rezultat = DohvatiKorisnike();
        while ($korisnik = $rezultat->fetch_array()) {
            $korisnici[] = $korisnik;
        }
        return $korisnici;
    }
    
    
    function DohvatiKorisnike() {
        $naredba = "SELECT idKorisnika, korime, ime, prezime, lozinka, tip FROM korisnici JOIN tipkorisnika ON (tipKorisnika = brojTipa) ORDER BY korime";
        $rezultat = Upit($naredba);
        return $rezultat;
    }
?>

<?php 
    require_once '../prilozi/smarty.php';
    
    $korisnici = IspisiTablicu();
    $smarty->assign("korisnici", $korisnici);
    
    $smarty->display("php/korisnici.tpl");
?>