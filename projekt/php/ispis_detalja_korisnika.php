<?php
    session_start();
    if (!isset($_SESSION["username"]))
            header("Location: ../login.php");
    
    require_once 'db_connect.php';
    
    $naredba = "SELECT * FROM korisnici JOIN tipkorisnika WHERE idKorisnika = " . $_GET["id"];
    $upit = new Upit();
    $rezultat = $upit->Izvrsi($naredba);
    unset($upit);
    $podaci = $rezultat->fetch_assoc();
?>

<?php
    require_once '../prilozi/smarty.php';
    
    if ($podaci["spol"] == 'm') $podaci["spol"] = 'Muški';
    else $podaci["spol"] = 'Ženski';
    
    if ($podaci["aktiviran"] == 1) $podaci["aktiviran"] = 'Da';
    else $podaci["aktiviran"] = 'Ne';
    
    if ($podaci["zakljucan"] == 1) $podaci["zakljucan"] = 'Da';
    else $podaci["zakljucan"] = 'Ne';
    
    $smarty->assign("korime", $podaci[korime]);
    $smarty->assign("ime", $podaci[ime]);
    $smarty->assign("prezime", $podaci[prezime]);
    $smarty->assign("email", $podaci[email]);
    $smarty->assign("telefon", $podaci[telefon]);
    $smarty->assign("grad", $podaci[grad]);
    $smarty->assign("zivotopis", $podaci[zivotopis]);
    $smarty->assign("datum_rodjenja", $podaci[datum_rodjenja]);
    $smarty->assign("spol", $podaci[spol]);
    $smarty->assign("datum_registracije", $podaci[datum_registracije]);
    $smarty->assign("aktiviran", $podaci[aktiviran]);
    $smarty->assign("tipKorisnika", $podaci[tip]);
    $smarty->assign("zakljucan", $podaci[zakljucan]);
    
    $smarty->display("php/ispis_detalja_korisnika.tpl");
?>