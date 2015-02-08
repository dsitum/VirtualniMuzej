<?php
    session_start();
    
    require_once 'biljezenje_lib.php';
    
    //ako korisnik nije ulogiran, redirect
    if ( !isset($_SESSION["username"]) ) {
        UpisiUDnevnik("Nelogirani korisnik pokušao promijeniti tuđe korisničke podatke");
        header("Location: ../login.php"); die();
    }
    
    //ako korisnik ne pokušava uređivati vlastite podatke i nije administrator
    if ($_GET['id'] != $_SESSION['idKorisnika'] && $_SESSION["tip"] != 3) {
        UpisiUDnevnik("Pokušao uređivati korisničke podatke drugog korisnika.");
        header("Location: ../ispis_korisnika.php");
    }

    require_once 'db_connect.php';
    
    $naredba = "SELECT * FROM korisnici WHERE idKorisnika = {$_GET['id']}";
    $rezultat = Upit($naredba);
    $podaci = $rezultat->fetch_array();
?>

<?php
    require_once '../prilozi/smarty.php';
    
    $smarty->assign('podaci', $podaci);
    
    $smarty->display('php/uredi_korisnika.tpl');
?>