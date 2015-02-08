<?php 
    ob_start();
    session_start();
?>

<?php
    require_once 'db_connect.php';
    require_once 'biljezenje_lib.php';

    if ($_GET["logout"] == '1') {
        UpisiUDnevnik("Odjava sa sustava (korisnik: {$_SESSION['username']})");
        session_destroy(); 
        session_start();
        $_SESSION['tip'] = 0;
    } else {
        if (isset($_COOKIE["username"]) && ! isset($_POST["rememberme"])) {
            setcookie("username",$_POST["username"],1, "/");
        } else {
            setcookie("username",$_POST["username"],time()+60*60, "/");
        }

        $korisnicki_racun_zakljucan = false;
        $max_broj_prijava = false;
        $korisnicki_racun_aktiviran = true;

        $naredba = "select idKorisnika, korime, aktiviran, zakljucan, tipKorisnika FROM korisnici WHERE korime='{$_POST['username']}' AND lozinka='{$_POST['password']}'";
        $rezultat = Upit($naredba);
        $korisnik = $rezultat->fetch_assoc();

        if ($rezultat->num_rows == 1) {
            if ($korisnik["aktiviran"] == 0) {
                $korisnicki_racun_aktiviran = false;
                UpisiUDnevnik("Pokušao se ulogirati na korisničko ime \"{$korisnik['korime']}\", ali taj nije bio aktiviran");
            } else {
                if ($korisnik["zakljucan"] == 1) {
                    $korisnicki_racun_zakljucan = true;
                    UpisiUDnevnik("Pokušao se ulogirati na korisničko ime \"{$korisnik['korime']}\", ali je taj korisnički račun zaključan");
                } else {
                    $_SESSION["username"] = $_POST['username'];
                    $_SESSION["tip"] = $korisnik["tipKorisnika"];
                    $_SESSION["idKorisnika"] = $korisnik["idKorisnika"];
                    Upit("UPDATE korisnici SET neuspjesnePrijave = 0 WHERE korime = '{$_POST['username']}'");
                    Upit("UPDATE korisnici SET brojPrijava = brojPrijava + 1 WHERE korime = '{$_POST['username']}'");
                    UpisiUDnevnik("Prijavio se na sustav");
                    header("Location: ../odjeli_sobe.php"); die();
                }
            }
        }
        else {
            Upit("UPDATE korisnici SET neuspjesnePrijave = neuspjesnePrijave + 1 WHERE korime = '{$_POST['username']}'");
            $rezultat = Upit("SELECT neuspjesnePrijave FROM korisnici WHERE korime = '{$_POST['username']}'");
            $neuspjesnePrijave = $rezultat->fetch_array();
            $neuspjesnePrijave = $neuspjesnePrijave[0];
            UpisiUDnevnik("Pokušao se prijaviti u sustav s krivim korisničkim podacima (upisano korisničko ime: {$_POST['username']}). Pokušaj prijave: $neuspjesnePrijave");
            
            if ($neuspjesnePrijave == 3) {
                Upit("UPDATE korisnici SET zakljucan=1 where korime='" . $_POST['username'] ."'");
                $max_broj_prijava = true;
                UpisiUDnevnik("Pokušao se prijaviti tri puta s krivim korisničkim podacima (upisano korisničko ime: {$_POST['username']}) - korisnički račun zaključan!");
            }
        }
    }
?>
      
<?php 
    require_once '../prilozi/smarty.php';
    
    $smarty->assign('aktiviran',$korisnicki_racun_aktiviran);
    $smarty->assign('zakljucan',$korisnicki_racun_zakljucan);
    $smarty->assign('max_broj_prijava',$max_broj_prijava);
    $smarty->assign('brojNeuspjesnihPrijava', $neuspjesnePrijave);
    
    $smarty->display("php/ulogiraj_se.tpl");
?>