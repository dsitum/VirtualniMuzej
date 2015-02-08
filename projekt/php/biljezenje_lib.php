<?php
    function VrijemeSPomakom($vrijeme=null) {
        //ako nismo argumentom poslali vrijeme u STRING formatu, uzimamo trenutno vrijeme
        if ($vrijeme == null)
            $vrijeme = time();
        else
            $vrijeme = strtotime($vrijeme);

        //dohvaćamo pomak vremena iz baze podataka
        $rezultat = Upit("SELECT pomak FROM pomakVremena");
        
        if ($pomak = $rezultat->fetch_assoc()) {
            $pomak = $pomak['pomak'];
        } else {
            $pomak = 0;
        }
            
        $vrijeme += $pomak;
        
        return date("Y-m-d H:i:s", $vrijeme);
    }
    
    
    function UpisiUDnevnik($aktivnost) {
        require_once 'db_connect.php';
        
        $idKorisnika = ( isset($_SESSION['idKorisnika']) ? $_SESSION['idKorisnika'] : 'NULL' );
        $vrijeme = VrijemeSPomakom();
        $ipAdresa = $_SERVER['REMOTE_ADDR'];
        $preglednik = $_SERVER['HTTP_USER_AGENT'];
        
        $naredba = "INSERT INTO log VALUES (DEFAULT, $idKorisnika, '$aktivnost', '$vrijeme', '$ipAdresa', '$preglednik')";
        Upit($naredba);
    }
?>
