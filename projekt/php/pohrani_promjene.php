<?php
    session_start();
    require_once 'db_connect.php';
    require_once 'biljezenje_lib.php';

    //ako korisnik koji je mijenjao podatke korisnika NIJE administrator, to znači da on neka polja nije mogao ni popuniti (tipa "zaključan") pa je naredba nešto skraćena
    if ($_SESSION['tip'] != 3) {
        $naredba = "UPDATE korisnici SET korime='" . $_POST["username"] . "', prezime='" . $_POST["prezime"]
                . "', ime='" . $_POST["ime"] . "', email='" . $_POST["email"] . "', lozinka='" . $_POST["password"]
                . "', telefon='" . $_POST["telefon"] . "', grad='" . $_POST["grad"]
                . "', zivotopis='" . $_POST["zivotopis"] . "', datum_rodjenja='" . $_POST["datumrodjenja"]
                . "', spol='" . $_POST["spol"] . "', mailObavijesti=" . $_POST["obavijest"]
                . " WHERE idKorisnika = '" . $_GET["id"] . "'";
        
        UpisiUDnevnik("Uredio vlastite korisničke podatke");
    } 
    else {
        $naredba = "UPDATE korisnici SET korime='" . $_POST["username"] . "', prezime='" . $_POST["prezime"]
                . "', ime='" . $_POST["ime"] . "', email='" . $_POST["email"] . "', lozinka='" . $_POST["password"]
                . "', telefon='" . $_POST["telefon"] . "', grad='" . $_POST["grad"]
                . "', zivotopis='" . $_POST["zivotopis"] . "', datum_rodjenja='" . $_POST["datumrodjenja"]
                . "', spol='" . $_POST["spol"] . "', mailObavijesti=" . $_POST["obavijest"]
                . ", tipKorisnika=" . $_POST["tipKorisnika"] . ", aktiviran=" . $_POST["aktiviran"] 
                . ", zakljucan=" . $_POST["zakljucan"] . " WHERE idKorisnika = " . $_GET["id"];
        
        
        //ako smo postavili korisnika na otključanog, resetiramo njegov broj krivih prijava
        if ($_POST['zakljucan'] == 0)
            Upit ("UPDATE korisnici SET neuspjesnePrijave = 0 WHERE idKorisnika = {$_GET["id"]}");
        
        UpisiUDnevnik("Uredio korisničke podatke korisnika: {$_POST['username']}");
    }

    Upit($naredba);
    
    //ako nije administrator korisnik koji je uređivao podatke, ažurirat ćemo ga u bazu
    if ($_SESSION['tip'] != 3) {
        if ($_SESSION['username'] != $_POST["username"]) {
            UpisiUDnevnik("Promijenio vlastito korisničko ime iz \"{$_SESSION['username']}\" u \"{$_POST['username']}\"");
            $_SESSION['username'] = $_POST["username"];
        }
    }
?>
     
<?php 
    require_once '../prilozi/smarty.php';
    
    $smarty->display("php/pohrani_promjene.tpl");
?>